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
}
