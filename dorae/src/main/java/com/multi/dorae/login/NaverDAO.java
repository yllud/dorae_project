package com.multi.dorae.login;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class NaverDAO {

	@Autowired
	SqlSessionTemplate mn;
	
	public int insert(NaverVO bag) {
		int result = 0;
		try {
			result = mn.insert("naverMember.naverInsert", bag);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

}
