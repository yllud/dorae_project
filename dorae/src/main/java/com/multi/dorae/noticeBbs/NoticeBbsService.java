package com.multi.dorae.noticeBbs;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.dorae.help.NoticeVO;

@Service
public class NoticeBbsService {

	@Autowired
	NoticeBbsDAO dao;

	// 태그로 검색한 리스트 가져오기(페이징X) - 공지사항 출력용
	public List<NoticeVO> notice(String tag) {
		return dao.notice(tag);
	}

	// 태그로 검색한 리스트 가져오기(페이징O) - 이벤트 출력용
	public List<NoticeVO> event(NoticeBbsPageVO vo, String tag) {
		vo.setStartEnd(vo.getPage());
		return dao.tag(vo, tag);
	}

	// 태그로 검색한 리스트 페이지 수 계산
	public int getTagPages(String tag) {
		int count = dao.tagCount(tag);
		return count / 5 + (count % 5 == 0 ? 0 : 1);
	}

	// 현재 페이지 설정 - 페이지 버튼 페이징 처리
	public int currentButtonPage(NoticeBbsPageVO vo) {
		int currentPage = vo.getPage();
		int buttonsPerPage = 10;
		return (int) Math.ceil((double) currentPage / buttonsPerPage);
	}
	
	// 상세 페이지
	public NoticeVO getDetail(long notice_id) {
		return dao.one(notice_id);
	}
}
