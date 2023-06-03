package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import twitter4j.TwitterException;

@Service
public class TwitterService {

	@Autowired
	TwitterDAO dao;
	@Autowired
	TwitterAPI twitterApi;

//	키워드로 검색한 트위터 data 가져오기
	public List<TwitterVO> list(int rankNum) {
		return dao.search(rankNum);
	}

	// 키워드로 검색한 트위터 데이터를 db 저장 메서드
	public void saveTweets(String query, int rankNum) throws TwitterException {
		List<TwitterVO> tweets = twitterApi.searchTweets(query);
		// 각 입력에 대해 rankNum 값을 설정
		for (TwitterVO twitter : tweets) {
			twitter.setRankNum(rankNum);
			dao.insert(twitter);
		}
	}
	
	// db 내용이 있다면 row 삭제
	public void delete() {
		if (dao.count() != 0) {
			dao.delete();
		}
	}
}
