package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import twitter4j.TwitterException;

@Component("snsScheduler")
public class SnsScheduler {

	@Autowired
	BlogService blogService;
	@Autowired
	TwitterService twitterService;
	@Autowired
	SnsService snsService;

	// 초 분 시 일 월 일
	@Scheduled(cron = "0 37 14 * * *") // 매일 오전 00시 10분에 최신화
	public void auto() throws TwitterException {
		// 블로그, 트위터 row 삭제 메서드
		blogService.delete();
		System.out.println("블로그 기존 데이터 삭제 완료");
		twitterService.delete();
		System.out.println("트위터 기존 데이터 삭제 완료");
		
		List<String> modifiedRecommend = snsService.modifiedQuery();
		
		for (int i = 0; i < modifiedRecommend.size(); i++) {
	        String query = modifiedRecommend.get(i);
	        int rankNum = i + 1;
	        blogService.saveBlog(query, rankNum); // 수정된 추천검색어 + 랭크값 설정해서 db저장
	    }
	    System.out.println("블로그 저장 완료");

	    for (int i = 0; i < modifiedRecommend.size(); i++) {
	        String query = modifiedRecommend.get(i);
	        int rankNum = i + 1;
	        twitterService.saveTweets(query, rankNum); // 수정된 추천검색어 + 랭크값 설정해서 db저장
	    }
		System.out.println("트위터 저장 완료");
	}


}
