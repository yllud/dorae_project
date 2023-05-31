//PreferenceController.java
package com.multi.dorae.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PreferenceController {
	
	@Autowired
	PreferenceService service;
	
	@RequestMapping("insert_preference")
	@ResponseBody
	public String insert(PreferenceVO bag) {
		System.out.println("insert_preference요청됨.");
		
		int result = service.insert(bag);
		if (result > 0) {
	        return "success";
	    } else {
	        return "failure";
	    }
	}
	
	@RequestMapping("select_myPreference")
	@ResponseBody
	public List<PreferenceVO> myprefer(String email) {
		//System.out.println("mybook요청됨.");
		
		List<PreferenceVO> list = service.mypreference(email);
		return list;
	}	
}
