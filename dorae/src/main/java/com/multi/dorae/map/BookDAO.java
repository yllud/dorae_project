package com.multi.dorae.map;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
public class BookDAO implements BookDAOInterface{
	@Autowired
	SqlSessionTemplate my;
	
	@Override
	public int insert(BookVO bag) {
		int result = my.insert("book.create", bag);
		return result;
	}
	
	@Override
	public int delete(BookVO bag) {
		int result = my.delete("book.del", bag);
		return result;
	}	

	@Override
	public int count(String play_id) {
		int result = my.selectOne("book.cnt", play_id);
		return result;
	}
	
	@Override
	public List<BookVO> mybook(String email) {
		List<BookVO> list = my.selectList("book.my", email);
		return list;
	}
}
