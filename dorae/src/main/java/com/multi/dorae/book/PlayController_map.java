package com.multi.dorae.book;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
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

@Controller
public class PlayController_map {

	@Autowired
	PlayServiceInterface service;

	@RequestMapping(value = "map/infoList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String infoList() throws Exception {
	    String json = service.infoList();
	    return json;
	}
}
