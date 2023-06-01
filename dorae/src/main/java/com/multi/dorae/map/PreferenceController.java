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
		System.out.println("insert_preference요청됨.");
		
		// 이메일이 이미 존재하는지 확인
		
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
		PreferenceVO bag = service.mypreference(email); //사용자의 맞춤설정 bag 가져오기
        List<PlayVO> recommendedPlays = service.getRecommendedPlays(bag);
        
        for (PlayVO playVO : recommendedPlays) {
			System.out.println(playVO);
		}
        // 필요한 추가 로직을 수행하거나 필터링을 적용할 수 있습니다.
        model.addAttribute("bag", bag);
        model.addAttribute("list", recommendedPlays);
        
        return "map/recommendPlays";
    }
}