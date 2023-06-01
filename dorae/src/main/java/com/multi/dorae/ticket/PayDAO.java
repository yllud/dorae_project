package com.multi.dorae.ticket;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;


@Component
public class PayDAO {

	@Autowired
	SqlSessionTemplate my;
	
	// 결제 시 결제 정보 저장
	@Transactional
	public int insert(PayVO payvo) {
		try {
	        int result = my.insert("pay.insert", payvo);
	        System.out.println(result);
	        return result;
	    } catch (Exception e) {
	        // 롤백을 위해 RuntimeException 또는 그와 상속 관계인 예외를 던집니다.
	        throw new RuntimeException(e);
	    }
	}
	
	// 결제취소 시 결제 정보 update
	public int update(PayVO bag) {
		int result = my.update("pay.update", bag);
		System.out.println(result);
		return result;
	}
	
}
