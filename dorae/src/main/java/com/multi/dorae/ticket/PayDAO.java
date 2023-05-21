package com.multi.dorae.ticket;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class PayDAO {

	@Autowired
	SqlSessionTemplate my;
	
	// 결제 시 결제 정보 저장
	public int insert(PayVO bag) {
		int result = my.insert("pay.insert", bag);
		return result;
	}
}
