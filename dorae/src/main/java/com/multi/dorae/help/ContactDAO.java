package com.multi.dorae.help;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ContactDAO {
	
	@Autowired
	SqlSessionTemplate sql;

	public int insert(ContactVO vo) {
		return sql.insert("contact.insert", vo);
	}
	
	public int delete(long contact_id) {
		return sql.delete("contact.delete", contact_id);
	}
	
	public ContactVO one(long contact_id) {
		return sql.selectOne("contact.selectOne", contact_id);
	}
	
	public List<ContactVO> list() {
		return sql.selectList("contact.selectList");
	}
	
	public List<ContactVO> listWithPaging(PageVO pageVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		pageVO.calc();

		map.put("start", pageVO.getStart());
		map.put("end", pageVO.getEnd());
		map.put("cntPerPage", pageVO.getCntPerPage());
		
		return sql.selectList("contact.selectListWithPaging", map);
	}
	
	public List<ContactVO> listByMemberIdWithPaging(PageVO pageVO, String member_id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		pageVO.calc();

		map.put("start", pageVO.getStart());
		map.put("end", pageVO.getEnd());
		map.put("member_id", member_id);
		
		return sql.selectList("contact.selectListByMemberIdWithPaging", map);
	}
	
	public int count() {
		return sql.selectOne("contact.count");
	}
	
	public int updateAnswer(ContactVO vo) {
		return sql.update("contact.updateAnswer", vo);
	}
	
}
