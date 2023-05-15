package com.multi.dorae.login;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class KakaoVO {

	private long m_number;
	private String nickname;
	private String email;
	private Timestamp joinDate; // 가입 날짜
	
	public long getM_number() {
		return m_number;
	}
	public void setM_number(long m_number) {
		this.m_number = m_number;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Timestamp joinDate) {
		this.joinDate = joinDate;
	}
	
	@Override
	public String toString() {
		return "KakaoVO [m_number=" + m_number + ", nickname=" + nickname + ", email=" + email + ", joinDate="
				+ joinDate + "]";
	} 

	}

