package com.multi.dorae.ticket;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.login.KakaoVO;
import com.multi.dorae.login.NaverVO;
import com.multi.dorae.search.PlayVO;

@Controller
public class SeatController {

	@Autowired
	SeatDAO dao;
	

	//예매페이지(달력) 불러올 때 
	@RequestMapping("seat/one")
	public void one(String play_id, Model model) {
		System.out.println(play_id + " " + "seat one 요청성공");
		PlayVO vo = dao.one(play_id);
		model.addAttribute("vo", vo);
		
	}
	
	//좌석선택 클릭시
	@RequestMapping("seat/seats")
	public void one2(String play_id, Model model) {
		System.out.println(play_id + " " + "seat one2 요청성공");
		PlayVO vo = dao.one2(play_id);
		model.addAttribute("vo", vo);
	}
	
//	//선택해서 결제로 넘어간 좌석
//	@RequestMapping("seat/insert")
//	public void insert(SeatVO seatvo) {
//		System.out.println("seat insert 요청성공");
//		dao.insert(seatvo);
//	}
	
	// 다음버튼 눌렀을 때 네이버, 카카오 회원정보 가져오기
	@RequestMapping("seat/memberOne")
	public void member(String email, Model model) {
		System.out.println(email +  " " + "seat member 요청성공");
		NaverVO naverMember = dao.naverMember(email);
		model.addAttribute("naverMember", naverMember);
		KakaoVO kakaoMember = dao.kakaoMember(email);
		model.addAttribute("kakaoMember", kakaoMember);
	}

	
	//좌석선택 누르면 같은 날짜=시간에 판매된 좌석 불러오기
	@RequestMapping("seat/sold")
	public void list(String play_id, String seat_date, String seat_time, String cancle, Model model) {
	    Map<String, Object> params = new HashMap<>(); // 3가지 조건들을 map에 넣고
	    params.put("play_id", play_id);
	    params.put("seat_date", seat_date);
	    params.put("seat_time", seat_time);
	    params.put("cancle", cancle);

	    List<String> list = dao.list(params); // map값을 list에 넣어준다
	    model.addAttribute("list", list);
	}
	

	
}
