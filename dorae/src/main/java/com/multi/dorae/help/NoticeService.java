package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeService {
	
	@Autowired
	NoticeDAO noticeDAO;
	
	public int noticeCreate(NoticeVO vo) {
		return noticeDAO.insert(vo);
	}
	
	public int noticeUpdate(NoticeVO vo) {
		return noticeDAO.update(vo);
	}
	
	public int noticeDelete(long notice_id) {
		return noticeDAO.delete(notice_id);
	}
	
	public NoticeVO noticeOne(long notice_id) {
		return noticeDAO.selectOne(notice_id);
	}
	
	public List<NoticeVO> noticeList() {
		return noticeDAO.selectList();
	}
}
