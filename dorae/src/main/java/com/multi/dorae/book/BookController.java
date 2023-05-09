package com.multi.dorae.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller //스프링에서 제어하는 역할로 등록! 
public class BookController {

	@Autowired
	BookDAO dao;
	
//	@Autowired
//	ReplyDAO dao2;
	
	@RequestMapping("insert_book")
	public void insert(BookVO bag) {
		System.out.println("insert_book요청됨.");
		System.out.println(bag);
		System.out.println(dao);
		
		dao.insert(bag);
	}
	@RequestMapping("delete_book")
	public void delete(String email) {
		System.out.println("delete_book요청됨.");
		System.out.println(email);
		dao.delete(email);
	}	
	
//	@RequestMapping("one_book")
//	public void one(int id, Model model) {
//		System.out.println("one요청됨.");
//		System.out.println(id);
//		BookVO bag = dao.one(id);
//		model.addAttribute("bag", bag);
//	}
	
	@RequestMapping("all_book")
	public void all(String email, Model model) {
		System.out.println("all요청됨.");
		System.out.println(email);
		List<BookVO> list = dao.all(email);
		model.addAttribute("list", list);
	}
}