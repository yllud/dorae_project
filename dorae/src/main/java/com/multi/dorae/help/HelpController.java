package com.multi.dorae.help;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

@Controller
@RequestMapping("help")
public class HelpController {

	@Autowired
	FaqService faqService;
	@Autowired
	ContactService contactService;
	@Autowired
	HelpCategoryService helpCategoryService;
	
	@RequestMapping()
	public String main() {
		return "redirect:main";
	}
	
	@ResponseBody
	@RequestMapping("helpCategoryListByParentId")
	public List<HelpCategoryVO> helpCategoryListByParentId(String parent_category_id) {
		return helpCategoryService.listByParentId(parent_category_id);
	}
	
	@RequestMapping("main")
	public void helpMain(Model model, HttpSession session) {
		System.out.println("email : " + session.getAttribute("email"));
		model.addAttribute("helpCategory", helpCategoryService.listByParentId("None"));
	}
	
	@ResponseBody
	@RequestMapping("faq/one")
	public FaqVO faqById(int faq_id) {
		return faqService.one(faq_id);
	}
	
	@RequestMapping("faq/category")
	public void faqListByHelpCategory(String help_category_id, Model model) {
		model.addAttribute("helpCategory", helpCategoryService.listByParentId("None"));
		model.addAttribute("faqList", faqService.listByCategory(help_category_id));
	}
	
	@RequestMapping("faq/search")
	public void faqSearch(String search, Model model) {
		model.addAttribute("faqList", faqService.listBySearch(search));
		model.addAttribute("search", search);
	}
	
	@RequestMapping("contact/list")
	public void contact(PageVO pageVO, Model model, @SessionAttribute String email) {
		pageVO.calc();
		model.addAttribute("contactList", contactService.listByMemberIdWithPaging(pageVO, email));
	}
	
	@RequestMapping("contact/one")
	public String contactOne(long contact_id, @SessionAttribute String email, Model model) {
		ContactVO contactVO = contactService.one(contact_id, email);
		
		if (contactVO == null) {
			return "redirect:/help/main";
		} else {
			model.addAttribute("vo", contactVO);
			return "help/contact/one";
		}
	}
	
	@RequestMapping(value = "contact/create", method = RequestMethod.GET)
	public void contactCreatePage() {

	}
	
	@RequestMapping(value = "contact/create", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String contactCreate(ContactVO contactVO, @SessionAttribute String email) {
		contactService.create(contactVO, email);
		return "redirect:/help/contact/list?page=1";
	}
}
