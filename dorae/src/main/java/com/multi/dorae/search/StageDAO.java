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
	
	//공연장 id로 공연장 정보 하나 검색
	public StageVO stageDetail(String stage_id) {
		System.out.println("stage 추가요청");
		System.out.println(stage_id);
		StageVO vo = my.selectOne("stage.one", stage_id);
		return vo;
	}
	
	public List<StageVO> stageLatLng(){
		System.out.println("stage 위도 경도 요청!");
		List<StageVO> list = my.selectList("stage.searchLatLng");
		System.out.println(list);
		return list;
	}
	
//	public List<String> listId() {
//		List<String> list=my.selectList("place.idList");
//		return list;
//	}
}
