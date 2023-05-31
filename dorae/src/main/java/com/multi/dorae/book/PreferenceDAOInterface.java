//PreferenceDAOInterface.java
package com.multi.dorae.book;

import java.util.List;

public interface PreferenceDAOInterface {
	
	int insert(PreferenceVO bag);
	
	List<PreferenceVO> mypreference(String email);
}
