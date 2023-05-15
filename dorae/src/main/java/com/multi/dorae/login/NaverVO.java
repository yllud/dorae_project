package com.multi.dorae.login;

import java.sql.Date;
import java.sql.Timestamp;

public class NaverVO {
	private long m_number;
	private String id;
	private String nickname;
	private String name;
	private String email;
	private String gender;
	private String age;
	private String birthday;
	private String profile_image;
	private Timestamp joinDate;
	
	public long getM_number() {
		return m_number;
	}
	public void setM_number(long m_number) {
		this.m_number = m_number;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public Timestamp getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Timestamp joinDate) {
		this.joinDate = joinDate;
	}
	
	@Override
	public String toString() {
		return "NaverVO [m_number=" + m_number + ", id=" + id + ", nickname=" + nickname + ", name=" + name + ", email="
				+ email + ", gender=" + gender + ", age=" + age + ", birthday=" + birthday + ", profile_image="
				+ profile_image + ", joinDate=" + joinDate + "]";
	}
	
}
