package com.multi.dorae.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.multi.dorae.help.ContactService;
import com.multi.dorae.help.ContactVO;
import com.multi.dorae.help.PageVO;

@RequestMapping("admin/contact")
@Controller
public class AdminContactController {
	
	@Autowired
	ContactService contactService;
	
	@RequestMapping(value = "updateAnswer", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String updateAnswer(ContactVO contactVO, HttpSession session) {
		AdminVO adminVO = (AdminVO) session.getAttribute("admin");
		contactVO.setAdmin_id(adminVO.getId());
		
		if (contactService.updateAnswer(contactVO)) {
			return "redirect:one?contact_id=" + contactVO.getContact_id();
		} else {
			return "redirect:one?contact_id=" + contactVO.getContact_id();
		}
	}
	
	@RequestMapping("list")
	public void contactList(PageVO pageVO, Model model) {
		pageVO.setTotal(contactService.count());
		pageVO.calc();
		
		System.out.println(pageVO);
		model.addAttribute("page", pageVO);
		model.addAttribute("contactList", contactService.listWithPaging(pageVO));
	}
	
	@RequestMapping("one")
	public void contactOne(long contact_id, Model model) {
		model.addAttribute("contact", contactService.one(contact_id));
	}
}
