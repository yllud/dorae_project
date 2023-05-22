package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HelpCategoryService {
	
	@Autowired
	HelpCategoryDAO helpCategoryDAO;
	
	public int insertCategory(HelpCategoryVO vo) {
		return helpCategoryDAO.insert(vo);
	}
	
	public int updateName(HelpCategoryVO vo) {
		return helpCategoryDAO.updateName(vo);
	}
	
	public List<HelpCategoryVO> listByParentId(String parent_category_id) {
		return helpCategoryDAO.listByParentId(parent_category_id);
	}
}
