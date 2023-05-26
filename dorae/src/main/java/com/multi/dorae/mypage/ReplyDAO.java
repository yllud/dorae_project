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
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

//테이블 하나당 DAO하나! ==> CUD를 완성!! 
@Component
public class ReplyDAO {
	
	@Autowired
	SqlSessionTemplate my;

	public ReplyVO one(String email) {
		System.out.println("-----" + my);
		ReplyVO bag = my.selectOne("reply.one", email);
		return bag;
	}

	public int delete(int r_number) {
		System.out.println("------" + my);
		int result = my.delete("reply.delete", r_number);
		return result;
	}

	public int update(ReplyVO bag) {
		System.out.println("------" + my);
		int result = my.update("reply.update", bag);
		return result;
	}
	
	public int insert(ReplyVO bag) {
		System.out.println("----" + my);
		
		// 대한민국 시간대로 설정
	    ZoneId zoneId = ZoneId.of("Asia/Seoul");

	    // 대한민국 시간대로 현재 날짜와 시간 가져오기
	    ZonedDateTime currentDateTime = ZonedDateTime.now(zoneId);

	    // upload_date 필드에 현재 날짜와 시간 설정
	    bag.setUpload_date(Timestamp.valueOf(currentDateTime.toLocalDateTime()));

	    int result = my.insert("reply.create", bag);
	    return result;
	}
	
	// 로그인 한 email에 해당하는 후기의 전체 list
	 public List<ReplyVO> listByEmail(String email) {
		 List<ReplyVO> list = my.selectList("reply.listByEmail", email);
		    return list;
		}
	
	 // 페이징 처리
	 public List<ReplyVO> listPaging(Map<String, Object> map) {
		    return my.selectList("reply.listPaging", map);
		}
	 // 페이징에 필요한 카운트 수
	 public int count() {
		 return my.selectOne("reply.count");
	 }
}