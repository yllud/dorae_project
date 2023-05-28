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
	public int delete(BookVO bag) {
		int result = dao.delete(bag);
		return result;
	}	

	@Override
	public int count(String play_id) {
		int result = dao.count(play_id);
		return result;
	}

	@Override
	public List<BookVO> mybook(String email) {
		List<BookVO> list = dao.mybook(email);
		return list;
	}
}
