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
	
	// 전체 게시글
	@RequestMapping("noticeBbs/all")
	public void all(NoticeBbsPageVO vo, Model model) {
		vo.setStartEnd(vo.getPage());
		List<NoticeVO> list = dao.all(vo);
		
		int count = dao.count();
		int pages = 0;
		if (count % 10 == 0) {
			pages = count / 10;
		} else {
			pages = count / 10 + 1;
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
	
	// 게시글 상세
	@RequestMapping("noticeBbs/detail")
	public void detail(long notice_id, Model model) {
		NoticeVO one = dao.one(notice_id);
		model.addAttribute("one", one);
	}
	
	// 태그 분류 게시글
	@RequestMapping("noticeBbs/tag")
	public void tag(NoticeBbsPageVO vo, Model model, String tag) {
		vo.setStartEnd(vo.getPage());
		List<NoticeVO> list = dao.tag(vo, tag);
		
		int count = dao.tagCount(tag);
		int pages = 0;
		if (count % 10 == 0) {
			pages = count / 10;
		} else {
			pages = count / 10 + 1;
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
}
