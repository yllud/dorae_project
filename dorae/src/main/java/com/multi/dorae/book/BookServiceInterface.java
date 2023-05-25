package com.multi.dorae.book;

import java.util.List;

public interface BookServiceInterface {

	int insert(BookVO bag);

	int delete(String play_id);

	List<BookVO> all(String email);

}