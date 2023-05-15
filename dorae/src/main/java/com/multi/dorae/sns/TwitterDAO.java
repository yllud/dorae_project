package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class TwitterDAO {

	@Autowired
	MongoTemplate mongo;

	// 검색 결과를 db에 넣기
	public void insert(List<TwitterVO> tweets) {
		mongo.insert(tweets, "twitter");
	}

	// 추천 검색어에 해당하는 db결과값 반환
	public List<TwitterVO> list(int rank) { // 검색어에 해당하는 rank값
		Query query = new Query();
		Criteria criteria = Criteria.where("rank").is(rank);
		query.addCriteria(criteria);
		query.fields().exclude("rank"); // 반환값 rank 필드 제외

		return mongo.find(query, TwitterVO.class, "twitter");
	}
}
