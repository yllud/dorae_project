//PreferenceController.java
package com.multi.dorae.map;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.search.PlayVO;

@RequestMapping("map")
@Controller
public class PreferenceController {
	
	@Autowired
	PreferenceService service;
	
	@RequestMapping("insert_preference")
	@ResponseBody
	public String insert(PreferenceVO bag) {
		System.out.println("insert_preference");
		
		int result = service.insert(bag);
		if (result > 0) {
	        return "success";
	    } else {
	        return "failure";
	    }
	}
	
	@RequestMapping("select_myPreference")
	@ResponseBody
	public PreferenceVO mypreference(String email) {
		PreferenceVO list = service.mypreference(email);
		return list;
	}	
	
	@RequestMapping("select_recommendPlay")
	public String getRecommendedPlays(@RequestParam("email") String email, Model model) {
		PreferenceVO bag = service.mypreference(email); //filterdList 값 받음
        List<PlayVO> recommendedPlays = service.getRecommendedPlays(bag);
        
        model.addAttribute("bag", bag);
        model.addAttribute("list", recommendedPlays);
        
        return "map/recommendPlays";
    }
}