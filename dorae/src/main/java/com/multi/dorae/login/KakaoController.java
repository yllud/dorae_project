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

//	@RequestMapping(value = "login/kakaoLogin", method = RequestMethod.GET)
//	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, Model model)
//			throws Exception {
//		System.out.println("#########" + code);
//		String access_Token = ms.getAccessToken(code);
//		ArrayList list = ms.getUserInfo(access_Token);
//		System.out.println("###access_Token#### : " + access_Token);
////		System.out.println("###nickname#### : " + userInfo.getNickname());
////		System.out.println("###email#### : " + userInfo.getEmail());
//
//		// 아래 코드가 추가되는 내용
//		session.invalidate();
//		// 위 코드는 session객체에 담긴 정보를 초기화 하는 코드.
////		session.setAttribute("kakaoN", userInfo.getNickname());
//		session.setAttribute("email", list.get(1));
//		session.setAttribute("nickname", list.get(0));
//		// 위 2개의 코드는 닉네임과 이메일을 session객체에 담는 코드
//		// jsp에서 ${sessionScope.kakaoN} 이런 형식으로 사용할 수 있다.
//		
//		// 리턴값은 용도에 맞게 변경하세요~
//		model.addAttribute("result", (int) (list.get(1)));
//		return "mypage/mypage";
//	}
	
	
	 @RequestMapping("login/mypage")
	 public String mypage() {
		 return "mypage/mypage";
	    // WEB-INF/views/mypage/mypage.jsp로 이동
	 }
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

	            return "mypage/mypage"; // 로그인 성공 후 마이페이지로 리다이렉트
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
	        
	        return "mypage/mypage"; // 로그인 성공 후 마이페이지로 리다이렉트
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