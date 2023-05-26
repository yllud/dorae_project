package com.multi.dorae.help;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ApplyBusinessDAO {
	
	@Autowired
	SqlSessionTemplate sql;
	
	public int insert(String member_id) {
		return sql.insert("apply.insert", member_id);
	}
	
	public int updateApproval(ApplyBusinessVO applyVO) {
		return sql.update("apply.updateApproval", applyVO);
	}
	
	public List<ApplyBusinessVO> list() {
		return sql.selectList("apply.selectList");
	}
	
	public List<ApplyBusinessVO> listByMemberId(String member_id) {
		return sql.selectList("apply.selectListByMemberId", member_id);
	}
}
