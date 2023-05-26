package com.multi.dorae.mypage;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ReviewListDAO {
	@Autowired
	SqlSessionTemplate my;

	//윤진 수정한것
	public List<ReviewListVO> listByEmail(String email) {
		 List<ReviewListVO> list = my.selectList("mypageList.listByEmail", email);
		    return list;
		}
}
