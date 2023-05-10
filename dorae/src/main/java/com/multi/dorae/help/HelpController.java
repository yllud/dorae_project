package com.multi.dorae.help;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("help")
public class HelpController {

	@Autowired
	FaqDAO faqDAO;
	@Autowired
	NoticeDAO noticeDAO;
	@Autowired
	ContactDAO contactDAO;
	
	@RequestMapping()
	public String main() {
		return "redirect:help/help.jsp";
	}
	
	public FaqVO faq(int faq_id) {
		return faqDAO.selectOne(faq_id);
	}
	
	@ResponseBody
	@RequestMapping("faqList")
	public List<FaqVO> faqList() {
		return faqDAO.selectList();
	}
	
	@RequestMapping("faqByCategory")
	public void faqListByHelpCategory(String helpCategory, Model model) {
		model.addAttribute("faqList", faqDAO.selectListByCategory(helpCategory));
	}
	
	@RequestMapping("faqBySearch")
	public void faqSearch(String search, Model model) {
		model.addAttribute("faqList", faqDAO.selectListBySearch(search));
	}
	
	@ResponseBody
	@RequestMapping("noticeList")
	public List<NoticeVO> noticeList() {
		return noticeDAO.selectList();
	}
	
	@ResponseBody
	@RequestMapping("contactList")
	public List<ContactVO> contactList() {
		return new ArrayList<ContactVO>();
	}
	
}
