package com.multi.dorae.login;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class NaverController {
	
	@Autowired
	NaverDAO dao;
	
	@RequestMapping("login/naverLogin")
	public void home(NaverVO vo, Model model) {
		System.out.println(vo + "===================");
		
		model.addAttribute("vo", vo);
	}
	
	@RequestMapping("naverInsert")
	public void insert(NaverVO bag) {
		dao.insert(bag);
	}
}