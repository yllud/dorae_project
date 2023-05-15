package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FaqService {
	
	@Autowired
	FaqDAO faqDAO;
	
	public int faqCreate(FaqVO vo) {
		return faqDAO.insert(vo);
	}
	
	public int answerUpdate(FaqVO vo) {
		return faqDAO.answerUpdate(vo);
	}
	
	public FaqVO faqOne(int faq_id) {
		return faqDAO.selectOne(faq_id);
	}
	
	public List<FaqVO> faqList() {
		return faqDAO.selectList();
	}
	
	public List<FaqVO> faqListByHelpCategory(String help_category_id) {
		return faqDAO.selectListByCategory(help_category_id);
	}
	
	public List<FaqVO> faqBySearch(String search) {
		return faqDAO.selectListBySearch(search);
	}
}
