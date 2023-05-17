package com.multi.dorae.login;

import java.sql.Timestamp;

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
			Timestamp joinDate = new Timestamp(System.currentTimeMillis());
	        bag.setJoinDate(joinDate);
			
			result = mn.insert("naverMember.naverInsert", bag);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	
	public int login(NaverVO bag) {
		int result = 0;
		try {
			result = mn.selectOne("naverMember.naverFind", bag);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
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
	
}
