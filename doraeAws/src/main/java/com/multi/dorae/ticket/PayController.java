package com.multi.dorae.ticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PayController {

	@Autowired
	PayDAO dao;
	

	
//	// 예매취소시 select
//	@RequestMapping("pay/select")
//	public void one(String seat_id, Model model) {
//		System.out.println(seat_id + " " + "pay select 요청성공");
//		PayVO pay = dao.one(seat_id);
//		model.addAttribute("vo", pay);
//	}
	
	// 예매취소시 cancle 컬럼에 Y추가
	@RequestMapping("pay/update")
	public void update(PayVO bag) {
		System.out.println("pay update 요청성공");
		System.out.println(bag);
		dao.update(bag);
	}
	
}
