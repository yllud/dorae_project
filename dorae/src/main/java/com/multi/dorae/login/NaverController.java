package com.multi.dorae.login;

import java.io.File;
import java.io.IOException;

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
	    	
//	    	// 방문 수 증가 (실패함 안되면 이거 한줄만 삭제)
//	        dao.updateVisitCount(vo.getEmail());
	    	
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
	        
	        
	        return "redirect:../map/main.jsp"; // 로그인 성공 후 마이페이지로 리다이렉트
	    }
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


	 @RequestMapping("login/mypage") //() 안에 마이페이지 주소 지정 localhost:8888/dorae/login/mypage가 주소
	 public String mypage(Model model) { //누를 때 마다 model로 DB 정보 검색해서 불러와야 함
		 NaverVO vo2 = dao.one((String)session.getAttribute("email"));
		 model.addAttribute("vo2", vo2);
		 return "mypage/mypage";
	}
	 
	 @RequestMapping("mypage/uploadProfileImage")
	 public void uploadProfileImage(NaverVO naverVO, MultipartFile file, Model model) throws Exception {
		 String savedName = file.getOriginalFilename();
		 String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
		 File target = new File(uploadPath + "/" + savedName);
		 file.transferTo(target);
		 
		 model.addAttribute("savedName", savedName);
		 System.out.println("img 넣기 전 >> " + naverVO);
		 naverVO.setProfile_image(savedName);
		 System.out.println("img 넣은 후 >> " + naverVO);
		 
		 dao.insertProfileImage(naverVO);
	}
}
