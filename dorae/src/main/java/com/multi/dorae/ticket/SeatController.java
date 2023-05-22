package com.multi.dorae.ticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.multi.dorae.search.PlayDAO;
import com.multi.dorae.search.PlayVO;

@Controller
public class SeatController {

	@Autowired
	SeatDAO dao;
	
	//예매페이지(달력)
	@RequestMapping("seat/one")
	public void one(String play_id, Model model) {
		System.out.println(play_id + "seat one 요청성공");
		PlayVO vo = dao.one(play_id);
		model.addAttribute("vo", vo);
	}
	//좌석페이지
	@RequestMapping("seat/seats")
	public void one2(String play_id, Model model) {
		System.out.println(play_id + "seat one2 요청성공");
		PlayVO vo = dao.one2(play_id);
		model.addAttribute("vo", vo);
	}
	//선택해서 결제로 넘어간 좌석
	@RequestMapping("seat/insert")
	public void insert(SeatVO bag, Model model) {
		System.out.println("seat insert 요청성공");
		dao.insert(bag);
		model.addAttribute("bag", bag);
	}
}
