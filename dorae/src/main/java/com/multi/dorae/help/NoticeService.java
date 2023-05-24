package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.multi.dorae.admin.AdminVO;

@Service
public class NoticeService {
	
	@Autowired
	NoticeDAO noticeDAO;
	
	public boolean insert(NoticeVO noticeVO, AdminVO adminVO) {
		if (!isValid(noticeVO)) {
			return false;
		}
		
		noticeVO.setAdmin_id(adminVO.getId());
		
		if (noticeDAO.insert(noticeVO) != 1) {
			System.out.println("공지사항 등록에 실패함");
			return false;
		}
		
		return true;
	}
	
	public boolean update(NoticeVO noticeVO) {
		if (!isValid(noticeVO)) {
			return false;
		}
		
		if (noticeDAO.update(noticeVO) != 1) {
			System.out.println("공지사항 수정에 실패함");
			return false;
		}
		return true;
	}
	
	public int delete(long notice_id) {
		return noticeDAO.delete(notice_id);
	}
	
	public NoticeVO one(long notice_id) {
		return noticeDAO.one(notice_id);
	}
	
	public List<NoticeVO> listWithPaging(PageVO pageVO) { // 공지사항 전체
		return noticeDAO.listWithPaging(pageVO);
	}
	
	public List<NoticeVO> listByTagWithPaging(String tag, PageVO pageVO) { // 태그별 공지사항
		return noticeDAO.listByTagWithPaging(tag, pageVO);
	}
	
	public int count() {
		return noticeDAO.count();
	}
	
	private boolean isValid(NoticeVO noticeVO) {
//		org.springframework.util.StringUtils
//		주어진 문자열에 실제 텍스트가 포함되어 있는지 확인하는 메서드
//		문자열이 null이 아니고 길이가 0보다 크며 공백이 아닌 문자를 하나 이상 포함하는 경우 true를 반환함.
		if (!StringUtils.hasText(noticeVO.getTitle())) {
			System.out.println("공지사항 제목이 없음");
			return false;
		}
		if (!StringUtils.hasText(noticeVO.getContent())) {
			System.out.println("공지사항 내용이 없음");
			return false;
		}
		return true;
	}
}
