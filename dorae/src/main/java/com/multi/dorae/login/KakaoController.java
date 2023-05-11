package com.multi.dorae.login;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

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

	@RequestMapping(value = "login/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code, Model model)
			throws Exception {
		System.out.println("#########" + code);
		String access_Token = ms.getAccessToken(code);
		ArrayList list = ms.getUserInfo(access_Token);
		System.out.println("###access_Token#### : " + access_Token);
//		System.out.println("###nickname#### : " + userInfo.getNickname());
//		System.out.println("###email#### : " + userInfo.getEmail());

		// 아래 코드가 추가되는 내용
		session.invalidate();
		// 위 코드는 session객체에 담긴 정보를 초기화 하는 코드.
//		session.setAttribute("kakaoN", userInfo.getNickname());
		session.setAttribute("kakaoE", list.get(1));
		// 위 2개의 코드는 닉네임과 이메일을 session객체에 담는 코드
		// jsp에서 ${sessionScope.kakaoN} 이런 형식으로 사용할 수 있다.

		// 리턴값은 용도에 맞게 변경하세요~
		model.addAttribute("result", (int) (list.get(1)));
		return "login/testPage";
	}

	// 네이버랑 email 겹치면 지우려고 만든 것 (회원탈퇴시에도 적용할 예정)
	@RequestMapping(value = "login/kakaoDelete", method = RequestMethod.GET)
	public void kakaoDelete(String email) {
		System.out.println(email);
		dao.delete(email);
	}

//	@RequestMapping("login")
//	public String login(KakaoVO bag) {
//		System.out.println(bag);
//		int result = dao.login(bag);
//		if (result == 1) {
//			session.setAttribute("email", bag.getEmail());
//			return "redirect:login/mypage.jsp";
//		} else {
//			return "redirect:login/login.jsp";
//
//		}
//	}
	
}