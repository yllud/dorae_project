package com.multi.dorae.sns;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


//테이블 하나당 DAO하나! ==> CUD를 완성!! 
@Component
public class HashtagDAO {

	@Autowired
	SqlSessionTemplate my;

	public int insert(String keyword) {
		int result = my.insert("hashtag.create", keyword);
		return result;
	}

	public int update(HashtagVO bag) {
		int result = my.update("hashtag.up", bag);
		return result;
	}
	
	public HashtagVO one(String keyword) {
		HashtagVO bag = my.selectOne("hashtag.one", keyword);
		return bag;
	}
	
	
	public List<HashtagVO> list() {
		List<HashtagVO> list = my.selectList("hashtag.all");
		return list;
	}
}
