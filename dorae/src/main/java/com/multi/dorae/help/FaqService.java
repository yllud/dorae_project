package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FaqService {
	
	@Autowired
	FaqDAO faqDAO;
	
	public int create(FaqVO vo) {
		return faqDAO.insert(vo);
	}
	
	public int updateAnswer(FaqVO vo) {
		return faqDAO.updateAnswer(vo);
	}
	
	public FaqVO one(int faq_id) {
		return faqDAO.one(faq_id);
	}
	
	public List<FaqVO> list() {
		return faqDAO.list();
	}
	
	public List<FaqVO> listByCategory(String help_category_id) {
		return faqDAO.listByCategory(help_category_id);
	}
	
	public List<FaqVO> listBySearch(String search) {
		return faqDAO.listBySearch(search);
	}
}
