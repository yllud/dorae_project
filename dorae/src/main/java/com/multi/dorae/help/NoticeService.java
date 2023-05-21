package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {
	
	@Autowired
	NoticeDAO noticeDAO;
	
	public int insert(NoticeVO vo) {
		return noticeDAO.insert(vo);
	}
	
	public int update(NoticeVO vo) {
		return noticeDAO.update(vo);
	}
	
	public int delete(long notice_id) {
		return noticeDAO.delete(notice_id);
	}
	
	public NoticeVO one(long notice_id) {
		return noticeDAO.one(notice_id);
	}
	
	public List<NoticeVO> list() {
		return noticeDAO.list();
	}
	
	public List<NoticeVO> listWithPaging(PageVO pageVO) {
		return noticeDAO.listWithPaging(pageVO);
	}
	
	public int count() {
		return noticeDAO.count();
	}
}
