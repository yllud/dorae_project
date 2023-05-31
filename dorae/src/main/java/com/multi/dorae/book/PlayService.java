package com.multi.dorae.book;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.multi.dorae.search.PlayDAO;
import com.multi.dorae.search.PlayVO;
import com.multi.dorae.search.RankDAO;
import com.multi.dorae.search.StageDAO;
import com.multi.dorae.search.StageVO;

@Service
public class PlayService implements PlayServiceInterface {

	@Autowired
	PlayDAO dao;

	@Autowired
	StageDAO dao2;
	
	@Autowired
	RankDAO dao3;
	
	@Override
	public String infoList() throws Exception {
	    //System.out.println("infoList");
	    //List<String> idList = dao.listPlayId(); // play id 리스트
	    //List<String> stList = dao.listStageId(); // stage id 리스트 
	    List<PlayVO> delist1 = dao.listPlay(); // play detail
	    List<StageVO> delist2 = dao2.listStage(); // stage detail
	    
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
