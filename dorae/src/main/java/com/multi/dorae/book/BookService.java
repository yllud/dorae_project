package com.multi.dorae.book;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
public class BookService implements BookServiceInterface{
	
	@Autowired
	BookDAOInterface dao;
	
	@Override
	public int insert(BookVO bag) {
		int result = dao.insert(bag);
		return result;
	}
	
	
	@Override
	public int delete(String play_id) {
		int result = dao.delete(play_id);
		return result;
	}	

	
	@Override
	public List<BookVO> all(String email) {
		List<BookVO> list = dao.all(email);
		return list;
	}
}
