package com.multi.dorae.mypage;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ReviewListDAO {
	@Autowired
	SqlSessionTemplate my;

	//수정한것
	public List<ReviewListVO> listByEmail(String email) {
		 List<ReviewListVO> list = my.selectList("mypageList.listByEmail", email);
		    return list;
		}
	
	// 페이징 처리
		 public List<ReviewListVO> reviewPaging(Map<String, Object> map) {
			    return my.selectList("mypageList.reviewPaging", map);
			}
		 // 페이징에 필요한 카운트 수
		 public int reviewCount() {
			 return my.selectOne("mypageList.reviewCount");
		 }
}
