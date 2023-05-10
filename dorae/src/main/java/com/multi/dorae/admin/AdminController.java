package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.multi.dorae.help.ContactDAO;
import com.multi.dorae.help.FaqDAO;
import com.multi.dorae.help.FaqVO;
import com.multi.dorae.help.NoticeDAO;
import com.multi.dorae.help.NoticeVO;

@RequestMapping("admin")
@Controller
public class AdminController {
	
	@Autowired
	FaqDAO faqDAO;
	@Autowired
	NoticeDAO noticeDAO;
	@Autowired
	ContactDAO contactDAO;
	
	@RequestMapping
	public String adminMain() {
		return "admin/admin";
	}
	
	@RequestMapping(value = "faqCreate", method = RequestMethod.POST)
	public String faqCreate(FaqVO vo) {
		System.out.println(vo);
		faqDAO.insert(vo);
		return "redirect:help/help.jsp";
	}
	
	@RequestMapping(value = "faqUpdate", method = RequestMethod.POST)
	public String faqUpdate(FaqVO vo) {
		System.out.println(vo);
		faqDAO.update(vo);
		return "redirect:help/help.jsp";
	}
	
	@RequestMapping(value = "noticeCreate", method = RequestMethod.POST)
	public String noticeCreate(NoticeVO vo) {
		System.out.println(vo);
		noticeDAO.insert(vo);
		return "redirect:help/help.jsp";
	}
	
	@RequestMapping(value = "noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdate(NoticeVO vo) {
		System.out.println(vo);
		noticeDAO.update(vo);
		return "redirect:help/help.jsp";
	}
}
