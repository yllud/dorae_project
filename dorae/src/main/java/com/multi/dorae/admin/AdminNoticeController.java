package com.multi.dorae.admin;

import javax.servlet.http.HttpServletRequest;

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
	
	@RequestMapping(value = "create", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String noticeCreate(NoticeVO noticeVO, @SessionAttribute("admin") AdminVO adminVO) {
		if (noticeService.insert(noticeVO, adminVO)) { // 공지사항 생성에 성공하면
			return "redirect:one?notice_id=" + noticeVO.getNotice_id();
		} else {
			return "redirect:list";
		}
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public void noticeUpdate(long notice_id, Model model) {
		model.addAttribute("notice_id", notice_id);
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String noticeUpdate(NoticeVO noticeVO) {
		if (noticeService.update(noticeVO)) { // 공지사항 수정에 성공하면
			return "redirect:one?notice_id=" + noticeVO.getNotice_id();
		} else {
			return "redirect:one?notice_id=" + noticeVO.getNotice_id();
		}
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

	@RequestMapping("delete")
	public String noticeDelete(long notice_id, HttpServletRequest requset) {
		if (noticeService.delete(notice_id)) {
			return "redirect:" + requset.getHeader("Referer");
		} else {
			return "redirect:list";
		}
	}
}
