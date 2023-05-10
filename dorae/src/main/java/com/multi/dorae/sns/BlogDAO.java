package com.multi.dorae.sns;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BlogDAO {

	@Autowired
	MongoTemplate mongo;
	
//	검색 결과를 db에 넣기
	public void insert(ArrayList<BlogVO> resultList) {
		mongo.insert(resultList, "blog");
	}
}
