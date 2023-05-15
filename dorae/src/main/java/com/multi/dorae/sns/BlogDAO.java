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

import com.multi.dorae.search.RankVO;

@Repository
public class BlogDAO {

	@Autowired
	MongoTemplate mongo;
	
	@Autowired
	SqlSessionTemplate my;
	
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
	
	// 추천 검색어 리스트 뽑아오기
	public List<String> recommend() {
		List<String> recommendKeyword = my.selectList("blog.recommend");
		return recommendKeyword;
	}
	
//	추천 검색어에 해당하는 db결과값 반환
	public List<BlogVO> list2(String input) {
		Query query = new Query();
		Criteria criteria = new Criteria();
		criteria.orOperator(
				Criteria.where("title").regex(input, "i"),
				Criteria.where("description").regex(input, "i")				
				);
		query.addCriteria(criteria);
		return mongo.find(query, BlogVO.class, "blog");
	}
}
