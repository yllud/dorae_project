package com.multi.dorae.mypage;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
public class ReplyController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	ReplyDAO dao;
	//컨트롤 하는 기능(CRUD)
	
	//클래스 내에서 기능처리 담당
	//멤버변수 + 멤버메서드(기능처리 담당)
	//하나의 요청당 하나의 메서드
	//하나의 버튼호출당 하나의 함수 연결!
	//요청된 주소가 어떻게 될 때
	//바로 아래에 있는 메서드가 호출이 될지를 써주어야 한다. 
	@RequestMapping("mypage/replyInsert")
	public void insert(ReplyVO bag) {
		//메서드의 입력변수(파라메터)로 변수를 선언해두면, 컨트롤러내의 메서드내에서는
		//1)bag을 만들어서 
		//2)클라이언트로 부터 전달된 데이터도 받아줌.
		//3)bag에 데이터 다 넣어줌.
		System.out.println("insert요청됨.");
		System.out.println(bag);
		
		// 현재 시간을 설정하여 VO에 넣어줌
		Date currentDate = new Date(0);
		Timestamp timestamp = new Timestamp(currentDate.getTime());
		bag.setUpload_date(timestamp);
		
		dao.insert(bag);
	}
	
	@RequestMapping("mypage/replyUpdate")
	public void update(ReplyVO bag) {
		System.out.println("update요청됨.");
		System.out.println(bag);	
		dao.update(bag);
	}
	
	@RequestMapping("mypage/replyDelete")
	public void delete(int r_number) {
		System.out.println("delete요청됨.");
		System.out.println(r_number);
		System.out.println(dao);
		dao.delete(r_number);
	}
	
	@RequestMapping("mypage/one2")
	public void one(String email, Model model) {
		System.out.println("one요청됨.");
		System.out.println(email);
		ReplyVO bag = dao.one(email);
		model.addAttribute("bag", bag);
	}
	
	//페이징 하기 전 list 불러오는 코드
//	@RequestMapping("mypage/replyList")
//	public void replyList(Model model) {
//		System.out.println("replyList 요청됨");
//	    String email = (String) session.getAttribute("email");
//	    List<ReplyVO> list = dao.listByEmail(email);
//	    System.out.println(list.size());
//	    //views아래 list를 전달 
//	    model.addAttribute("list", list);
//	    //그 다음에 무조건 views/mypage/replyList로 감.
//	    //다른 곳으로 가고 싶을 때에는 return 사용!
//	}
	
	// 후기내역 페이징
	@RequestMapping("mypage/replyList")
	public void replyList(MypagePageVO vo, Model model) {
	    vo.mypageStartEnd(vo.getPage());
	    String email = (String) session.getAttribute("email");
	    
	    int count = dao.count();
	    int pages = count / 10 + 1;
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("email", email);
	    map.put("start", vo.getStart());
	    map.put("end", vo.getEnd());
	    
	    List<ReplyVO> list = dao.listPaging(map);

	    model.addAttribute("list", list);
	    model.addAttribute("count", count);
	    model.addAttribute("pages", pages);
	}
	
	// 페이징 - 두번째 페이지 이상일 경우 사용
	@RequestMapping("mypage/replyList2")
	public void replyList2(MypagePageVO vo, Model model) {
	    vo.mypageStartEnd(vo.getPage());
	    String email = (String) session.getAttribute("email");
	   
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("email", email);
	    map.put("start", vo.getStart());
	    map.put("end", vo.getEnd());
	    List<ReplyVO> list = dao.listPaging(map);

	    // list만 가져와서 보여주는거라 count,pages 필요X
	    model.addAttribute("list", list);
	}
	
}
