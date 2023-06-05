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
	NoticeBbsService noticeBbsService;

	// 게시글 상세
	@RequestMapping("noticeBbs/detail")
	public void detail(long notice_id, Model model) {

		// 상세 페이지 서비스 호출
		NoticeVO one = noticeBbsService.getDetail(notice_id);
		model.addAttribute("one", one);
	}

	// 태그 분류 게시글(이벤트 페이징 처리)
	@RequestMapping("noticeBbs/event")
	public void tag(NoticeBbsPageVO vo, Model model, String tag) {

		// 태그로 검색한 리스트 가져오기(페이징O) - 이벤트 출력용 서비스 호출
		List<NoticeVO> list = noticeBbsService.event(vo, tag);
		int pages = noticeBbsService.getTagPages(tag);

		// 버튼 페이징
		int currentButtonPage = noticeBbsService.currentButtonPage(vo);

		model.addAttribute("list", list);
		model.addAttribute("pages", pages);
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 공지사항 가져오기(페이징X)
	@RequestMapping("noticeBbs/notice")
	public void notice(Model model, String tag) {

		// 태그로 검색한 리스트 가져오기(페이징X) - 공지사항 출력용 서비스 호출
		List<NoticeVO> list = noticeBbsService.notice(tag);
		model.addAttribute("list", list);
	}
}
