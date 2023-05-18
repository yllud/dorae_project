package com.multi.dorae.ticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.multi.dorae.search.PlayVO;

@Controller
public class SeatController {

	@Autowired
	SeatDAO dao;
	
	
	//예매페이지(달력)
	@RequestMapping("seat/one")
	public void one(String play_id, Model model) {
		System.out.println(play_id);
		PlayVO vo = dao.one(play_id);
		model.addAttribute("vo", vo);
	}
	
	@RequestMapping("seat/seats")
	public void one2(String play_id, Model model) {
		System.out.println(play_id);
		PlayVO vo = dao.one2(play_id);
		model.addAttribute("vo", vo);
	}
	
}
