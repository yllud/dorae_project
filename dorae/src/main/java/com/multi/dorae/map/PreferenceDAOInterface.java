//PreferenceDAOInterface.java
package com.multi.dorae.map;

import java.util.List;

import com.multi.dorae.search.PlayVO;

public interface PreferenceDAOInterface {
	
	int insert(PreferenceVO bag);
	
	PreferenceVO mypreference(String email);
	
	List<PlayVO> getRecommendedPlays(PreferenceVO bag);
}
