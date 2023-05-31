package com.multi.dorae.map;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.search.PlayDAO;
import com.multi.dorae.search.PlayVO;

@RequestMapping("book")
@Controller // 스프링에서 제어하는 역할로 등록!
public class BookController {

	@Autowired
	HttpSession session;

	@Autowired
	BookService service;

//	@Autowired
	PlayDAO dao;

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
		// System.out.println("count요청됨.");

		int result = service.count(play_id);
		return result;
	}

	//지도에서 쓰이는 함수
	@RequestMapping("select_my")
	@ResponseBody
	public List<BookVO> mybook(String email) {
		//System.out.println("mybook요청됨.");
		
		List<BookVO> list = service.mybook(email);
		return list;
	}	

	//마이페이지에서 북마크 리스트 확인용
	@RequestMapping("bookList")
	public String bookList(String email, Model model) {

		List<BookVO> list = service.mybook(email);
		List<PlayVO> list2 = new ArrayList<>(); // 각 공연의 상세 정보 리스트

		for (BookVO book : list) {
			list2.add(dao.playDetail(book.play_id));
		}

		model.addAttribute("list", list);
		model.addAttribute("list2", list2);

		return "book/bookList";
	}

}
