//PreferenceDAO.java
package com.multi.dorae.map;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.multi.dorae.search.PlayVO;

@Repository
public class PreferenceDAO implements PreferenceDAOInterface{
	@Autowired
	SqlSessionTemplate my;
	
	@Override
	public int insert(PreferenceVO bag) {
		int result = my.insert("preference.create", bag);
		return result;
	}
	
	@Override
	public List<PreferenceVO> mypreference(String email) {
		List<PreferenceVO> list = my.selectList("preference.my", email);
		return list;
	}

	@Override
	public List<PlayVO> getRecommendedPlays(PreferenceVO bag) {
		List<PlayVO> list = my.selectList("preference.type", bag);
		return list;
	}
}
