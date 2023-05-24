package com.multi.dorae.mypage;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

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
	
	@RequestMapping("mypage/ticketList")
	public void replyList(Model model) {
		System.out.println("ticketList 요청됨");
	    String email = (String) session.getAttribute("email");
	    List<TicketVO> list = dao.listByEmail(email);
	    System.out.println(list.size());
	    //views아래 list를 전달 
	    model.addAttribute("list", list);
	    //그 다음에 무조건 views/mypage/replyList로 감.
	    //다른 곳으로 가고 싶을 때에는 return 사용!
	}
	
}
