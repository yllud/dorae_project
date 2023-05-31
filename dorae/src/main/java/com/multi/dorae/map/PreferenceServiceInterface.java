//PreferenceServiceInterface.java
package com.multi.dorae.map;

import java.util.List;

import com.multi.dorae.search.PlayVO;

public interface PreferenceServiceInterface {
	
	int insert(PreferenceVO bag);

	List<PreferenceVO> mypreference(String email);
	
	List<PlayVO> getRecommendedPlays(PreferenceVO bag);
}
