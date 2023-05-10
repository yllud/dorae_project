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
	
	@ResponseBody
	@RequestMapping("faq")
	public FaqVO faq(int faq_id) {
		return faqDAO.selectOne(faq_id);
	}
	
	@ResponseBody
	@RequestMapping("faqList")
	public List<FaqVO> faqList() {
		return faqDAO.selectList();
	}
	
	@ResponseBody
	@RequestMapping("faqByCategory")
	public List<FaqVO> faqListByHelpCategory(String helpCategory, Model model) {
//		model.addAttribute("faqList", faqDAO.selectListByCategory(helpCategory));
		return faqDAO.selectListByCategory(helpCategory);
	}
	
	@ResponseBody
	@RequestMapping("faqBySearch")
	public List<FaqVO> faqSearch(String search, Model model) {
//		model.addAttribute("faqList", faqDAO.selectListBySearch(search));
		return faqDAO.selectListBySearch(search);
	}
	
	@ResponseBody
	@RequestMapping("noticeList")
	public List<NoticeVO> noticeList() {
		return noticeDAO.selectList();
	}
	
	@ResponseBody
	@RequestMapping("contactList")
	public List<ContactVO> contactList() {
		return contactDAO.selectList("abcd@naver.com");
	}
	
	@RequestMapping("contactCreate")
	public String contactCreate(ContactVO vo) {
		contactDAO.insert(vo);
		return "redirect:help.jsp";
	}
	
}
