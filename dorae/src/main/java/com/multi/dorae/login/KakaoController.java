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
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, Model model)
	        throws Exception {
	    String access_Token = ms.getAccessToken(code);
	    ArrayList list = ms.getUserInfo(access_Token);
	    System.out.println(list.size());

	    String email = (String) list.get(0);
	    System.out.println(email);

	    // DB에서 해당 이메일로 조회
	    KakaoVO userInfo = dao.findkakao(email);
	    System.out.println(userInfo);
	    
	    if (userInfo != null) {
	        // 이미 가입된 사용자이므로 로그인 처리 및 세션 설정
	        HttpSession session = request.getSession();
	        session.setAttribute("email", userInfo.getEmail());
	        session.setAttribute("nickname", userInfo.getNickname());
	        session.setAttribute("user_type", userInfo.getUser_type());
	        return "redirect:mypage/mypage"; // mypage로 리디렉션
	    } else {
	        // 신규 가입자이므로 DB에 사용자 정보 저장
	        KakaoVO newUserInfo = new KakaoVO();
	        newUserInfo.setEmail(email);
	        newUserInfo.setNickname((String) list.get(1));
	        newUserInfo.setJoinDate(new Timestamp(System.currentTimeMillis()));
	        newUserInfo.setUser_type("user");
	        dao.insert(newUserInfo);

	        HttpSession session = request.getSession();
	        session.setAttribute("email", newUserInfo.getEmail());
	        session.setAttribute("nickname", newUserInfo.getNickname());
	        session.setAttribute("user_type", newUserInfo.getUser_type());
	        return "mypage/mypage"; // mypage로 리디렉션
	    }
	}
	

	// 네이버랑 email 겹치면 지우려고 만든 것 (회원탈퇴시에도 적용할 예정)
	@RequestMapping(value = "login/kakaoDelete", method = RequestMethod.GET)
	public void kakaoDelete(String email) {
		System.out.println(email);
		dao.delete(email);
	}

//	// 세션 잡으려고 새로 추가한 것
//	@RequestMapping("login/kakaoLogin")
//	public String login(@RequestParam("code") String authorize_code, HttpSession session) {
//	    String access_Token = ms.getAccessToken(authorize_code);
//	    ArrayList userInfo = ms.getUserInfo(access_Token);
//
//	    // 로그인 정보를 세션에 설정
//	    KakaoVO vo = (KakaoVO) userInfo.get(0);
//	    ms.setSessionAttributes(session, vo);
//
//	    // 세션 설정 후 원하는 페이지로 리다이렉트
//	    return "redirect:mypage/mypage";
//	}
	
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