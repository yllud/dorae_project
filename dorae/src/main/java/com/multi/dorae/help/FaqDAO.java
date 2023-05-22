package com.multi.dorae.help;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FaqDAO {
	
	@Autowired
	SqlSessionTemplate sql;
	
	public int insert(FaqVO vo) {
		return sql.insert("faq.insert", vo);
	}
	
	public int updateAnswer(FaqVO vo) {
		return sql.update("faq.updateAnswer", vo);
	}
	
	public FaqVO one(int faq_id) {
		return sql.selectOne("faq.selectOne", faq_id);
	}
	
	public List<FaqVO> list() {
		return sql.selectList("faq.selectList");
	}
	
	public List<FaqVO> listWithPaging() {
		return sql.selectList("faq.selectListWithPaging");
	}
	
	public List<FaqVO> listByCategoryWithPaging(String help_category_id, PageVO pageVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("help_category_id", help_category_id);
		map.put("start", pageVO.getStart());
		map.put("end", pageVO.getEnd());
		
		return sql.selectList("faq.selectListByHelpCategoryWithPaging", map);
	}
	
	public List<FaqVO> listByCategory(String help_category_id) {
		return sql.selectList("faq.selectListByHelpCategory", help_category_id);
	}
	
	public List<FaqVO> listBySearch(String search) {
		return sql.selectList("faq.selectListBySearch", search);
	}
	
	public int count() {
		return sql.selectOne("faq.count");
	}
	
	public int countByCategory(String help_category_id) {
		return sql.selectOne("faq.countByCategory", help_category_id);
	}
}
