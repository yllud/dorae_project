package com.multi.dorae.noticeBbs;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.multi.dorae.help.NoticeVO;

@Component
public class NoticeBbsDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 공지사항 전체 목록 가져오기
	public List<NoticeVO> all(NoticeBbsPageVO vo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", vo.getStart());
		map.put("end", vo.getEnd());
		return my.selectList("notice.selectListWithPaging", map);
	}
	
	// 공지사항 전체 수 카운트
	public int count() {
		return my.selectOne("notice.count");
	}
	
	// 상세정보 가져오기
	public NoticeVO one(long notice_id) {
		return my.selectOne("notice.selectOne", notice_id);
	}
	
	// 태그 분류해서 검색(페이징처리)
	public List<NoticeVO> tag(NoticeBbsPageVO vo, String tag) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", vo.getStart());
		map.put("end", vo.getEnd());
		map.put("tag", tag);
		return my.selectList("notice.selectListByTagWithPaging", map);
	}
	
	// 태그 게시물 수 카운트
	public int tagCount(String tag) {
		return my.selectOne("notice.countByTag", tag);
	}
	
	// 태그 분류해서 검색(페이징X-공지사항용)
	public List<NoticeVO> notice(String tag) {
		return my.selectList("notice.selectListByTag", tag);
	}
}
