package com.multi.dorae.ticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TransactionController {

	@Autowired
	TransactionService service;

	@RequestMapping("seat/insert")
	public void transaction(SeatVO seatvo, PayVO payvo)  {
		int result = 0;
		try {
			result = service.tran(seatvo, payvo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("결과 받은값>> " + result);
	}
}
