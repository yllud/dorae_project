package com.multi.dorae.help;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FaqDAO {
	
	@Autowired
	SqlSessionTemplate sql;
	
	public int insert(FaqVO vo) {
		return sql.insert("faq.create", vo);
	}
	
	public int answerUpdate(FaqVO vo) {
		return sql.update("faq.answerUpdate", vo);
	}
	
	public FaqVO selectOne(int faq_id) {
		return sql.selectOne("faq.selectOne", faq_id);
	}
	
	public List<FaqVO> selectList() {
		return sql.selectList("faq.selectList");
	}
	
	public List<FaqVO> selectListWithPaging() {
		return sql.selectList("faq.selectListWithPaging");
	}
	
	public List<FaqVO> selectListByCategory(String help_category_id) {
		return sql.selectList("faq.selectListByHelpCategory", help_category_id);
	}
	
	public List<FaqVO> selectListBySearch(String search) {
		return sql.selectList("faq.selectListBySearch", search);
	}
}
