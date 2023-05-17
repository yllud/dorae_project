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
	FaqService faqService;
	@Autowired
	NoticeService noticeService;
	@Autowired
	ContactService contactService;
	@Autowired
	HelpCategoryService helpCategoryService;
	
	@RequestMapping()
	public String main() {
		return "redirect:help/main";
	}
	
	@ResponseBody
	@RequestMapping("helpCategoryListByParentId")
	public List<HelpCategoryVO> helpCategoryListByParentId(String parent_category_id) {
		return helpCategoryService.selectListByParentId(parent_category_id);
	}
	
	@RequestMapping("main")
	public void helpMain(Model model) {
		model.addAttribute("helpCategory", helpCategoryService.selectListByParentId("None"));
	}
	
	@ResponseBody
	@RequestMapping("faqOne")
	public FaqVO faqOne(int faq_id) {
		return faqService.faqOne(faq_id);
	}
	
	@ResponseBody
	@RequestMapping("faqList")
	public List<FaqVO> faqList() {
		return faqService.faqList();
	}
	
	@RequestMapping("faqByCategory")
	public void faqListByHelpCategory(String help_category_id, Model model) {
		model.addAttribute("helpCategory", helpCategoryService.selectListByParentId("None"));
		model.addAttribute("faqList", faqService.faqListByHelpCategory(help_category_id));
	}
	
	@RequestMapping("faqBySearch")
	public void faqSearch(String search, Model model) {
		model.addAttribute("faqList", faqService.faqBySearch(search));
		model.addAttribute("search", search);
	}
	
	@ResponseBody
	@RequestMapping("noticeOne")
	public NoticeVO noticeOne(long notice_id) {
		System.out.println("notice_id >> " + notice_id);
		return noticeService.noticeOne(notice_id);
	}
	
	@ResponseBody
	@RequestMapping("noticeList")
	public List<NoticeVO> noticeList() {
		return noticeService.noticeList();
	}
	
	@ResponseBody
	@RequestMapping("contactOne")
	public ContactVO contactOne(long contact_id) {
		return contactService.contactOne(contact_id);
	}
	
	@ResponseBody
	@RequestMapping("contactList")
	public List<ContactVO> contactList(String member_id) {
		return contactService.contactList(member_id);
	}
	
	@ResponseBody
	@RequestMapping(value = "contactCreate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String contactCreate(ContactVO vo) {
		contactService.contactCreate(vo);
		return "1:1 문의 등록 성공";
	}
}
