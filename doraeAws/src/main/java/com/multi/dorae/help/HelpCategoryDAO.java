package com.multi.dorae.help;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HelpCategoryDAO {
	
	@Autowired
	SqlSessionTemplate sql;
	
	public int insert(HelpCategoryVO vo) {
		return sql.insert("helpCategory.insert", vo);
	}
	
	public int updateName(HelpCategoryVO vo) {
		return sql.update("helpCategory.updateName", vo);
	}
	
	public List<HelpCategoryVO> listByParentId(String parent_category_id) {
		return sql.selectList("helpCategory.selectListByParentId", parent_category_id);
	}
	
}
