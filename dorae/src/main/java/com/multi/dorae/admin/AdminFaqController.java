package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.help.FaqService;
import com.multi.dorae.help.FaqVO;

@RequestMapping("admin")
@Controller
public class AdminFaqController {

	@Autowired
	FaqService faqService;
	
	@ResponseBody
	@RequestMapping(value = "faqCreate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String faqCreate(FaqVO vo) {
		faqService.faqCreate(vo);
		return "FAQ 등록 성공";
	}
	
	@ResponseBody
	@RequestMapping(value = "faqUpdate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String faqUpdate(FaqVO vo) {
		faqService.answerUpdate(vo);
		return "FAQ 수정 성공";
	}
}
