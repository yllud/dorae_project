package com.multi.dorae.login;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class KakaoController {

	@Autowired
	private KakaoService ms;

	@Autowired
	private HttpSession session;

	@Autowired
	private KakaoDAO dao;
	
	@Autowired
	private HttpServletRequest request;

	
	
	@RequestMapping(value = "login/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code") String code, Model model, HttpSession session)
	        throws Exception {
	    String access_Token = ms.getAccessToken(code);
	    ArrayList<String> list = ms.getUserInfo(access_Token);
	    System.out.println(list.size());

	    String email = list.get(0);
	    System.out.println(email);

	    // DB에서 해당 이메일로 조회
	    KakaoVO userInfo = dao.findkakao(email);
	    System.out.println(userInfo);
	    if (userInfo == null) {
	        // DB에 정보가 없으면 새로운 회원으로 등록
	        KakaoVO newUserInfo = new KakaoVO();
	        newUserInfo.setEmail(email);
	        newUserInfo.setNickname(list.get(1));
	        newUserInfo.setUser_type("KAKAO");

	        int result = dao.insert(newUserInfo);
	        System.out.println(result);
	        if (result != 0) {
	            // 로그인 성공하면 session 잡아주기
	            session.setAttribute("email", email);
	            session.setAttribute("nickname", newUserInfo.getNickname());
	            session.setAttribute("user_type", newUserInfo.getUser_type());

	            // 세션 유지 시간 설정 (옵션)
	            session.setMaxInactiveInterval(60 * 30); // 30분 동안 유지되도록 설정 (단위: 초)

	            return "redirect:../map/main.jsp"; // 로그인 성공 후 마이페이지로 리다이렉트
	        } else {
	            return "redirect:../login/login.jsp"; // 로그인 실패 시 로그인 페이지로 리다이렉트
	        }
	    } else {
	        // DB에 정보가 있으면 로그인 성공 처리
	        session.setAttribute("email", email);
	        session.setAttribute("nickname", userInfo.getNickname());
	        session.setAttribute("user_type", userInfo.getUser_type());

	        // 세션 유지 시간 설정 (옵션)
	        session.setMaxInactiveInterval(60 * 30); // 30분 동안 유지되도록 설정 (단위: 초)
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
		@RequestMapping("login/before2")
		public void before(HttpSession session, String before) {
			System.out.println(before);
			session.setAttribute("before", before);
		}

	

	// 네이버랑 email 겹치면 지우려고 만든 것 (회원탈퇴시에도 적용할 예정)
	@RequestMapping(value = "login/kakaoDelete", method = RequestMethod.GET)
	public void kakaoDelete(String email) {
		System.out.println(email);
		dao.delete(email);
	}

	
	@RequestMapping("login/logout2")
	public String logout(Model model, HttpSession session) {
	    // 세션에서 로그인 정보 제거
	    session.removeAttribute("email");
	    session.removeAttribute("nickname");
	    session.removeAttribute("user_type");
	    // 세션 무효화
	    session.invalidate();

	    // 로그아웃 후 처리할 코드
	    model.addAttribute("message", "로그아웃되었습니다.");

	    // 로그아웃 후 리다이렉트할 페이지 반환
	    return "redirect:../login/login.jsp";
	}
	
}