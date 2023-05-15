package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import twitter4j.TwitterException;

@Controller
public class TwitterController {

	@Autowired
	TwitterDAO dao;
	
	@RequestMapping("sns/twitterSearch")
	@ResponseBody
	public List<TwitterVO> searchTweets(@RequestParam("keyword") String keyword) throws TwitterException {
		List<TwitterVO> tweets = TwitterAPI.searchTweets(keyword);
//		검색 결과를 몽고db에 저장
		dao.insert(tweets);
//		결과 화면 출력을 위해 반환
		return tweets;
	}
	

	
	
	@RequestMapping("sns/twitterList")
	public void list(Model model) {
		List<TwitterVO> list = dao.list();
		model.addAttribute("list", list);
	}
	
	// 추천검색어 트위터 검색 후 db 저장
	@RequestMapping("sns/saveTwitter")
	public void saveTweets(String query) throws TwitterException {
		List<TwitterVO> tweets = TwitterAPI.searchTweets(query);
		dao.insert(tweets);
	}
	
	
}
