package com.multi.dorae.help;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AccessControlList;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.GroupGrantee;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.Permission;

@Controller
public class FileUploadController {
	
	final String endPoint = "https://kr.object.ncloudstorage.com";
	final String regionName = "kr-standard";
	final String accessKey = "4F2BDC69826967D37B65";
	final String secretKey = "DE6AAA53DEBADD68474D90821B631CB444D1E692";
	final String bucketName = "dorae.help.image";

	// S3 client
	final AmazonS3 s3 = AmazonS3ClientBuilder.standard()
	    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
	    .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
	    .build();

	//이미지 확장자를 담은 컨테이너
	final Set<String> exts = new HashSet<String>();
	
	@PostConstruct
	public void init() {
		exts.add("jpg");
		exts.add("png");
		exts.add("bmp");
		exts.add("gif");
	}
	
	// 네이버 오브젝트 스토리지에 저장
	@ResponseBody
	@RequestMapping(value = "imageUpload", method = RequestMethod.POST, produces = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_FORM_URLENCODED_VALUE})
	public void imageUpload(@RequestHeader("file-name") String fileName, HttpServletResponse response, HttpServletRequest request) throws Exception {
		System.out.println("call imageUpload fileName : " + fileName);
		
		try {		    
			//파일 확장자를 소문자로 가져오기
			String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

			//이미지가 아니라면
			if(!exts.contains(fileExt)) {
				PrintWriter print = response.getWriter();
				print.print("NOTALLOW_" + fileName);
				print.flush();
				print.close();
			} else {
				//파일경로
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
				String sFileName = formatter.format(new java.util.Date()) + UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
				
				ObjectMetadata objectMetadata = new ObjectMetadata();
				objectMetadata.setContentType("application/x-directory");
				objectMetadata.setContentLength(Long.parseLong(request.getHeader("file-size")));

				// upload local file
				try {
					s3.putObject(bucketName, sFileName, request.getInputStream(), objectMetadata);
				    System.out.format("Object %s has been created.\n", sFileName);
				} catch (AmazonS3Exception e) {
				    e.printStackTrace();
				} catch(SdkClientException e) {
				    e.printStackTrace();
				}
				
				// 업로드 된 객체(이미지)의 권한을 읽기로 설정
				// 문의 답변 주신분 감사합니다!!!
				// get the current ACL
				AccessControlList accessControlList = s3.getObjectAcl(bucketName, sFileName);
				// add read permission to anonymous
				accessControlList.grantPermission(GroupGrantee.AllUsers, Permission.Read);
				s3.setObjectAcl(bucketName, sFileName, accessControlList);
				
				// 정보 출력
				String sFileInfo = "&bNewLine=true";
				// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
				sFileInfo += "&sFileName=" + fileName;
				sFileInfo += "&sFileURL=" + "https://kr.object.ncloudstorage.com/" + bucketName + "/" + sFileName;
				PrintWriter printWriter = response.getWriter();
				printWriter.print(sFileInfo);
				printWriter.flush();
				printWriter.close();
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//	로컬에 저장
//	@ResponseBody
//	@RequestMapping(value = "imageUpload", method = RequestMethod.POST, produces = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_FORM_URLENCODED_VALUE})
//	public void imageUpload(@RequestHeader("file-name") String fileName, HttpServletResponse response, HttpServletRequest request) throws Exception {
//		System.out.println("call imageUpload fileName : " + fileName);
//		
//		try {
//			//파일 확장자를 소문자로 가져오기
//			String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
//			
//			//이미지 검증 배열변수
//			String[] extArr = {"jpg","png","bmp","gif"};
//			
//			//확장자 체크
//			int extCount = 0;
//			for(int i = 0; i < extArr.length; i++) {
//				if(fileExt.equals(extArr[i])){
//					extCount++;
//				}
//			}
//			
//			//이미지가 아니라면
//			if(extCount == 0) {
//				PrintWriter print = response.getWriter();
//				print.print("NOTALLOW_" + fileName);
//				print.flush();
//				print.close();
//			} else {
//				//디렉토리 설정 및 업로드	
//				
//				//파일경로
//				String uploadPath = "resources/upload";
//				System.out.println("톰캣 경로 : " + request.getSession().getServletContext().getRealPath(uploadPath));
//				String filePath = request.getSession().getServletContext().getRealPath(uploadPath);
//				File file = new File(filePath);
//				
//				if(!file.exists()) {
//					file.mkdirs();
//				}
//				
//				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
//				String sFileName = formatter.format(new java.util.Date()) + UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
//				
//				///////////////// 서버에 파일쓰기 ///////////////// 
//				InputStream inputStream = request.getInputStream();
//				OutputStream outputStream = new FileOutputStream(filePath + "/"+ sFileName);
//				
//				int readCount;
//				byte bytes[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
//				
//				while((readCount = inputStream.read(bytes, 0, bytes.length)) != -1){
//					outputStream.write(bytes, 0, readCount);
//				}
//				
//				if(inputStream != null) {
//					inputStream.close();
//				}
//				
//				outputStream.flush();
//				outputStream.close();
//				
//				// 정보 출력
//				String sFileInfo = "&bNewLine=true";
//				// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
//				sFileInfo += "&sFileName=" + fileName;
//				sFileInfo += "&sFileURL=" + "/dorae/" + uploadPath + "/" + sFileName;
//				PrintWriter printWriter = response.getWriter();
//				printWriter.print(sFileInfo);
//				printWriter.flush();
//				printWriter.close();
//			}	
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}
