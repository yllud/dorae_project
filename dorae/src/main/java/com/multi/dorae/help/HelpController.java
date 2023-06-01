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

import com.multi.dorae.admin.ResponseMessage;

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
	public void faqSearch(String search, PageVO pageVO, Model model) {
		model.addAttribute("helpCategory", helpCategoryService.listByParentId("None"));
		model.addAttribute("faqList", faqService.listBySearchWithPaging(search, pageVO));
		model.addAttribute("page", pageVO);
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
	
	@ResponseBody
	@RequestMapping(value = "contactCreate", method = RequestMethod.POST)
	public ResponseMessage contactCreate(ContactVO contactVO, @SessionAttribute String email) {
		ResponseMessage mes = new ResponseMessage();
		mes.setSuccess(contactService.create(contactVO, email));
		return mes;
	}
	
	@RequestMapping(value = "applyBusinessList", method = RequestMethod.GET)
	public void applyBusinessList(@SessionAttribute String email, Model model) {
		model.addAttribute("applyList", applyDAO.listByMemberId(email));
	}
	
	@ResponseBody
	@RequestMapping(value = "applyBusiness", method = RequestMethod.GET)
	public HashMap<String, Boolean> applyBusiness(@SessionAttribute String email) {
		HashMap<String, Boolean> map = new HashMap<String, Boolean>();
		if (applyDAO.isUnderReview(email)) { // 검토 중인 신청 내역이 있으면
			map.put("success", false);
			return map;
		}
		
		if (applyDAO.insert(email) == 1) {
			map.put("success", true);
		} else {
			map.put("success", false);
		}
		
		return map;
	}
}
