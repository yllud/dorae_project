package com.multi.dorae.login;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller //스프링에서 제어하는 역할로 등록! dependency
public class MemberController {
	
	@Autowired
	MemberDAO dao; //전역변수(글로벌 변수) 
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private ServletContext servletContext;
	
	
	
	@RequestMapping("login/memberLogin")
	public String login(MemberVO vo, Model model) {
	    System.out.println(vo);
	    MemberVO vo2 = dao.login(vo);
	    model.addAttribute("vo2", vo2);

	    if (vo2 != null && vo2.getEmail() != null && vo2.getPassword().equals(vo.getPassword())) {
	        session.setAttribute("email", vo.getEmail());
	        session.setAttribute("nickname", vo2.getNickname());
	        session.setAttribute("user_type", vo2.getUser_type());

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
	    } else {
	        // 로그인 실패 시 로그인 페이지로 이동하며 알림 메시지를 전달
	    	
	    	 // 로그인 실패 시 로그인 페이지로 이동하며 알림창 표시
	        String alertMessage = "로그인에 실패했습니다. 이메일과 비밀번호를 확인해주세요.";
	        model.addAttribute("alertMessage", alertMessage);
	        return "redirect:../login/login.jsp";
	    
	    }
	}
	
	@RequestMapping("login/memberInsert")
	public String insert(MemberVO bag, HttpServletResponse response) throws IOException {
	    System.out.println("insert 요청됨.");
	    System.out.println(bag);

	    // 이메일 중복 체크
	    int existingMember = dao.checkEmail(bag.getEmail());
	    if (existingMember == 1) {
	        response.setContentType("text/plain");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write("중복된 이메일입니다.");
	        return null; // 중복된 이메일인 경우에는 리다이렉트를 수행하지 않음
	    }else {

	    // 중복되지 않은 경우 회원 등록 처리
	    dao.create(bag);
	    return "login/memberInsert"; // 회원 가입 성공 시 memberInsert.jsp로 리다이렉트
	    }

	}
	
	@RequestMapping("login/memberUpdate")
	public void update(MemberVO bag) {
		System.out.println("update요청됨.");
		System.out.println(bag);
		dao.update(bag);
	}
	
	@RequestMapping("login/memberDelete")
	public void delete(String email) {
		System.out.println("delete요청됨.");
		System.out.println(email);
		dao.delete(email);
	}
	
//	@RequestMapping("login/memberOne")
//	public void one(String email, Model model) {
//		System.out.println("one요청됨.");
//		System.out.println(email);
//		MemberVO bag = dao.checkEmail(email);
//		//bag에 검색결과 다 들어있음.
//		//views아래 one.jsp로 쓸 수 있도록 설정해주어야 함.
//		model.addAttribute("bag", bag);
//		//views까지 전달할 속성으로 추가해주세요. 
//	}
	
	@ResponseBody
	@RequestMapping(value = "login/checkEmail", method = RequestMethod.POST)
	public int checkEmail(@RequestParam("email") String email) {
	    int existingMember = dao.checkEmail(email);
	    System.out.println("aaa" + existingMember);
//	    if (existingMember == 1) {
//	        // 중복된 이메일인 경우
//	        return "duplicate"; // 'duplicate' 문자열을 반환
//	    } else {
//	        // 중복되지 않은 이메일인 경우
//	        return "not_duplicate"; // 'not_duplicate' 문자열을 반환
//	    }
	    return existingMember;
	}
	
}