package com.multi.dorae.search;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component 
public class PlayDAO {
	
	// mybatis 싱글톤 객체 찾아서 주소 넣어줌
	@Autowired
	SqlSessionTemplate my;

	public int insert(PlayVO bag) {
		int result = my.insert("play.create", bag);
		return result;
	}
	
	public List<String> listPlayId() {
		List<String> list=my.selectList("play.playIdList");
		return list;
	}
	
	public List<String> listStageId() {
		List<String> list=my.selectList("play.stageIdList");
		return list;
	}
	
	public List<PlayVO> list(){
		System.out.println("list dao입니다...");
		List<PlayVO> list=my.selectList("play.all");
		for(PlayVO bag:list) {
			System.out.println(bag.getPlay_name());
		}
		return list;
	}
}
