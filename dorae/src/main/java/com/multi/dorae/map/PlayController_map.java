package com.multi.dorae.map;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class PlayController_map {

	@Autowired
	PlayServiceInterface service;

	@RequestMapping(value ="map/infoList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String infoList() throws Exception {
	    String json = service.infoList();
	    return json;
	}
}
