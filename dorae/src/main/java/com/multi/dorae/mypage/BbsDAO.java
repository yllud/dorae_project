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
import java.util.Locale;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//테이블 하나당 DAO하나! ==> CUD를 완성!! 
@Component
public class BbsDAO {
	
	@Autowired
	SqlSessionTemplate my;

	public BbsVO one(int email) {
		System.out.println("-----" + my);
		BbsVO bag = my.selectOne("bbs.one", email);
		return bag;

	}

	public int delete(int r_number) {
		System.out.println("------" + my);
		int result = my.delete("bbs.delete", r_number);
		return result;
	}

	public int update(BbsVO bag) {
		System.out.println("------" + my);
		int result = my.update("bbs.update", bag);
		return result;
	}

//	// public void add2() {
//	public int insert(BbsVO bag) {
//		System.out.println("----" + my);
//		int result = my.insert("bbs.create", bag);
//		return result;
//	}
	
	public int insert(BbsVO bag) {
		System.out.println("----" + my);
		
		// 대한민국 시간대로 설정
	    ZoneId zoneId = ZoneId.of("Asia/Seoul");

	    // 대한민국 시간대로 현재 날짜와 시간 가져오기
	    ZonedDateTime currentDateTime = ZonedDateTime.now(zoneId);

	    // upload_date 필드에 현재 날짜와 시간 설정
	    bag.setUpload_date(Timestamp.valueOf(currentDateTime.toLocalDateTime()));

	    int result = my.insert("bbs.create", bag);
	    return result;
	}
	
	
}