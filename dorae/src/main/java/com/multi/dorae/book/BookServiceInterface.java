package com.multi.dorae.book;

import java.util.List;

public interface BookServiceInterface {

	int insert(BookVO bag);

	int delete(BookVO bag);

	List<BookVO> count(String play_id);
	
	List<BookVO> mybook(String email);
	
}