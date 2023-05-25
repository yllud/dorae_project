package com.multi.dorae.sns;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SnsDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 추천 검색어 리스트 뽑아오기
		public List<String> recommend() {
			List<String> recommendKeyword = my.selectList("sns.recommend");
			return recommendKeyword;
		}
}
