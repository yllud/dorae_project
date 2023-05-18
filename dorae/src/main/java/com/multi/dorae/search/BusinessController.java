package com.multi.dorae.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BusinessController {
	
	@Autowired
	BusinessDAO dao;
	
	@Autowired
	PlayDAO dao2;
	
	@RequestMapping("search/businessList")
	public void businessList(CriteriaB cri, Model model) {

		System.out.println("(Controller) business list 요청");
		System.out.println(cri.getEmail());
		System.out.println(cri.getPage());

		int count = dao.count(cri); // 리스트 개수
		System.out.println("list count>> " + count);
		int page_cnt = cri.makePageBtn(count); // 페이지 버튼 개수
		System.out.println("page count>> " + page_cnt);

		cri.setStartEnd(cri.getPage());	//페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list = dao.list(cri);

		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("page_cnt", page_cnt);
	}
	
	@RequestMapping("search/businessList2")
	public void playList2(CriteriaB cri, Model model) {

		System.out.println("(Controller) business list2 요청");
		
		

		cri.setStartEnd(cri.getPage());	//페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list2 = dao.list(cri);


		model.addAttribute("list2", list2);
		model.addAttribute("cri", cri);

	}
	
	@RequestMapping("search/businessDetail")
	public void playDetail(String play_id, Model model) {
		System.out.println("(Controller) business Detail 요청");
		System.out.println(play_id);
		PlayVO vo = dao2.playDetail(play_id);

		model.addAttribute("vo", vo);
	}
}
