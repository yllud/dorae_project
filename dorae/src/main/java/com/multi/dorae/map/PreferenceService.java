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
        int count = 0;
        
        for(PlayVO vo : recommendedPlays) {
        	recommendedStages.add(dao2.stageDetail(vo.getStage_id()));
        }
        // 필요한 추가 로직을 수행하거나 필터링을 적용
        List<PlayVO> filteredPlays = new ArrayList<>();
        
        // Filter by first priority (genre1 and area1 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);
            if (bag.getGenre1() != null && play.getGenre_name().equals(bag.getGenre1()) && bag.getArea1() != null && stage.getAddress().startsWith(bag.getArea1())) {
                filteredPlays.add(play);
                count++;
                if (count >= 10) {
                    break;
                }
            }
        }
        count = 0;
        // Filter by second priority (genre2 and area1 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);
            if (bag.getGenre2() != null && play.getGenre_name().equals(bag.getGenre2()) && bag.getArea1() != null && stage.getAddress().startsWith(bag.getArea1())) {
                filteredPlays.add(play);
                count++;
                if (count >= 8) {
                    break;
                }
            }
        }
        count = 0;
        // Filter by third priority (genre1 and area2 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);
            if (bag.getGenre1() != null && play.getGenre_name().equals(bag.getGenre1()) && bag.getArea2() != null && stage.getAddress().startsWith(bag.getArea2())) {
                filteredPlays.add(play);
                count++;
                if (count >= 6) {
                    break;
                }
            }
        }
        count = 0;
        // Filter by third priority (genre3 and area1 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
        	PlayVO play = recommendedPlays.get(i);
        	StageVO stage = recommendedStages.get(i);
        	 if (bag.getGenre3() != null && play.getGenre_name().equals(bag.getGenre3()) && bag.getArea1() != null && stage.getAddress().startsWith(bag.getArea1())) {
        		filteredPlays.add(play);
        		count++;
        		if (count >= 5) {
        			break;
        		}
        	}
        }
        count = 0;
        // Filter by fourth priority (genre2 and area2 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);
            if (bag.getGenre2() != null && play.getGenre_name().equals(bag.getGenre2()) && bag.getArea2() != null && stage.getAddress().startsWith(bag.getArea2())) {
                filteredPlays.add(play);
                count++;
                if (count >= 4) {
                    break;
                }
            }
        }
        count = 0;
        // Filter by remaining plays (genre3 and area2 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            StageVO stage = recommendedStages.get(i);
            if (bag.getGenre3() != null && play.getGenre_name().equals(bag.getGenre3()) && bag.getArea2() != null && stage.getAddress().startsWith(bag.getArea2())) {
                filteredPlays.add(play);
                count++;
                if (count >= 3) {
                    break;
                }
            }
        }
        count = 0;
        // Filter by fourth priority (genre1 and area3 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
        	PlayVO play = recommendedPlays.get(i);
        	StageVO stage = recommendedStages.get(i);
        	 if (bag.getGenre1() != null && play.getGenre_name().equals(bag.getGenre1()) && bag.getArea3() != null && stage.getAddress().startsWith(bag.getArea3())) {
        		filteredPlays.add(play);
        		count++;
        		if (count >=2) {
        			break;
        		}
        	}
        }
        count = 0;
        // Filter by remaining plays (genre2 and area3 matching)
        for (int i = 0; i < recommendedPlays.size(); i++) {
        	PlayVO play = recommendedPlays.get(i);
        	StageVO stage = recommendedStages.get(i);
        	 if (bag.getGenre2() != null && play.getGenre_name().equals(bag.getGenre2()) && bag.getArea3() != null && stage.getAddress().startsWith(bag.getArea3())) {
        		filteredPlays.add(play);
        		count++;
        		if (count >= 2) {
        			break;
        		}
        	}
        }

        // Add remaining plays without specific filters
        for (int i = 0; i < recommendedPlays.size(); i++) {
            PlayVO play = recommendedPlays.get(i);
            if (!filteredPlays.contains(play)) {
                filteredPlays.add(play);
                count++;
                if (count >= 2) {
                    break;
                }
            }
        }

        return filteredPlays;
    }
}