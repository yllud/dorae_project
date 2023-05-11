package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class TwitterDAO {

	@Autowired
	MongoTemplate mongo;

//	검색 결과를 db에 넣기
	public void insert(List<TwitterVO> tweets) {
		mongo.insert(tweets, "twitter");
	}
	
	// twitter db 가져오기
		public List<TwitterVO> list() {
			Query query = new Query();
			// 정렬기준 필요
			return (List<TwitterVO>) mongo.find(query, TwitterVO.class, "twitter");
		}

}
