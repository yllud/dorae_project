package com.multi.dorae.help;

import java.util.HashMap;
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
	@Autowired
	ApplyBusinessDAO applyDAO;
	
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
	@RequestMapping("faqOne")
	public FaqVO faqById(int faq_id) {
		return faqService.one(faq_id);
	}
	
	@RequestMapping("faqCategory")
	public void faqListByHelpCategory(String help_category_id, Model model) {
		model.addAttribute("helpCategory", helpCategoryService.listByParentId("None"));
		model.addAttribute("faqList", faqService.listByCategory(help_category_id));
	}
	
	@RequestMapping("faqSearch")
	public void faqSearch(String search, Model model) {
		model.addAttribute("helpCategory", helpCategoryService.listByParentId("None"));
		model.addAttribute("faqList", faqService.listBySearch(search));
		model.addAttribute("search", search);
	}
	
	@RequestMapping("contactList")
	public void contact(PageVO pageVO, Model model, @SessionAttribute String email) {
		model.addAttribute("contactList", contactService.listByMemberIdWithPaging(pageVO, email));
	}
	
	@RequestMapping("contactOne")
	public String contactOne(long contact_id, @SessionAttribute String email, Model model) {
		ContactVO contactVO = contactService.one(contact_id, email);
		
		if (contactVO == null) {
			return "redirect:/help/main";
		} else {
			model.addAttribute("vo", contactVO);
			return "help/contactOne";
		}
	}
	
	@RequestMapping(value = "contactCreate", method = RequestMethod.GET)
	public void contactCreatePage() {

	}
	
	@RequestMapping(value = "contactCreate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String contactCreate(ContactVO contactVO, @SessionAttribute String email) {
		contactService.create(contactVO, email);
		return "redirect:/help/contactList?page=1";
	}
	
	@RequestMapping(value = "applyBusinessList", method = RequestMethod.GET)
	public void applyBusinessList(@SessionAttribute String email, Model model) {
		model.addAttribute("applyList", applyDAO.listByMemberId(email));
	}
	
	@ResponseBody
	@RequestMapping(value = "applyBusiness", method = RequestMethod.GET)
	public HashMap<String, Boolean> applyBusiness(@SessionAttribute String email) {
		HashMap<String, Boolean> map = new HashMap<String, Boolean>();
		
		if (applyDAO.insert(email) == 1) {
			map.put("success", true);
		} else {
			map.put("success", false);
		}
		
		return map;
	}
}
