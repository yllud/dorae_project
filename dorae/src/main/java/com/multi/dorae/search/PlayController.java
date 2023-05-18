package com.multi.dorae.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PlayController {

	@Autowired
	PlayDAO dao;

	@Autowired
	StageDAO dao2;
	
	@Autowired
	RankDAO dao3;

	@RequestMapping("search/playList")
	public void playList(Criteria cri, Model model) {

		System.out.println("(Controller) play list 요청");

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

	@RequestMapping("search/playList2")
	public void playList2(Criteria cri, Model model) {

		System.out.println("(Controller) play list2 요청");
		
		int count = dao.count(cri); // 리스트 개수
		System.out.println("all count>> " + count);
		
		int page_cnt = cri.makePageBtn(count); // 페이지 버튼 개수
		System.out.println("page count>> " + page_cnt);

		cri.setStartEnd(cri.getPage());	//페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list = dao.list(cri);
		
		List<RankVO> list2=dao3.rankList(cri.getGenre());
		
		String genre_name=cri.getGenre();

		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("list2", list2);
		model.addAttribute("page_cnt", page_cnt);
		model.addAttribute("genre_name", genre_name);
	}

	@RequestMapping("search/playDetail")
	public void playDetail(String play_id, Model model) {
		System.out.println("(Controller) playDetail 요청");
		System.out.println(play_id);
		PlayVO vo = dao.playDetail(play_id);
		String stage_id = dao.stageId(play_id);

		StageVO vo2 = dao2.stageDetail(stage_id);

		model.addAttribute("vo", vo);
		model.addAttribute("vo2", vo2);
	}

	@RequestMapping(value = "map/latLngList")
	@ResponseBody
	public List<StageVO> latLngList() {
		System.out.println("latLngList");
		List<StageVO> list2 = dao2.stageLatLng();
		return list2;
	}
}
