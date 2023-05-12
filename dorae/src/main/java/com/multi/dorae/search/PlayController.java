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
	
	@RequestMapping("search/playList")
	public void playList(Criteria cri,Model model) {
		
		System.out.println("play 전체 list 요청됨..");
		cri.setStartEnd(cri.getPage());
		System.out.println(cri);
		List<PlayVO> list = dao.list(cri);
		model.addAttribute("list", list);
	}
	
	
	
	
	@RequestMapping("search/playSearch")
	public void playSearch(String title,Model model) {
		System.out.println("play search 요청");
		List<PlayVO> list=dao.searchList(title);
		model.addAttribute("list", list);
	}
	
	@RequestMapping("search/playDetail")
	public void playDetail(String play_id,Model model) {
		System.out.println("playDetail");
		System.out.println(play_id);
		PlayVO vo=dao.playDetail(play_id);
		String stage_id=dao.stageId(play_id);
		
		StageVO vo2=dao2.stageDetail(stage_id);
		
		model.addAttribute("vo", vo);
		model.addAttribute("vo2", vo2);
	}
	
	@RequestMapping(value="map/latLngList")
	@ResponseBody
	public List<StageVO> latLngList() {
		System.out.println("latLngList");
		List<StageVO> list2 = dao2.stageLatLng();
		return list2;
	}
}
