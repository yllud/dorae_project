package com.multi.dorae.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.multi.dorae.help.HelpCategoryService;
import com.multi.dorae.help.HelpCategoryVO;

@RequestMapping("admin")
@Controller
public class AdminController {
	
	@Autowired
	HelpCategoryService helpCategoryService;
	@Autowired
	AdminService adminService;
	
	@RequestMapping
	public String adminMain(@SessionAttribute("admin") AdminVO adminVO, Model model) {
		System.out.println("adminMain");
		System.out.println(adminVO);
		model.addAttribute("adminVO", adminVO);
		return "admin/admin";
	}
	
	@ResponseBody
	@RequestMapping(value = "hcNameUpdate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String hcNameUpdate(HelpCategoryVO vo) {
		if (helpCategoryService.updateName(vo) == 1) {
			return "유형 이름 수정 성공";
		} else {
			return "유형 이름 수정 실패";
		}
	}
	
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void adminJoinPage() {

	}
	
	@RequestMapping(value = "join", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public String adminJoin(AdminVO adminVO, HttpSession session) {
		if (adminService.join(adminVO)) { // 가입 성공하면 세션에 저장
			session.setAttribute("admin", adminVO);
		}
		
		return "redirect:../admin";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public void adminLoginPage() {

	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST, produces = "application/text;charset=UTF-8")
	public String adminLogin(AdminVO adminVO, HttpSession session) {
		if (adminService.login(adminVO)) { // 로그인이 성공했을 경우
			session.setAttribute("admin", adminVO);
			return "redirect:../admin";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String adminLogout(HttpSession session) {
		session.invalidate(); // 세션 만료시킴
		
		return "redirect:../admin";
	}
}
