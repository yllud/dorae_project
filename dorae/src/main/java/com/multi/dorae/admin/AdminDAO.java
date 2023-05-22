package com.multi.dorae.admin;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {
	
	@Autowired
	SqlSessionTemplate sql;
	
	public int insert(AdminVO adminVO) {
		return sql.insert("admin.insert", adminVO);
	}
	
	public AdminVO one(String id) {
		return sql.selectOne("admin.selectOne", id);
	}
}
