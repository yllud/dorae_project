package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.help.ContactDAO;
import com.multi.dorae.help.ContactVO;
import com.multi.dorae.help.FaqDAO;
import com.multi.dorae.help.FaqVO;
import com.multi.dorae.help.NoticeDAO;
import com.multi.dorae.help.NoticeVO;

@RequestMapping("admin")
@Controller
public class AdminController {
	
	@Autowired
	FaqDAO faqDAO;
	@Autowired
	NoticeDAO noticeDAO;
	@Autowired
	ContactDAO contactDAO;
	
	@RequestMapping
	public String adminMain() {
		return "admin/admin";
	}
	
	@ResponseBody
	@RequestMapping(value = "faqCreate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String faqCreate(FaqVO vo) {
		System.out.println(vo);
		faqDAO.insert(vo);
		return "FAQ 등록 성공";
	}
	
	@ResponseBody
	@RequestMapping(value = "faqUpdate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String faqUpdate(FaqVO vo) {
		System.out.println(vo);
		faqDAO.update(vo);
		return "FAQ 수정 성공";
	}
	
	@ResponseBody
	@RequestMapping(value = "noticeCreate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String noticeCreate(NoticeVO vo) {
		System.out.println(vo);
		noticeDAO.insert(vo);
		return "공지사항 등록 성공";
	}
	
	@ResponseBody
	@RequestMapping(value = "noticeUpdate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String noticeUpdate(NoticeVO vo) {
		System.out.println(vo);
		noticeDAO.update(vo);
		return "공지사항 수정 성공";
	}
	
	@ResponseBody
	@RequestMapping(value = "answerUpdate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String answerUpdate(ContactVO vo) {
		System.out.println(vo);
		contactDAO.answerUpdate(vo);
		return "답변 등록 성공";
	}
	
}
