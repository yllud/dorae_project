package com.multi.dorae.login;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class NaverDAO {

	@Autowired
	SqlSessionTemplate mn;
	
	public void insert(NaverVO bag) {
		mn.insert("naverMember.naverInsert", bag);
	}

}
