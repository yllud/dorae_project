package com.multi.dorae.help;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ContactDAO {
	
	@Autowired
	SqlSessionTemplate sql;

	public int create(ContactVO vo) {
		return sql.insert("contact.create", vo);
	}
	
	public int updateAnswer(ContactVO vo) {
		return sql.update("contact.updateAnswer", vo);
	}
	
	public List<ContactVO> selectList(String member) {
		return sql.selectList("contact.selectList", member);
	}
	
}
