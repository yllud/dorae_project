package com.multi.dorae.book;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BookDAO {
	@Autowired
	SqlSessionTemplate my;
	
	public int delete(int id) {
		int result = my.insert("book.del", id);
		return result;
	}	
	
	public int insert(BookVO bag) {
		int result = my.insert("book.create", bag);
		return result;
	}
	
	public List<BookVO> all(String email) {
		List<BookVO> list = my.selectList("book.all", email);
		return list;
	}
}
