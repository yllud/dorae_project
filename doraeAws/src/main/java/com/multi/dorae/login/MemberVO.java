package com.multi.dorae.login;

import java.sql.Date;

public class MemberVO {
	private String nickname;
	private String name;
	private String gender;
	private String email;
	private String password;
	private String age;
	private String birthday;
	private Date joinDate;
	private String user_type;
	private int visit_count;
	
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public int getVisit_count() {
		return visit_count;
	}
	public void setVisit_count(int visit_count) {
		this.visit_count = visit_count;
	}
	@Override
	public String toString() {
		return "MemberVO [nickname=" + nickname + ", name=" + name + ", gender=" + gender + ", email=" + email
				+ ", password=" + password + ", age=" + age + ", birthday=" + birthday + ", joinDate=" + joinDate
				+ ", user_type=" + user_type + ", visit_count=" + visit_count + "]";
	}
	
}
