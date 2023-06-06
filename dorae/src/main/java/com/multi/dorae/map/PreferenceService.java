//PreferenceService.java
package com.multi.dorae.map;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.dorae.search.PlayVO;
import com.multi.dorae.search.StageDAO;
import com.multi.dorae.search.StageVO;

@Service
public class PreferenceService implements PreferenceServiceInterface{
	
	@Autowired
	PreferenceDAOInterface dao;
	
	@Autowired
	StageDAO dao2;
	
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
        List<StageVO> recommendedStages = new ArrayList<>();
        int[] count = {0, 0, 0, 0, 0, 0, 0, 0, 0};
        int cnt_arr[] = {10, 9, 8, 7, 6, 5, 4, 3, 2}; //각 순위 별 출력될 count 배열
        
        for(PlayVO vo : recommendedPlays) {
        	recommendedStages.add(dao2.stageDetail(vo.getStage_id()));
        }
        // 필요한 추가 로직을 수행하거나 필터링을 적용
        List<PlayVO> filteredPlays = new ArrayList<>();
        
        // Filter by first priority (genre1 and area1 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);
            if (bag.getGenre1() != null && play.getGenre_name().equals(bag.getGenre1()) && bag.getArea1() != null && stage.getAddress().startsWith(bag.getArea1()) && count[0] < cnt_arr[0]) {
                filteredPlays.add(play);
                count[0]++;
            }else if (bag.getGenre2() != null && play.getGenre_name().equals(bag.getGenre2()) && bag.getArea1() != null && stage.getAddress().startsWith(bag.getArea1()) && count[1] < cnt_arr[1]) {
                filteredPlays.add(play);
                count[1]++;
            }else if (bag.getGenre1() != null && play.getGenre_name().equals(bag.getGenre1()) && bag.getArea2() != null && stage.getAddress().startsWith(bag.getArea2()) && count[2] < cnt_arr[2]) {
                filteredPlays.add(play);
                count[2]++;
            }else if (bag.getGenre3() != null && play.getGenre_name().equals(bag.getGenre3()) && bag.getArea1() != null && stage.getAddress().startsWith(bag.getArea1()) && count[3] < cnt_arr[3]) {
        		filteredPlays.add(play);
        		count[3]++;
        	}else if (bag.getGenre2() != null && play.getGenre_name().equals(bag.getGenre2()) && bag.getArea2() != null && stage.getAddress().startsWith(bag.getArea2()) && count[4] < cnt_arr[4]) {
                filteredPlays.add(play);
                count[4]++;
            }else if (bag.getGenre3() != null && play.getGenre_name().equals(bag.getGenre3()) && bag.getArea2() != null && stage.getAddress().startsWith(bag.getArea2()) && count[5] < cnt_arr[5]) {
                filteredPlays.add(play);
                count[5]++;
            }else if (bag.getGenre1() != null && play.getGenre_name().equals(bag.getGenre1()) && bag.getArea3() != null && stage.getAddress().startsWith(bag.getArea3()) && count[6] < cnt_arr[6]) {
        		filteredPlays.add(play);
        		count[6]++;
        	}else if (bag.getGenre2() != null && play.getGenre_name().equals(bag.getGenre2()) && bag.getArea3() != null && stage.getAddress().startsWith(bag.getArea3()) && count[7] < cnt_arr[7]) {
        		filteredPlays.add(play);
        		count[7]++;
        	}else if (!filteredPlays.contains(play) && count[8] >= cnt_arr[8]) {
                filteredPlays.add(play);
                count[8]++;
            }
        }

        return filteredPlays;
    }
}