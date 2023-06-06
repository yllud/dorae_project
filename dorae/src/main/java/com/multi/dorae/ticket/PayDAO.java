package com.multi.dorae.ticket;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class PayDAO {

	@Autowired
	SqlSessionTemplate my;
	
	// 결제 시 결제 정보 저장
	public int insert(PayVO payvo) throws Exception{
		int result = 0;
		result = my.insert("pay.insert", payvo);
		return result;
	}	
	
//	// 결제취소 시 결제 정보 select
//	public PayVO one(String seat_id) {
//		PayVO pay = my.selectOne("pay.select", seat_id);
//		System.out.println(pay);
//		return pay;
//	}
	
	// 결제취소 시 결제 정보 update
	public int update(PayVO bag) {
		int result = my.update("pay.update", bag);
		System.out.println(result);
		return result;
	}
	

}
