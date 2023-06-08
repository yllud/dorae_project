package com.multi.dorae.sns;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SnsService {

	@Autowired
	SnsDAO dao;

	// 추천 검색어 리스트 가져오기
	public List<String> list() {
		return dao.recommend();
	}

	// 추천 검색어 검색 결과 도출을 위해 변형
	public List<String> modifiedQuery() {
		List<String> recommend = dao.recommend();
		List<String> modifiedRecommend = new ArrayList<>(); // 검색어 수정을 위한 조정

		// 검색어에 괄호가 있을 경우 괄호 및 괄호 안 내용 제거
		for (String query : recommend) {
			String modifiedQuery = query.replaceAll("\\s*\\[.*?\\]|\\s*\\(.*?\\)$", "").trim();
			modifiedRecommend.add(modifiedQuery);
		}

		return modifiedRecommend;
	}
}
