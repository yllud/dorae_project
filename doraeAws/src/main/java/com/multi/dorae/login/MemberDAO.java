package com.multi.dorae.login;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO { // CRUD

	@Autowired
	SqlSessionTemplate my;
	
	public int create(MemberVO bag) {
	    int result = 0;
	    try {
	        // 중복 이메일 체크
	        MemberVO existingMember = my.selectOne("member.find", bag);
	        if (existingMember != null) {
	            // 이미 존재하는 이메일인 경우
	            result = -1; // 중복된 이메일임을 나타내는 값 (-1을 사용)
	        } else {
	            if (bag.getJoinDate() == null) {
	                Date joinDate = new Date(System.currentTimeMillis());
	                bag.setJoinDate(joinDate);
	            }
	            result = my.insert("member.create", bag);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	public int checkEmail(String email) {
		int result = my.selectOne("member.checkEmail", email);
		return result;
	}
	
	
	public MemberVO login(MemberVO bag) {
		MemberVO vo = null; 
		try {
			vo = my.selectOne("member.find", bag);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return vo;
	}

	public int delete(String email) {
		int result = my.delete("member.delete", email); // int반환값!
		return result;
	}

	public int update(MemberVO bag) {
	    int result = 0;
	    try {
	        result = my.update("member.update", bag);
	        if (result == 1) {
	            System.out.println("회원정보 수정 성공.");
	        } else {
	            System.out.println("회원정보 수정 실패.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	public int updateVisitCount(String email) {
	    int result = 0;
	    try {
	        result = my.update("member.updateVisitCount", email);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}

}
