package com.multi.dorae.login;


import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class NaverDAO {

	@Autowired
	SqlSessionTemplate mn;
	
	public int insert(NaverVO bag) {
	    int result = 0;
	    try {
	        if (bag.getJoinDate() == null) {
	            Date joinDate = new Date(System.currentTimeMillis());
	            bag.setJoinDate(joinDate);
	        }
	        result = mn.insert("naverMember.naverInsert", bag);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	public NaverVO login(NaverVO bag) {
		NaverVO vo = null; 
		try {
			vo = mn.selectOne("naverMember.naverFind", bag);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return vo;
	}
	
	public NaverVO one(String email) {
		NaverVO vo = null; 
		try {
			vo = mn.selectOne("naverMember.one", email);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return vo;
	}
	
	// 프로필사진 update
	public int ProfileUpdate(String email, String uploadImage) {
	    Map<String, String> parameterMap = new HashMap<>();
	    parameterMap.put("email", email);
	    parameterMap.put("upload_image", uploadImage);
	    return mn.update("naverMember.profileUpdate", parameterMap);
	}

	
	// 공연 수정
		public int updateUserType(String email) {
			System.out.println("(DAO) update user type");
			int result = mn.update("naverMember.changeUserType", email);
			System.out.println(result);
			return result;
		}
		
		public int updateVisitCount(String email) {
		    int result = 0;
		    try {
		        result = mn.update("naverMember.updateVisitCount", email);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return result;
		}
}
