package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class TwitterController {

	@Autowired
	TwitterService twitterService;
	@Autowired
	TwitterAPI twitterApi;

//	키워드로 검색한 트위터 data 가져오기
	@RequestMapping("sns/twitterList")
	public void list2(int rankNum, Model model) {
		List<TwitterVO> list = twitterService.list(rankNum);
		model.addAttribute("list", list);
	}
	
}
