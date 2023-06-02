package com.multi.dorae.noticeBbs;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.multi.dorae.help.NoticeVO;

@Controller
public class NoticeBbsController {

	@Autowired
	NoticeBbsDAO dao;

	// 게시글 상세
	@RequestMapping("noticeBbs/detail")
	public void detail(long notice_id, Model model) {
		NoticeVO one = dao.one(notice_id);
		model.addAttribute("one", one);
	}

	// 태그 분류 게시글(이벤트 페이징 처리)
	@RequestMapping("noticeBbs/event")
	public void tag(NoticeBbsPageVO vo, Model model, String tag) {
		vo.setStartEnd(vo.getPage());
		List<NoticeVO> list = dao.tag(vo, tag);

		int count = dao.tagCount(tag);
		int pages = 0;
		if (count % 10 == 0) {
			pages = count / 5;
		} else {
			pages = count / 5 + 1;
		}
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);

		// 버튼 페이징
		int currentPage = vo.getPage(); // 현재 페이지 값
		int buttonsPerPage = 10;
		int currentButtonPage = (int) Math.ceil((double) currentPage / buttonsPerPage); // currentButtonPage 계산
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 공지사항 가져오기(페이징X)
	@RequestMapping("noticeBbs/notice")
	public void notice(Model model, String tag) {
		List<NoticeVO> list = dao.notice(tag);
		model.addAttribute("list", list);
	}
}
