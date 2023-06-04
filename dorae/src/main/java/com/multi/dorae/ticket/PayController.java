package com.multi.dorae.ticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PayController {

	@Autowired
	PayDAO dao;
	
//	// 결제 성공
//	@RequestMapping("pay/insert")
//	public void insert(PayVO payvo) {
//		System.out.println("pay insert 요청성공");
//		dao.insert(payvo);
//	}
	
	// 예매취소시 cancle 컬럼에 Y추가
	@RequestMapping("pay/update")
	public void update(PayVO bag) {
		System.out.println("pay update 요청성공");
		System.out.println(bag);
		dao.update(bag);
	}
	
}
