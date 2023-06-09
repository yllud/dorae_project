package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.multi.dorae.help.NoticeService;
import com.multi.dorae.help.NoticeVO;
import com.multi.dorae.help.PageVO;

@RequestMapping("admin/notice")
@Controller
public class AdminNoticeController {

	@Autowired
	NoticeService noticeService;
	
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public void noticeCreate() {
		
	}
	
	@ResponseBody
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public ResponseMessage noticeCreate(NoticeVO noticeVO, @SessionAttribute("admin") AdminVO adminVO) {
		ResponseMessage mes = new ResponseMessage();
		if (noticeService.insert(noticeVO, adminVO)) { // 공지사항 생성에 성공하면
			mes.setSuccess(true);
			mes.setMessage(String.valueOf(noticeVO.getNotice_id()));
		}
		return mes;
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public void noticeUpdate(long notice_id, Model model) {
		model.addAttribute("notice_id", notice_id);
	}
	
	@ResponseBody
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public ResponseMessage noticeUpdate(NoticeVO noticeVO) {
		ResponseMessage mes = new ResponseMessage();
		mes.setSuccess(noticeService.update(noticeVO));
		System.out.println("notice Update : " + mes.toString());
		return mes;		
	}
	
	@RequestMapping("one")
	public void noticeOne(long notice_id, Model model) {
		model.addAttribute("notice", noticeService.one(notice_id));
	}
	
	@ResponseBody
	@RequestMapping("one.json")
	public NoticeVO noticeOneJson(long notice_id) {
		return noticeService.one(notice_id);
	}
	
	@RequestMapping("list")
	public void noticeList(PageVO pageVO, Model model) {		
		model.addAttribute("page", pageVO);
		model.addAttribute("noticeList", noticeService.listWithPaging(pageVO));
	}
	
	@ResponseBody
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ResponseMessage noticeDelete(long notice_id) {
		ResponseMessage mes = new ResponseMessage();
		mes.setSuccess(noticeService.delete(notice_id));
		return mes;
	}
}
