package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class FaqService {
	
	@Autowired
	FaqDAO faqDAO;
	
	public boolean create(FaqVO faqVO) {
		if (!isValid(faqVO)) {
			return false;
		}
		
		if (faqDAO.insert(faqVO) != 1) {
			System.out.println("FAQ 생성에 실패함");
			return false;
		}
		
		return true;
	}
	
	public boolean updateAnswer(FaqVO faqVO) {
		if (!isValid(faqVO)) {
			return false;
		}
		
		if (faqDAO.updateAnswer(faqVO) != 1) {
			System.out.println("FAQ 수정에 실패함");
			return false;
		}
		
		return true;
	}
	
	public FaqVO one(int faq_id) {
		return faqDAO.one(faq_id);
	}
	
	public List<FaqVO> listByCategory(String help_category_id) {
		return faqDAO.listByCategory(help_category_id);
	}
	
	public List<FaqVO> listByCategoryWithPaging(String help_category_id, PageVO pageVO) {
		if (help_category_id == null || help_category_id.trim().isEmpty()) {
			help_category_id = "D01";
		}
		return faqDAO.listByCategoryWithPaging(help_category_id, pageVO);
	}
	
	public List<FaqVO> listBySearch(String search) {
		return faqDAO.listBySearch(search);
	}
	
	public int count() {
		return faqDAO.count();
	}
	
	public int countByCategory(String help_category_id) {
		return faqDAO.countByCategory(help_category_id);
	}
	
	private boolean isValid(FaqVO faqVO) {
		if (!StringUtils.hasText(faqVO.getTitle())) {
			System.out.println("FAQ 제목이 없음");
			return false;
		}
		if (!StringUtils.hasText(faqVO.getContent())) {
			System.out.println("FAQ 내용이 없음");
			return false;
		}
		return true;
	}
}
