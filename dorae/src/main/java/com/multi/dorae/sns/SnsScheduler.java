package com.multi.dorae.sns;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import twitter4j.TwitterException;

@Component("snsScheduler")
public class SnsScheduler {

	@Autowired
	BlogDAO blogDao;
	@Autowired
	TwitterDAO twitterDao;
	@Autowired
	SnsDAO snsDao;

	// 초 분 시 일 월 일
	@Scheduled(cron = "0 10 0 * * *") // 매일 오전 00시 10분에 최신화
	public void auto() throws TwitterException {
		drop(); // 블로그, 트위터 컬렉션 drop
		List<String> recommend = recommend(); // 추천검색어 추출
		List<String> modifiedRecommend = new ArrayList<>(); // 검색어 수정을 위한 조정
		
		// 검색어에 괄호가 있을 경우 괄호 및 괄호 안 내용 제거
		for (String query : recommend) {
	        String modifiedQuery = query.replaceAll("\\s*\\[.*?\\]|\\s*\\(.*?\\)$", "").trim();
	        modifiedRecommend.add(modifiedQuery);
	    }
		
		for (int i = 0; i < modifiedRecommend.size(); i++) {
	        String query = modifiedRecommend.get(i);
	        int rank = i + 1;
	        saveBlog(query, rank); // 수정된 추천검색어 + 랭크값 설정해서 db저장
	    }
	    System.out.println("블로그 저장 완료");

	    for (int i = 0; i < modifiedRecommend.size(); i++) {
	        String query = modifiedRecommend.get(i);
	        int rank = i + 1;
	        saveTweets(query, rank); // 수정된 추천검색어 + 랭크값 설정해서 db저장
	    }
		System.out.println("트위터 저장 완료");
	}

	// 블로그, 트위터 컬렉션 drop 메서드
	public void drop() {
		if (blogDao.check() == true) { // 컬렉션이 있다면 드랍하기
			blogDao.drop();
		}
		if (twitterDao.check() == true) {
			twitterDao.drop();
		}
	}

	// 추천검색어 추출 메서드
	public List<String> recommend() {
		List<String> list = snsDao.recommend();
		return list;
	}

	// 키워드로 검색한 블로그 데이터를 몽고db 저장 메서드
	public void saveBlog(String query, int rank) {
		ArrayList<BlogVO> resultList = BlogAPI.searchNaverBlog(query);
		// 각 입력에 대해 rank 값을 설정
		for (BlogVO blog : resultList) {
			blog.setRank(rank);
		}
		blogDao.insert(resultList);
	}

	// 키워드로 검색한 트위터 데이터를 몽고db 저장 메서드
	public void saveTweets(String query, int rank) throws TwitterException {
		List<TwitterVO> tweets = TwitterAPI.searchTweets(query);
		// 각 입력에 대해 rank 값을 설정
		for (TwitterVO twitter : tweets) {
			twitter.setRank(rank);
		}
		twitterDao.insert(tweets);
	}

}
