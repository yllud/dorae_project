package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.help.ContactService;
import com.multi.dorae.help.ContactVO;

@RequestMapping("admin")
@Controller
public class AdminContactController {
	
	@Autowired
	ContactService contactService;
	
	@ResponseBody
	@RequestMapping(value = "answerUpdate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String answerUpdate(ContactVO vo) {
		if (contactService.answerUpdate(vo)) {
			return "답변 등록 성공";			
		} else {
			return "답변 등록 실패";
		}
	}
}
