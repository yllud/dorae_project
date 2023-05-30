package com.multi.dorae.help;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FileUploadController {
	
	@ResponseBody
	@RequestMapping(value = "imageUpload", method = RequestMethod.POST, produces = {MediaType.MULTIPART_FORM_DATA_VALUE, MediaType.APPLICATION_FORM_URLENCODED_VALUE})
	public void imageUpload(@RequestHeader("file-name") String fileName, HttpServletResponse response, HttpServletRequest request) throws Exception {
		System.out.println("call imageUpload fileName : " + fileName);
		
		try {
			//파일 확장자를 소문자로 가져오기
			String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			
			//이미지 검증 배열변수
			String[] extArr = {"jpg","png","bmp","gif"};

			//확장자 체크
			int extCount = 0;
			for(int i = 0; i < extArr.length; i++) {
				if(fileExt.equals(extArr[i])){
					extCount++;
				}
			}

			//이미지가 아니라면
			if(extCount == 0) {
				PrintWriter print = response.getWriter();
				print.print("NOTALLOW_" + fileName);
				print.flush();
				print.close();
			} else {
				//디렉토리 설정 및 업로드	
				
				//파일경로
				String uploadPath = "resources/upload";
				System.out.println("톰캣 경로 : " + request.getSession().getServletContext().getRealPath(uploadPath));
				String filePath = request.getSession().getServletContext().getRealPath(uploadPath);
				File file = new File(filePath);
				
				if(!file.exists()) {
					file.mkdirs();
				}
				
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
				String sFileName = formatter.format(new java.util.Date()) + UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
				
				///////////////// 서버에 파일쓰기 ///////////////// 
				InputStream inputStream = request.getInputStream();
				OutputStream outputStream = new FileOutputStream(filePath + "/"+ sFileName);
				
				int readCount;
				byte bytes[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
				
				while((readCount = inputStream.read(bytes, 0, bytes.length)) != -1){
					outputStream.write(bytes, 0, readCount);
				}
				
				if(inputStream != null) {
					inputStream.close();
				}

				outputStream.flush();
				outputStream.close();
				
				// 정보 출력
				String sFileInfo = "&bNewLine=true";
				// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
				sFileInfo += "&sFileName=" + fileName;
				sFileInfo += "&sFileURL=" + "/dorae/" + uploadPath + "/" + sFileName;
				PrintWriter printWriter = response.getWriter();
				printWriter.print(sFileInfo);
				printWriter.flush();
				printWriter.close();
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
