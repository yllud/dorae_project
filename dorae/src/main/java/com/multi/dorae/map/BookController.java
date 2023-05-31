package com.multi.dorae.map;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.mypage.MypagePageVO;

@RequestMapping("book")
@Controller //스프링에서 제어하는 역할로 등록! 
public class BookController {

	@Autowired
	HttpSession session;
	
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
		//System.out.println("count요청됨.");
		
		int result = service.count(play_id);
		return result;
	}	
	
	@RequestMapping("select_my")
	public String mybook(String email, Model model) {
		//System.out.println("mybook요청됨.");
		
		List<BookVO> list = service.mybook(email);
	    model.addAttribute("list", list);
	    
		return "book/bookList";
	}	
	
	@RequestMapping("bookList")
	public void bookList(MypagePageVO vo, Model model) {
	    String email = (String) session.getAttribute("email");
	    
	    List<BookVO> list = service.mybook(email);
	    //List<PlayVO> list2 = new ArrayList<>(); // 각 공연의 상세 정보 리스트
	    
	    /* for (BookVO book : list) {
	        List<PlayVO> detail = service.mybook_detail(book.play_id);
	        list2.addAll(detail);
	    }*/

	    model.addAttribute("list", list);
	    //model.addAttribute("list2", list2);
	}
	
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
