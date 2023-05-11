package com.multi.dorae.login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
		int result = 0;
		try {
			result = sql.insert("kakaoMember.kakaoInsert", vo);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println(result);
		return result;
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
	
	public void delete(String email) {
		int result = sql.delete("kakaoMember.kakaoDelete", email);
		System.out.println(result);
	}

//	public int login(KakaoVO bag) {
//		int result = 0; // 항목명이랑 결과를 담고 있는 테이블이다.
//		try {
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			System.out.println("1. mySQL과 자바 연결할 부품 설정 성공.");
//			
//			String url = "jdbc:mysql://localhost:3306/multi?serverTimezone=UTC";
//			String user = "root";
//			String password = "1234";
//			Connection con = DriverManager.getConnection(url, user, password); // Connection
//			System.out.println("2. mysql 연결 성공.");
//			
//			String sql = "select * from member where email=?";
//			PreparedStatement ps = con.prepareStatement(sql);
//			ps.setString(1, bag.getEmail());
//			System.out.println("3. SQL문 부품(객체)으로 만들어주기.");
//			
//			ResultSet rs = ps.executeQuery();
//			System.out.println("4. SQL문 오라클로 보내기 성공.");
//			
//			if (rs.next()) { // 검색결과가 있으면 TRUE 없으면 false
//				System.out.println("검색결과 있음 성공!");
//				result = 1;
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return result;
//	}
	

}

