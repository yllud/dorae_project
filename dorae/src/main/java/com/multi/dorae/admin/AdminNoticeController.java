package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.help.NoticeService;
import com.multi.dorae.help.NoticeVO;

@RequestMapping("admin")
@Controller
public class AdminNoticeController {

	@Autowired
	NoticeService noticeService;
	
	@ResponseBody
	@RequestMapping(value = "noticeCreate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String noticeCreate(NoticeVO vo) {
		noticeService.insert(vo);
		return "공지사항 등록 성공";
	}
	
	@ResponseBody
	@RequestMapping(value = "noticeUpdate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String noticeUpdate(NoticeVO vo) {
		noticeService.update(vo);
		return "공지사항 수정 성공";
	}
}
