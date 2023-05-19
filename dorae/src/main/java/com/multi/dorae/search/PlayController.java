package com.multi.dorae.search;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonEncoding;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

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

	@RequestMapping(value = "map/infoList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String infoList() throws Exception {
	    System.out.println("infoList");
	    List<String> idList = dao.listPlayId();
	    List<String> stList = new ArrayList<>();
	    List<PlayVO> delist1 = new ArrayList<>(); // play detail
	    List<StageVO> delist2 = new ArrayList<>(); // stage detail

	    for(int i=0; i<idList.size(); i++) {
	        stList.add(dao.stageId(idList.get(i)));
	        delist1.add(dao.playDetail(idList.get(i)));
	    }
	    for(int i=0; i<stList.size(); i++) {
	        delist2.add(dao2.stageDetail(stList.get(i)));
	    }
	    // JSON 변환을 위한 ObjectMapper 생성
	    ObjectMapper objectMapper = new ObjectMapper();
	    objectMapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);

	    // delist1과 delist2를 Map으로 묶어서 JSON으로 변환
	    Map<String, Object> data = new HashMap<>();
	    data.put("delist1", delist1);
	    data.put("delist2", delist2);
	    String json = objectMapper.writeValueAsString(data);
	  
	    //System.out.println(json);
	    return json;
	}
}
