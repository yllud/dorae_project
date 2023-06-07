package com.multi.dorae.mypage;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.Data;

@Controller //스프링에서 제어하는 역할로 등록! 
public class TicketController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	TicketDAO dao;
	
//	@RequestMapping("mypage/ticketList")
//	public void replyList(Model model) {
//		System.out.println("ticketList 요청됨");
//	    String email = (String) session.getAttribute("email");
//	    List<TicketVO> list = dao.listByEmail(email);
//	    System.out.println(list.size());
//	    //views아래 list를 전달 
//	    model.addAttribute("list", list);
//	    //그 다음에 무조건 views/mypage/replyList로 감.
//	    //다른 곳으로 가고 싶을 때에는 return 사용!
//	}
	
	// 예매내역 페이징
		@RequestMapping("mypage/ticketList")
		public void ticketList(MypagePageVO vo, Model model) {
		    vo.mypageStartEnd(vo.getPage());
		    String email = (String) session.getAttribute("email");
		    
		    int count = dao.ticketCount();
		    int pages = count / 10 + 1;
		    
		    Map<String, Object> map = new HashMap<>();
		    map.put("email", email);
		    map.put("start", vo.getStart());
		    map.put("end", vo.getEnd());
		    
		    List<TicketVO> list = dao.ticketPaging(map);

		    model.addAttribute("list", list);
		    model.addAttribute("count", count);
		    model.addAttribute("pages", pages);
		}
		
		// 페이징 - 두번째 페이지 이상일 경우 사용
		@RequestMapping("mypage/ticketList2")
		public void ticketList2(MypagePageVO vo, Model model) {
		    vo.mypageStartEnd(vo.getPage());
		    String email = (String) session.getAttribute("email");
		   
		    
		    Map<String, Object> map = new HashMap<>();
		    map.put("email", email);
		    map.put("start", vo.getStart());
		    map.put("end", vo.getEnd());
		    List<TicketVO> list = dao.ticketPaging(map);

		    // list만 가져와서 보여주는거라 count,pages 필요X
		    model.addAttribute("list", list);
		}
		
		@RequestMapping("mypage/mypage")
		public void myList(MypagePageVO vo, Model model) {
		    vo.mypageStartEnd(vo.getPage());
		    String email = (String) session.getAttribute("email");
		    
		    int count = dao.ticketCount();
		    int pages = count / 10 + 1;
		    
		    Map<String, Object> map = new HashMap<>();
		    map.put("email", email);
		    map.put("start", vo.getStart());
		    map.put("end", vo.getEnd());
		    
		    List<TicketVO> list = dao.ticketPaging(map);

		    model.addAttribute("list", list);
		    model.addAttribute("count", count);
		    model.addAttribute("pages", pages);
		}
}
