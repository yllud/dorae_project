package com.multi.dorae.login;


import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;



@Controller
public class NaverController {
	
	@Autowired
	NaverDAO dao;
	
	@Autowired
	private HttpSession session;
	

	@RequestMapping("login/naverLogin")
	public void login(NaverVO vo, Model model) {
		System.out.println(vo + "===================");
		int result =  dao.insert(vo);
		if (result != 0) {
			model.addAttribute("vo", vo);
			
		}else {
			
			model.addAttribute("result", result);
		}
	}
	
//	@RequestMapping("login/update")
//	public void update(NaverVO bag, Model model) {
//		System.out.println(bag);
//		int result = dao.update(bag);
//		if(result == 0) {
//			model.addAttribute("bag", bag);
//		}else {
//			model.addAttribute("result", result);
//		}
//	}

	
//	@RequestMapping("login/naverInsert")
//	public void insert(NaverVO bag) {
//		dao.insert(bag);
//	}
	@RequestMapping("login/uploadProfileImage")
	public String uploadProfileImage(@RequestParam("profileImage") MultipartFile file, NaverVO vo, Model model) {
	    if (!file.isEmpty()) {
	        try {
	            // 파일을 저장할 경로 설정
	            String uploadPath = "/path/to/upload/directory/";
	            String fileName = file.getOriginalFilename();
	            
	            // 파일을 지정된 경로에 저장
	            File uploadDir = new File(uploadPath);
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs(); // 디렉토리가 없으면 생성
	            }
	            String filePath = uploadPath + fileName;
	            File dest = new File(filePath);
	            file.transferTo(dest);
	            
	            // NaverVO에 파일 경로 설정
	            vo.setProfile_image(filePath);
	            
	            // NaverDAO를 통해 사진 정보를 DB에 저장
	            int result = dao.insertProfileImage(vo);
	            if (result > 0) {
	                model.addAttribute("success", true);
	                model.addAttribute("fileName", fileName);
	            } else {
	                model.addAttribute("success", false);
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	            model.addAttribute("success", false);
	        }
	    } else {
	        model.addAttribute("success", false);
	    }
	    
	    return "redirect:/mypage.jsp"; // 업로드 완료 후 리다이렉트
	}
}
