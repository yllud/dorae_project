package com.multi.dorae.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller //스프링에서 제어하는 역할로 등록! 
public class BookController {

	@Autowired
	BookService service;
	
//	@Autowired
//	ReplyDAO dao2;
	
	@RequestMapping("insert_book")
	@ResponseBody
	public String insert(BookVO bag) {
		System.out.println("insert_book요청됨.");
		
		int result = service.insert(bag);
		if (result > 0) {
	        return "success";
	    } else {
	        return "failure";
	    }
	}
	
	@RequestMapping("delete_book")
	@ResponseBody
	public String delete(BookVO bag) {
		System.out.println("delete_book요청됨.");
		
		int result = service.delete(bag);
		if (result > 0) {
	        return "success";
	    } else {
	        return "failure";
	    }
	}	
	
	@RequestMapping("select_count")
	@ResponseBody
	public int count(String play_id) {
		System.out.println("count요청됨.");
		
		int result = service.count(play_id);
		return result;
	}	
	
	@RequestMapping("select_my")
	@ResponseBody
	public List<BookVO> mybook(String email) {
		System.out.println("mybook요청됨.");
		
		List<BookVO> list = service.mybook(email);
		return list;
	}	
	
//	@RequestMapping("one_book")
//	public void one(int id, Model model) {
//		System.out.println("one요청됨.");
//		System.out.println(id);
//		BookVO bag = dao.one(id);
//		model.addAttribute("bag", bag);
//	}
	
//	@RequestMapping("all_book")
//	public String all(String email, Model model) {
//		System.out.println("all요청됨.");
//		System.out.println(email);
//		List<BookVO> list = service.all(email);
//		model.addAttribute("list", list);
//		
//		return "book/all_book";
//	}
	
}
