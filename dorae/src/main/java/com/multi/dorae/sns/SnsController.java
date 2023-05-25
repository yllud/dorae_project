package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SnsController {

	@Autowired
	SnsDAO dao;
	
//	추천검색어 추출
	@RequestMapping("sns/recommend")
	@ResponseBody
	public List<String> recommend() {
		List<String> list = dao.recommend();
		return list;
	}
}
