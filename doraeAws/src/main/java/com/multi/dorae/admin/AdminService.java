package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	AdminDAO adminDAO;
	
	public boolean join(AdminVO adminVO) {
		// 비밀번호 암호화
		if (adminDAO.isExist(adminVO.getId())) {
			System.out.println("아이디가 중복됨");
			return false;
		}
		adminVO.setPassword(passwordEncoder.encode(adminVO.getPassword()));
		
		if (adminDAO.one(adminVO.getId()) != null) {
			return false;
		}
		
		if (adminDAO.insert(adminVO) == 1) {
			return true;
		}
		return false;
	}
	
	public boolean login(AdminVO adminVO) {
		AdminVO entity = adminDAO.one(adminVO.getId()); // db에 저장되어있는 계정 정보
		
		if (entity == null) {
			return false;
		}
		
		// db에 있는 비밀번호와 입력 받은 비밀번호가 다를 경우
		if (!passwordEncoder.matches(adminVO.getPassword(), entity.getPassword())) {
			return false;
		}
		
		return true;
	}
}
