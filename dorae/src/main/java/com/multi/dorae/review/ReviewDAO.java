package com.multi.dorae.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.multi.dorae.search.PlayVO;

@Component
public class ReviewDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 후기작성
	public void insert(ReviewVO vo) {
		my.insert("review.insert", vo);
	}
	
	// 후기 전체 목록
	public List<ReviewVO> all(ReviewPageVO vo) {
		return my.selectList("review.all", vo);
	}
	
	// 후기 태그 검색
	public List<ReviewVO> tagSearch(ReviewPageVO vo, String tag) {
		Map<String, Object> params = new HashMap<>();
	    params.put("tag", tag);
	    params.put("start", vo.getStart());
	    params.put("end", vo.getEnd());
	    return my.selectList("review.tagSearch", params);
	}
	
	// 후기 id로 검색
	public ReviewVO one(int id) {
		return my.selectOne("review.one", id);
	}
	
	// 후기 전체 게시글 카운트
	public int count() {
		return my.selectOne("review.count");
	}
	
	// 태그 검색 결과 게시글 카운트
	public int tagCount(String tag) {
		return my.selectOne("review.tagCount", tag);
	}
	
	// 후기 수정
	public void update(ReviewVO vo) {
		my.update("review.update", vo);
	}
	
	// 후기 삭제
	public void delete(int id) {
		my.delete("review.delete", id);
	}
	
	// 사진 수정
	public void imgUpdate(ReviewVO vo) {
		my.update("review.imgUpdate", vo);
	}
	
	// 태그 공연 장소 연동
	public List<PlayVO> playList(ReviewPageVO vo) {
		return my.selectList("review.playList2", vo);
	}
	
	// 태그 공연 장소 수 카운트
	public int playCount() {
		return my.selectOne("review.playCount");
	}
	
	// 태그 공연 검색 결과
	public List<PlayVO> playSearch(ReviewPageVO vo, String query) {
		Map<String, Object> params = new HashMap<>();
	    params.put("query", query);
	    params.put("start", vo.getStart());
	    params.put("end", vo.getEnd());
		return my.selectList("review.playSearch", params);
	}
	
	// 태그 공연 검색 수
	public int playSearchCount(String query) {
		return my.selectOne("review.playSearchCount", query);
	}
	
	// 장르로 공연 검색 결과
	public List<PlayVO> genreSearch(ReviewPageVO vo, String genre) {
		Map<String, Object> params = new HashMap<>();
		params.put("genre", genre);
		params.put("start", vo.getStart());
	    params.put("end", vo.getEnd());
		return my.selectList("review.genreSearch", params);
	}
	
	public int genreCount(String genre) {
		return my.selectOne("review.genreCount", genre);
	}
	
	// 삭제할 사진명 가져오기
	public List<String> deletedImg(int id) {
		return my.selectList("review.deletedImg", id);
	}
}
