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

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//테이블 하나당 DAO하나! ==> CUD를 완성!! 
@Component
public class TicketDAO {
	
	@Autowired
	SqlSessionTemplate my;


	 public List<TicketVO> listByEmail(String email) {
		 List<TicketVO> list = my.selectList("mypageList.ticketJoin", email);
		    return list;
		}
	
}