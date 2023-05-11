package com.multi.dorae.ticket;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PayDAO {

	@Autowired
	SqlSessionTemplate my;
	
	
}
