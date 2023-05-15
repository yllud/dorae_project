package com.multi.dorae.search;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PlayDAO {

	// mybatis 싱글톤 객체 찾아서 주소 넣어줌
	@Autowired
	SqlSessionTemplate my;

	//공연 추가
	public int insert(PlayVO bag) {
		int result = my.insert("play.create", bag);
		return result;
	}

	//모든 공연의 play id 불러오기 (api)
	public List<String> listPlayId() {
		List<String> list = my.selectList("play.playIdList");
		return list;
	}

	//모든 공연의 stageid 불러오기 (api)
	public List<String> listStageId() {
		List<String> list = my.selectList("play.stageIdList");
		return list;
	}

	//공연 페이지 리스트로 불러오기
	public List<PlayVO> list(Criteria cri) {
		System.out.println("list dao입니다");
		System.out.println(cri.getStart());
		System.out.println(cri.getTitle());
		List<PlayVO> list = my.selectList("play.page",cri);
		for (PlayVO bag : list) {
			System.out.println(bag.getPlay_name());
		}
		return list;
	}
	
	//페이지 불러올 때 전체 리시트 숫자 불러오기
	public int count(Criteria cri) {
		return my.selectOne("play.count",cri);
	} 
	
	


	// 공연 id로 공연 한개 검색
	public PlayVO playDetail(String play_id) {
		System.out.println("playDetail dao...");
		System.out.println(play_id);
		PlayVO vo = my.selectOne("play.one", play_id);

		return vo;
	}

	// 공연 id로 공연장 id 검색
	public String stageId(String play_id) {
		System.out.println("공연 id로 공연장 Id 검색중..");
		System.out.println(play_id);
		String stage_id = my.selectOne("play.searchStageId", play_id);
		
		return stage_id;
	}

}
