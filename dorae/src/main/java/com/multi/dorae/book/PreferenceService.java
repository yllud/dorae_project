//PreferenceService.java
package com.multi.dorae.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PreferenceService implements PreferenceServiceInterface{
	
	@Autowired
	PreferenceDAOInterface dao;
	
	@Override
	public int insert(PreferenceVO bag) {
		int result = dao.insert(bag);
		return result;
	}
	
	@Override
	public List<PreferenceVO> mypreference(String email) {
		List<PreferenceVO> list = dao.mypreference(email);
		return list;
	}
	
}
