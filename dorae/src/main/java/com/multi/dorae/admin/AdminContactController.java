package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.multi.dorae.help.ContactService;
import com.multi.dorae.help.ContactVO;
import com.multi.dorae.help.PageVO;

@RequestMapping("admin/contact")
@Controller
public class AdminContactController {
	
	@Autowired
	ContactService contactService;
	
	@RequestMapping(value = "updateAnswer", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String updateAnswer(ContactVO contactVO, @SessionAttribute("admin") AdminVO adminVO) {
		if (contactService.updateAnswer(contactVO, adminVO)) {
			return "redirect:one?contact_id=" + contactVO.getContact_id();
		} else {
			return "redirect:list";
		}
	}
	
	@RequestMapping("list")
	public void contactList(PageVO pageVO, Model model) {
		model.addAttribute("page", pageVO);
		model.addAttribute("contactList", contactService.listWithPaging(pageVO));
	}
	
	@RequestMapping("one")
	public void contactOne(long contact_id, Model model) {
		model.addAttribute("contact", contactService.one(contact_id));
	}
	
	@RequestMapping("delete")
	public String contactDelete(long contact_id) {
		if (contactService.delete(contact_id)) {
			return "redirect:list";
		} else {
			return "redirect:list";
		}
	}
}
