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
public class ReplyController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	ReplyDAO dao;
	//컨트롤 하는 기능(CRUD)
	//회원가입, 수정, 탈퇴, 정보검색
	
	//클래스 내에서 기능처리 담당
	//멤버변수 + 멤버메서드(기능처리 담당)
	//하나의 요청당 하나의 메서드
	//하나의 버튼호출당 하나의 함수 연결!
	//요청된 주소가 어떻게 될 때
	//바로 아래에 있는 메서드가 호출이 될지를 써주어야 한다. 
	@RequestMapping("mypage/insert2")
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
	
	@RequestMapping("mypage/update2")
	public void update(ReplyVO bag) {
		System.out.println("update요청됨.");
		System.out.println(bag);	
		dao.update(bag);
	}
	
	@RequestMapping("mypage/delete2")
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
	
	@RequestMapping("mypage/replyList")
	public void replyList(Model model) {
		System.out.println("replyList 요청됨");
	    String email = (String) session.getAttribute("email");
	    List<ReplyVO> list = dao.listByEmail(email);
	    System.out.println(list.size());
	    //views아래 list를 전달 
	    model.addAttribute("list", list);
	    //그 다음에 무조건 views/mypage/replyList로 감.
	    //다른 곳으로 가고 싶을 때에는 return 사용!
	}
	
//	@RequestMapping("mypage/replyList")
//	@ResponseBody
//	public List<ReplyVO> replyList() {
//		System.out.println("replyList 요청됨");
//		String email = (String) session.getAttribute("email");
//		List<ReplyVO> list = dao.listByEmail(email);
//		return list;
//	}
	
}
