package com.multi.dorae.login;


import java.sql.Date;

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
//	public int insert(NaverVO bag) {
//		int result = 0;
//		try {
//			Date joinDate = new Date(System.currentTimeMillis());
//			bag.setJoinDate(joinDate);
//			
//			result = mn.insert("naverMember.naverInsert", bag);
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//		return result;
//	}
	
	public NaverVO login(NaverVO bag) {
		NaverVO vo = null; 
		try {
			vo = mn.selectOne("naverMember.naverFind", bag);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return vo;
	}
	
	
//	public int update(NaverVO bag) {
//		int result = 0;
//		try {
//		result = mn.update("naverMember.naverUpdate", bag);
//		System.out.println(result);
//		}  catch (Exception e) {
//			// TODO: handle exception
//		}
//		return result;
//	}
	
	public int insertProfileImage(NaverVO vo) {
        int result = 0;
        try {
            result = mn.update("naverMember.insertProfileImage", vo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
	
	// 공연 수정
		public int updateUserType(String email) {
			System.out.println("(DAO) update user type");
			int result = mn.update("play.updateUserType", email);
			System.out.println(result);
			return result;
		}
	
}
