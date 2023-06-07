package com.multi.dorae.login;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.multi.dorae.review.ReviewVO;

@Controller
public class NaverController {
	
	@Autowired
	NaverDAO dao;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private ServletContext servletContext;
	

	@RequestMapping("login/naverLogin")
	public String login(NaverVO vo, Model model) {
	    System.out.println(vo + "===================");

	    // NaverVO에 있는 정보를 다 불러오려고 vo2 만들음
	    NaverVO vo2 = dao.login(vo);
	    model.addAttribute("vo2", vo2);

	    if (vo2 == null || vo2.getEmail() == null) { // vo2가 null이거나 email이 null인 경우 insert
	    	
	    	
	        int result = dao.insert(vo);
	        System.out.println(result);
	        if (result != 0) {
	            // 로그인 성공하면 session 잡아주기
	            session.setAttribute("email", vo.getEmail());
	            session.setAttribute("nickname", vo.getNickname());
	            session.setAttribute("user_type", vo2.getUser_type());

	            // 세션 유지 시간 설정 (옵션)
	            session.setMaxInactiveInterval(60 * 30); // 30분 동안 유지되도록 설정 (단위: 초)

	            return "redirect:../map/main.jsp"; // 로그인 성공 후 마이페이지로 리다이렉트
	        } else {
	            return "redirect:/login/login.jsp"; // 로그인 실패 시 로그인 페이지로 리다이렉트
	        }
	    } else {
	        session.setAttribute("email", vo.getEmail());
	        session.setAttribute("nickname", vo.getNickname());
	        session.setAttribute("user_type", vo2.getUser_type());

	        // 세션 유지 시간 설정 (옵션)
	        session.setMaxInactiveInterval(60 * 30); // 30분 동안 유지되도록 설정 (단위: 초)
	        
	     // visit_count 증가 처리
	        dao.updateVisitCount(vo.getEmail());
       	       
	        // 이전 페이지로 리다이렉트
	        String before = (String) session.getAttribute("before");
	        if (before != null) {
	            session.removeAttribute("previousUrl"); // 세션에서 이전 페이지 URL 제거
	            return "redirect:" + before;
	        } else {
	            // 기본 리다이렉션 페이지로 이동
	            return "redirect:../map/main.jsp";
	        }
	    }
	}
	
	// 로그인시 이전페이지로 이동
	@RequestMapping("login/before")
	public void before(HttpSession session, String before) {
		System.out.println(before);
		session.setAttribute("before", before);
	}
	
	 @RequestMapping("login/logout")
	    public String logout(Model model, HttpSession session) {
	        // 세션에서 로그인 정보 제거
	        session.removeAttribute("email");
	        // 세션 무효화
	        session.invalidate();
	        
	     // 로그아웃 후 처리할 코드
	        model.addAttribute("message", "로그아웃되었습니다.");
	        
	        // 로그아웃 후 리다이렉트할 페이지 반환
	        return "redirect:../login/login.jsp";
	    }
	
	 // 마이페이지 버튼 누르면 마이페이지로 이동하는 컨트롤러
	 @RequestMapping("login/mypage") //() 안에 마이페이지 주소 지정 localhost:8888/dorae/login/mypage가 주소
	 public String mypage(Model model) { //누를 때 마다 model로 DB 정보 검색해서 불러와야 함
		 NaverVO vo2 = dao.one((String)session.getAttribute("email"));
		 model.addAttribute("vo2", vo2);
		 return "mypage/mypage";
	}
	 
	 
	 @RequestMapping("mypage/uploadProfile")
	 public String uploadProfile(NaverVO naverVO, @RequestParam("file") MultipartFile file, Model model) {
		 try {
		        if (!file.isEmpty()) {
		            String savedName = file.getOriginalFilename();
		            String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
		            File target = new File(uploadPath + "/" + savedName);
		            file.transferTo(target);
		            String email = (String) session.getAttribute("email");
		            
		            // 파일의 저장 경로와 파일명을 조합한 링크를 생성하여 저장
		            String fileLink = request.getContextPath() + "/resources/upload/" + savedName;
		            System.out.println(fileLink);
		            naverVO.setUpload_image(fileLink);
		            
		            dao.ProfileUpdate(email, savedName);
		            model.addAttribute("message", "프로필 사진이 업로드되었습니다.");
		        } else {
		            model.addAttribute("message", "업로드할 파일이 없습니다.");
		        }
		    } catch (IOException e) {
		        model.addAttribute("message", "프로필 사진 업로드 중 오류가 발생했습니다.");
		        e.printStackTrace();
		    }
		    
		    // 프로필 페이지로 리다이렉트합니다.
		    return "/mypage/uploadProfile";
		}
}
