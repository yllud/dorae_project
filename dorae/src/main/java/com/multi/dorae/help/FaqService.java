package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FaqService {
	
	@Autowired
	FaqDAO faqDAO;
	
	public boolean create(FaqVO faqVO) {
		if (faqVO.getTitle() == null || faqVO.getTitle().trim().isEmpty()) {
			System.out.println("FAQ 제목이 없음");
			return false;
		}
		if (faqVO.getContent() == null || faqVO.getContent().trim().isEmpty()) {
			System.out.println("FAQ 내용이 없음");
			return false;
		}
		
		if (faqDAO.insert(faqVO) != 1) {
			System.out.println("FAQ 생성에 실패함");
			return false;
		}
		
		return true;
	}
	
	public boolean update(FaqVO faqVO) {
		if (faqVO.getTitle() == null || faqVO.getTitle().trim().isEmpty()) {
			System.out.println("FAQ 제목이 없음");
			return false;
		}
		if (faqVO.getContent() == null || faqVO.getContent().trim().isEmpty()) {
			System.out.println("FAQ 내용이 없음");
			return false;
		}
		
		if (faqDAO.update(faqVO) != 1) {
			System.out.println("FAQ 수정에 실패함");
			return false;
		}
		
		return true;
	}
	
	public FaqVO one(int faq_id) {
		return faqDAO.one(faq_id);
	}
	
	public List<FaqVO> listByCategory(String help_category_id) {
		if (help_category_id == null || help_category_id.trim().isEmpty()) {
			help_category_id = "D01";
		}
		
		return faqDAO.listByCategory(help_category_id);
	}
	
	public List<FaqVO> listByCategoryWithPaging(String help_category_id, PageVO pageVO) {
		if (help_category_id == null || help_category_id.trim().isEmpty()) {
			help_category_id = "D01";
		}
		
		return faqDAO.listByCategoryWithPaging(help_category_id, pageVO);
	}
	
	public List<FaqVO> listByWithPaging(String help_category_id, PageVO pageVO) {
		if (help_category_id == null || help_category_id.trim().isEmpty()) {
			help_category_id = "D01";
		}
		
		return faqDAO.listByCategoryWithPaging(help_category_id, pageVO);
	}
	
	public List<FaqVO> listBySearch(String search) {
		if (search == null || search.trim().isEmpty()) {
			return null;
		}
		
		return faqDAO.listBySearch(search);
	}
	
	public List<FaqVO> listBySearchWithPaging(String search, PageVO pageVO) {
		if (search == null || search.trim().isEmpty()) {
			return null;
		}
		
		return faqDAO.listBySearchWithPaging(search, pageVO);
	}
	
	public int count() {
		return faqDAO.count();
	}
	
	public int countByCategory(String help_category_id) {
		if (help_category_id == null || help_category_id.trim().isEmpty()) {
			help_category_id = "D01";
		}
		
		return faqDAO.countByCategory(help_category_id);
	}
}
