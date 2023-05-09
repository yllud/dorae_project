package com.multi.dorae.sns;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import twitter4j.TwitterException;

@Controller
public class TwitterController {


	@RequestMapping("search2")
	@ResponseBody
	public List<TwitterVO> searchTweets(@RequestParam("keyword") String keyword) throws TwitterException {
		List<TwitterVO> tweets = TwitterAPI.searchTweets(keyword);
		return tweets;
	}
}
