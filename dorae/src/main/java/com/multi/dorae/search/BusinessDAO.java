package com.multi.dorae.search;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BusinessDAO {
	
	// mybatis 싱글톤 객체 찾아서 주소 넣어줌
	@Autowired
	SqlSessionTemplate my;
	
	
	// 공연 페이지 리스트로 불러오기
	public List<PlayVO> list(CriteriaB cri) {
		System.out.println("(DAO) List");
		List<PlayVO> list = my.selectList("business.page", cri);
		for (PlayVO bag : list) {
			System.out.println(bag.getPlay_name());
		}
		return list;
	}

	// 리시트 개수
	public int count(CriteriaB cri) {
		System.out.println("(DAO) count");
		int cnt = my.selectOne("business.count", cri);
		System.out.println(cnt);
		return cnt;
		
	}
}
