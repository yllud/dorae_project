package com.multi.dorae.sns;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class BlogDAO {

	@Autowired
	MongoTemplate mongo;

	@Autowired
	SqlSessionTemplate my;

	// 추천 검색어 리스트 뽑아오기
	public List<String> recommend() {
		List<String> recommendKeyword = my.selectList("blog.recommend");
		return recommendKeyword;
	}

	// 검색 결과를 db에 넣기
	public void insert(ArrayList<BlogVO> resultList) {
		mongo.insert(resultList, "blog");
	}

	// 추천 검색어에 해당하는 db결과값 반환
	public List<BlogVO> list(int rank) { // 검색어에 해당하는 rank값
		Query query = new Query();
		Criteria criteria = Criteria.where("rank").is(rank);
		query.addCriteria(criteria);
		query.fields().exclude("rank"); // 반환값 rank 필드 제외

		return mongo.find(query, BlogVO.class, "blog");
	}
}
