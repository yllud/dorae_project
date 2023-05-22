package com.multi.dorae.ticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PayController {

	@Autowired
	PayDAO dao;
	
	// 결제 성공
	@RequestMapping("pay/insert")
	public void insert(PayVO bag) {
		System.out.println("pay insert 요청성공");
		dao.insert(bag);
		
	}
	
	
	
}
