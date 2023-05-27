package com.multi.dorae.help;

import java.util.HashMap;
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
	
	public ApplyBusinessVO one(long apply_id) {
		return sql.selectOne("apply.selectOne", apply_id);
	}
	
	public List<ApplyBusinessVO> listWithPaging(PageVO pageVO) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		pageVO.setTotal(count());
		pageVO.calc();

		map.put("start", pageVO.getStart());
		map.put("end", pageVO.getEnd());
		map.put("cntPerPage", pageVO.getCntPerPage());

		return sql.selectList("apply.selectListWithPaging", map);
	}
	
	public List<ApplyBusinessVO> listByMemberId(String member_id) {
		return sql.selectList("apply.selectListByMemberId", member_id);
	}
	
	public int count() {
		return sql.selectOne("apply.count");
	}
}
