package com.multi.dorae.review;

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
}
