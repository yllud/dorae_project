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
        
        for(PlayVO vo : recommendedPlays) {
        	recommendedStages.add(dao2.stageDetail(vo.getStage_id()));
        }
        // 필요한 추가 로직을 수행하거나 필터링을 적용할 수 있습니다.
        List<PlayVO> filteredPlays = new ArrayList<>();
        
        // Filter by first priority (genre1 and area1 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);

            if (play.getGenre_name().equals(bag.getGenre1()) && stage.getAddress().startsWith(bag.getArea1())) {
                filteredPlays.add(play);
                if (filteredPlays.size() >= 15) {
                    break;
                }
            }
        }

        // Filter by second priority (genre1 and area2 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);

            if (play.getGenre_name().equals(bag.getGenre1()) && stage.getAddress().startsWith(bag.getArea2())) {
                filteredPlays.add(play);
                if (filteredPlays.size() >= 20) {
                    break;
                }
            }
        }

        // Filter by third priority (genre2 and area1 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);

            if (play.getGenre_name().equals(bag.getGenre2()) && stage.getAddress().startsWith(bag.getArea1())) {
                filteredPlays.add(play);
                if (filteredPlays.size() >= 20) {
                    break;
                }
            }
        }

        // Filter by fourth priority (genre2 and area2 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);

            if (play.getGenre_name().equals(bag.getGenre2()) && stage.getAddress().startsWith(bag.getArea2())) {
                filteredPlays.add(play);
                if (filteredPlays.size() >= 25) {
                    break;
                }
            }
        }

        // Filter by remaining plays (genre3 and area1 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);

            if (play.getGenre_name().equals(bag.getGenre3()) && stage.getAddress().startsWith(bag.getArea1())) {
                filteredPlays.add(play);
                if (filteredPlays.size() >= 30) {
                    break;
                }
            }
        }

        // Add remaining plays without specific filters
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);

            if (!filteredPlays.contains(play)) {
                filteredPlays.add(play);
                if (filteredPlays.size() >= 35) {
                    break;
                }
            }
        }

        return filteredPlays;
    }
}