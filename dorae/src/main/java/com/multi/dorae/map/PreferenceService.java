//PreferenceService.java
package com.multi.dorae.map;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.dorae.search.PlayVO;

@Service
public class PreferenceService implements PreferenceServiceInterface{
	
	@Autowired
	PreferenceDAOInterface dao;
	
	@Override
	public int insert(PreferenceVO bag) {
		int result = dao.insert(bag);
		return result;
	}
	
	@Override
	public PreferenceVO mypreference(String email) {
		PreferenceVO vo = dao.mypreference(email);
		return vo;
	}
	
	@Override
	public List<PlayVO> getRecommendedPlays(PreferenceVO bag) {
        List<PlayVO> recommendedPlays = dao.getRecommendedPlays(bag);
        // 필요한 추가 로직을 수행하거나 필터링을 적용할 수 있습니다.
        return recommendedPlays;
    }
}
