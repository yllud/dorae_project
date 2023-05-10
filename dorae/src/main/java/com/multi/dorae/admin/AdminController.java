package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.multi.dorae.help.FaqDAO;
import com.multi.dorae.help.FaqVO;

@RequestMapping("admin")
@Controller
public class AdminController {
	
	@Autowired
	FaqDAO faqDAO;
	
	@RequestMapping
	public String adminMain() {
		return "admin/admin";
	}
	
	@RequestMapping(value = "faqCreate", method = RequestMethod.POST)
	public String faqCreate(FaqVO vo) {
		System.out.println(vo);
//		faqDAO.insert(vo);
		return "redirect:help/help.jsp";
	}
}
