package com.multi.dorae.search;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.multi.dorae.mypage.ReplyVO;

@Component
public class PlayDAO {

	// mybatis 싱글톤 객체 찾아서 주소 넣어줌
	@Autowired
	SqlSessionTemplate my;

	// 공연 추가
	public int insert(PlayVO bag) {
		int result = my.insert("play.create", bag);
		return result;
	}

	// 모든 공연의 play id 불러오기 (api)
	public List<String> listPlayId() {
		System.out.println("listPlayI");
		List<String> list = my.selectList("play.playIdList");
		return list;
	}

	// 공연중, 공연완료인 공연 id, 날짜, 시작날짜, 종료날짜 검색 (api)
	public List<PlayVO> listPlayDate() {
		List<PlayVO> list = my.selectList("listPlayDate");
		return list;
	}

	// 공연중, 공연완료인 공연 id, 날짜, 시작날짜, 종료날짜 검색 (api)
	public int updateState(PlayVO vo) {
		int result=my.update("play.updateState", vo);
		return result;
	}

	// 모든 공연의 stageid 불러오기 (api)
	public List<String> listStageId() {
		System.out.println("stage id 를 불러오자");
		List<String> list = my.selectList("play.stageIdList");
		for (String id : list) {
			System.out.println(id);
		}
		return list;
	}

	// 공연 페이지 리스트로 불러오기
	public List<PlayVO> list(Criteria cri) {
		System.out.println("(DAO) List");
		List<PlayVO> list = my.selectList("play.page", cri);
//		for (PlayVO bag : list) {
//			System.out.println(bag.getPlay_name());
//		}
		return list;
	}

	// 리시트 개수
	public int count(Criteria cri) {
		System.out.println("(DAO) count");
		int cnt = my.selectOne("play.count", cri);
		return cnt;
	}

	// 공연 id로 공연 한개 검색
	public PlayVO playDetail(String play_id) {
		System.out.println("(Dao) playDetail");
		System.out.println(play_id);
		PlayVO vo = my.selectOne("play.one", play_id);
		return vo;
	}

	// 공연 id로 리뷰 검색
	public List<ReplyVO> ReviewList(String play_id) {
		System.out.println("(DAO) reveiw List");
		List<ReplyVO> list = my.selectList("play.review", play_id);
		for (ReplyVO bag : list) {
			System.out.println(bag.getText());
		}
		return list;
	}

	// 공연 수정
	public int updateAll(PlayVO vo) {
		System.out.println("(DAO) updateAll");
		int result = my.update("play.updateAll", vo);
		System.out.println(result);
		return result;
	}

	// 공연 수정
//	public int updateUserType(String email) {
//		System.out.println("(DAO) update user type");
//		int result = my.update("play.updateUserType", email);
//		System.out.println(result);
//		return result;
//	}

	// 공연 삭제
	public int delete(PlayVO vo) {
		System.out.println("(DAO) delete");
		int result = my.update("play.deleteOne", vo);
		System.out.println(result);
		return result;
	}

	// 공연 id로 공연장 id 검색
	public String stageId(String play_id) {
		System.out.println("(DAO) stageId");
		String stage_id = my.selectOne("play.searchStageId", play_id);
		return stage_id;
	}

}
