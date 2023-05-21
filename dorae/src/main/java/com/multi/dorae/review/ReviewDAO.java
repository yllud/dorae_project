package com.multi.dorae.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public List<ReviewVO> all(ReviewPageVO vo) {
		return my.selectList("review.all", vo);
	}
	
	public List<ReviewVO> tagSearch(ReviewPageVO vo, String tag) {
		Map<String, Object> params = new HashMap<>();
	    params.put("tag", tag);
	    params.put("start", vo.getStart());
	    params.put("end", vo.getEnd());

	    return my.selectList("review.tagSearch", params);
	}
	
	public int count() {
		return my.selectOne("review.count");
	}
	
	public int tagCount(String tag) {
		return my.selectOne("review.tagCount", tag);
	}
}
