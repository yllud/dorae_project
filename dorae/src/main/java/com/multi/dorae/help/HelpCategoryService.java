package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HelpCategoryService {
	
	@Autowired
	HelpCategoryDAO helpCategoryDAO;
	
	public int helpCategoryCreate(HelpCategoryVO vo) {
		return helpCategoryDAO.insert(vo);
	}
	
	public int updateName(HelpCategoryVO vo) {
		return helpCategoryDAO.updateName(vo);
	}
	
	public List<HelpCategoryVO> selectListByParentId(String parentCategory_id) {
		return helpCategoryDAO.selectListByParentId(parentCategory_id);
	}
}
