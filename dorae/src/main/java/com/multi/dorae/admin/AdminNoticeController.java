package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public void noticeCreate(NoticeVO vo) {
		noticeService.insert(vo);
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String noticeUpdate(NoticeVO vo) {
		noticeService.update(vo);
		return "redirect:one?notice_id=" + vo.getNotice_id();
	}
	
	@RequestMapping("one")
	public void noticeOne(long notice_id, Model model) {
		model.addAttribute("notice", noticeService.one(notice_id));
	}
	
	@RequestMapping("list")
	public void noticeList(PageVO pageVO, Model model) {
		pageVO.setTotal(noticeService.count());
		pageVO.calc();
		model.addAttribute("page", pageVO);
		model.addAttribute("noticeList", noticeService.listWithPaging(pageVO));
	}
}
