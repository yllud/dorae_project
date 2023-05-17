package com.multi.dorae.review;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ReviewDAO {
	@Autowired
	SqlSessionTemplate my;
	
	public void insert(ReviewVO vo) {
		my.insert("review.insert", vo);
	}
	
	public List<ReviewVO> all() {
		return my.selectList("review.all");
	}
	
	public List<ReviewVO> tagSearch(String tag) {
		return my.selectList("review.tagsearch", tag);
	}
}
