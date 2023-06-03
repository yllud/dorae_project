package com.multi.dorae.ticket;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TransactionService {

	@Autowired
	SeatDAO dao;
	
	@Autowired
	PayDAO dao2;
	
	@Transactional
	public int tran(SeatVO seatvo, PayVO payvo) throws Exception {
		int result = 1;
        dao.insert(seatvo);
        if(dao2.insert(payvo) == 0){
           result = 0;
         }
        return result;
		}
}
	

