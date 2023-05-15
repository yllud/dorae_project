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

	// 추천검색어 트위터 검색 후 db 저장
	@RequestMapping("sns/saveTwitter")
	public void saveTweets(String query, int rank) throws TwitterException {
		List<TwitterVO> tweets = TwitterAPI.searchTweets(query);
		// 각 입력에 대해 rank 값을 설정
		for (TwitterVO twitter : tweets) {
			twitter.setRank(rank);
		}
		dao.insert(tweets);
	}


	
//	키워드로 검색한 블로그 data 가져오기
	@RequestMapping("sns/twitterList")
	public void list2(int rank, Model model) {
		List<TwitterVO> list = dao.list(rank);
		model.addAttribute("list", list);
	}

}
