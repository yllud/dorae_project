package com.multi.dorae.help;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	@Autowired
	SqlSessionTemplate sql;
	
	public int insert(NoticeVO vo) {
		return sql.insert("notice.insert", vo);
	}
	
	public int update(NoticeVO vo) {
		return sql.update("notice.update", vo);
	}
	
	public int delete(long notice_id) {
		return sql.delete("notice.delete", notice_id);
	}
	
	public NoticeVO one(long notice_id) {
		return sql.selectOne("notice.selectOne", notice_id);
	}
	
	public List<NoticeVO> list() {
		return sql.selectList("notice.selectList");
	}
	
	public List<NoticeVO> listWithPaging(PageVO pageVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("start", pageVO.getStart());
		map.put("end", pageVO.getEnd());
		
		return sql.selectList("notice.selectListWithPaging", map);
	}
	
	public int count() {
		return sql.selectOne("notice.count");
	}
}
