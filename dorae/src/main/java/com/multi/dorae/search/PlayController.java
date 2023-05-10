package com.multi.dorae.search;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;




@Controller
public class PlayController {

	@Autowired
	PlayDAO dao;
	
	@Autowired
	StageDAO dao2;
	
	@RequestMapping("search/playList")
	public void playList(Model model) {
		//Model은 컨트롤러의 list를 views/list.jsp까지만 전달할 수 있는 객체 
		System.out.println("play 전체 list 요청됨..");
		List<PlayVO> list = dao.list();
		model.addAttribute("list", list);
		
		
	}
	
	@RequestMapping("search/playSearch")
	public void playSearch(String title,Model model) {
		System.out.println("play search 요청");
		List<PlayVO> list=dao.searchList(title);
		model.addAttribute("list", list);
	}
	
	@RequestMapping("search/playDetail")
	public void bbs_one(String play_id,Model model) {
		System.out.println("playDetail");
		System.out.println(play_id);
		PlayVO vo=dao.playDetail(play_id);
		String stage_id=dao.stageId(play_id);
		
		StageVO vo2=dao2.stageDetail(stage_id);
		
		model.addAttribute("vo", vo);
		model.addAttribute("vo2", vo2);
	}
}
