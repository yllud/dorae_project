//PreferenceServiceInterface.java
package com.multi.dorae.book;

import java.util.List;

public interface PreferenceServiceInterface {
	
	int insert(PreferenceVO bag);

	List<PreferenceVO> mypreference(String email);
}
