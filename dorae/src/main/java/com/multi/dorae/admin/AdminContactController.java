package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.multi.dorae.help.ContactService;
import com.multi.dorae.help.ContactVO;
import com.multi.dorae.help.PageVO;

@RequestMapping("admin/contact")
@Controller
public class AdminContactController {
	
	@Autowired
	ContactService contactService;
	
	@ResponseBody
	@RequestMapping(value = "updateAnswer", method = RequestMethod.POST)
	public ResponseMessage updateAnswer(ContactVO contactVO, @SessionAttribute("admin") AdminVO adminVO) {
		ResponseMessage mes = new ResponseMessage();
		mes.setSuccess(contactService.updateAnswer(contactVO, adminVO));
		return mes;
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
	
	@ResponseBody
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ResponseMessage contactDelete(long contact_id) {
		ResponseMessage mes = new ResponseMessage();
		mes.setSuccess(contactService.delete(contact_id));
		return mes;
	}
}
