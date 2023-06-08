package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class HelpCategoryService {
	
	@Autowired
	HelpCategoryDAO helpCategoryDAO;
	
	public int insertCategory(HelpCategoryVO categoryVO) {
		return helpCategoryDAO.insert(categoryVO);
	}
	
	public int updateName(HelpCategoryVO categoryVO) {
		return helpCategoryDAO.updateName(categoryVO);
	}
	
	public List<HelpCategoryVO> listByParentId(String parent_category_id) {
		if (parent_category_id == null || !StringUtils.hasText("None")) {
			parent_category_id = "None";
		}
		
		return helpCategoryDAO.listByParentId(parent_category_id);
	}
	
}
