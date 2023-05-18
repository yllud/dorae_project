package com.multi.dorae.login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class KakaoDAO {

	// mapper를 호출하기 위한 클래스 주입.
	@Autowired
	private SqlSessionTemplate sql;
	
	// 정보 저장
	public int insert(KakaoVO vo) {
		
		System.out.println(vo);
		System.out.println(vo);
        int result = 0;
        try {
            // 가입 날짜 설정
            vo.setJoinDate(new Timestamp(System.currentTimeMillis()));

            result = sql.insert("kakaoMember.kakaoInsert", vo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(result);
        return result;
		
		//(아래코드)챗지피티한테 물어보기 전 원본
//		System.out.println(vo);
//		int result = 0;
//		try {
//			result = sql.insert("kakaoMember.kakaoInsert", vo);
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//		System.out.println(result);
//		return result;
		
	}
//	public void kakaoinsert(HashMap<String, Object> userInfo) {
//		sql.insert("kakaoMember.kakaoInsert",userInfo);
//	}


	// 정보 확인
	public KakaoVO findkakao(HashMap<String, Object> userInfo) {
		System.out.println("RN:"+userInfo.get("nickname"));
		System.out.println("RE:"+userInfo.get("email"));
		return sql.selectOne("kakaoMember.kakaoFind", userInfo);
	}


	public int delete(String email) {
		int result = sql.delete(email);
		return result;
	}
	
	
//	//새로 로그인 짠거
//	public int login(KakaoVO bag) {
//		int result = 0;
//		try {
//			result = sql.selectOne("kakaoMember.kakaoFind", bag);
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//		return result;
//	}
//	
//	public void delete(String email) {
//		int result = sql.delete("kakaoMember.kakaoDelete", email);
//		System.out.println(result);
//	}
	

}

