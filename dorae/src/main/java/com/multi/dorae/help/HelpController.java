package com.multi.dorae.help;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	@RequestMapping("faqOne")
	public FaqVO faqOne(int faq_id) {
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
	@RequestMapping("noticeOne")
	public NoticeVO noticeOne(long notice_id) {
		System.out.println(notice_id);
		return noticeDAO.selectOne(notice_id);
	}
	
	@ResponseBody
	@RequestMapping("noticeList")
	public List<NoticeVO> noticeList() {
		return noticeDAO.selectList();
	}
	
	@ResponseBody
	@RequestMapping("contactOne")
	public ContactVO contactOne(long contact_id) {
		return contactDAO.selectOne(contact_id);
	}
	
	@ResponseBody
	@RequestMapping("contactList")
	public List<ContactVO> contactList(String member_id) {
		return contactDAO.selectList(member_id);
	}
	
	@ResponseBody
	@RequestMapping(value = "contactCreate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String contactCreate(ContactVO vo) {
		contactDAO.insert(vo);
		return "1:1 문의 등록 성공";
	}
	
}
