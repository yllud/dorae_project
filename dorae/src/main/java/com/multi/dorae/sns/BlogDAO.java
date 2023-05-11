package com.multi.dorae.sns;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class BlogDAO {

	@Autowired
	MongoTemplate mongo;
	
//	검색 결과를 db에 넣기
	public void insert(ArrayList<BlogVO> resultList) {
		mongo.insert(resultList, "blog");
	}
	
	// blog db 가져오기
	public List<BlogVO> list() {
		Query query = new Query();
		query.with(new Sort(Sort.Direction.DESC, "postdate"));
		return (List<BlogVO>) mongo.find(query, BlogVO.class, "blog");
	}
}
