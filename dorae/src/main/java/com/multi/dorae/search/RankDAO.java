package com.multi.dorae.search;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component 
public class RankDAO {
	
	// mybatis 싱글톤 객체 찾아서 주소 넣어줌
	@Autowired
	SqlSessionTemplate my;

	public int insert(RankVO bag) {
		System.out.println("rank 추가요청");
		System.out.println(bag);
		int result = my.insert("rank.create", bag);
		return result;
	}
	
	public List<RankVO> rankList(String genre){
		List<RankVO> vo=my.selectList("rank.list", genre);
				
		return vo;
		
	}
	
	public int deleteRank(){
		int result=my.delete("rank.delete");
				
		return result;
		
	}
	
//	public List<String> listId() {
//		List<String> list=my.selectList("place.idList");
//		return list;
//	}
}
