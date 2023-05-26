package com.multi.dorae.mypage;

import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TicketDAO {
	
	@Autowired
	SqlSessionTemplate my;

	// seat, pay, play 테이블을 join한 것 전부 불러오는 list
	// 해당하는 email을 전부 불러옴
	 public List<TicketVO> listByEmail(String email) {
		 List<TicketVO> list = my.selectList("mypageList.ticketJoin", email);
		    return list;
		}
	
}