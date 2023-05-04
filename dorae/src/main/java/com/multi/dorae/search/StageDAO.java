package com.multi.dorae.search;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component 
public class StageDAO {
	
	// mybatis 싱글톤 객체 찾아서 주소 넣어줌
	@Autowired
	SqlSessionTemplate my;

	public int insert(StageVO bag) {
		System.out.println("stage 추가요청");
		System.out.println(bag);
		int result = my.insert("stage.create", bag);
		return result;
	}
	
//	public List<String> listId() {
//		List<String> list=my.selectList("place.idList");
//		return list;
//	}
}
