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
	
	public ContactVO one(long contact_id) {
		return sql.selectOne("contact.selectOne", contact_id);
	}
	
	public List<ContactVO> listAll() {
		return sql.selectList("contact.selectListAll");
	}
	
	public List<ContactVO> list() {
		return sql.selectList("contact.selectList");
	}
	
	public List<ContactVO> listByMemberId(String member_id) {
		return sql.selectList("contact.selectListMemberId", member_id);
	}
	
	public int answerUpdate(ContactVO vo) {
		return sql.update("contact.answerUpdate", vo);
	}
	
}
