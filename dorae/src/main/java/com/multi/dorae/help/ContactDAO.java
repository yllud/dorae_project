package com.multi.dorae.help;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ContactDAO {
	
	@Autowired
	SqlSessionTemplate sql;

	public int insert(ContactVO vo) {
		return sql.insert("contact.create", vo);
	}
	
	public int delete(long contact_id) {
		return sql.delete("contact.delete", contact_id);
	}
	
	public ContactVO selectOne(long contact_id) {
		return sql.selectOne("contact.selectOne", contact_id);
	}
	
	public List<ContactVO> selectList(String member) {
		return sql.selectList("contact.selectList", member);
	}
	
	public int answerUpdate(ContactVO vo) {
		return sql.update("contact.answerUpdate", vo);
	}
	
}
