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
	
	public int update(FaqVO vo) {
		return sql.update("faq.update", vo);
	}
	
	public FaqVO one(int faq_id) {
		return sql.selectOne("faq.selectOne", faq_id);
	}
	
	public int delete(int faq_id) {
		return sql.delete("faq.delete", faq_id);
	}
	
	public List<FaqVO> list() {
		return sql.selectList("faq.selectList");
	}
	
	public List<FaqVO> listWithPaging(PageVO pageVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		pageVO.setTotal(count());
		pageVO.calc();
		
		map.put("start", pageVO.getStart());
		map.put("end", pageVO.getEnd());
		
		return sql.selectList("faq.selectListWithPaging", map);
	}
	
	public List<FaqVO> listByCategoryWithPaging(String help_category_id, PageVO pageVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		pageVO.setTotal(countByCategory(help_category_id));
		pageVO.calc();
		
		map.put("help_category_id", help_category_id);
		map.put("start", pageVO.getStart());
		map.put("end", pageVO.getEnd());
		
		return sql.selectList("faq.selectListByHelpCategoryWithPaging", map);
	}
	
	public List<FaqVO> listBySearchWithPaging(String search, PageVO pageVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		pageVO.setTotal(countBySearch(search));
		pageVO.calc();
		
		map.put("search", search);
		map.put("start", pageVO.getStart());
		map.put("end", pageVO.getEnd());
		
		return sql.selectList("faq.selectListBySearchWithPaging", map);
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
	
	public int countBySearch(String search) {
		return sql.selectOne("faq.countBySearch", search);
	}
}
