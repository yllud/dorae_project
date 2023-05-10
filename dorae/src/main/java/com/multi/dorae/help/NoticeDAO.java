package com.multi.dorae.help;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	@Autowired
	SqlSessionTemplate sql;
	
	public int insert(NoticeVO vo) {
		return sql.insert("notice.create", vo);
	}
	
	public int update(NoticeVO vo) {
		return sql.update("notice.update", vo);
	}
	
	public int delete(long notice_id) {
		return sql.delete("notice.delete", notice_id);
	}
	
	public NoticeVO selectOne(long notice_id) {
		return sql.selectOne("notice.selectOne", Long.valueOf(notice_id));
	}
	
	public List<NoticeVO> selectList() {
		return sql.selectList("notice.selectList");
	}
}
