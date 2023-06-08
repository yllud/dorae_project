package com.multi.dorae.sns;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BlogDAO {

	@Autowired
	SqlSessionTemplate my;
	
	// db에 항목이 있는지 체크
	public int count() {
		return my.selectOne("blog.count");
	}

	// db row 전체 삭제하기
	public void delete() {
		my.delete("blog.delete");
	}
	
	// 검색 결과를 db에 넣기
    public void insert(BlogVO vo) {
		my.insert("blog.insert", vo);
	}
    
    // 검색 결과 가져오기
    public List<BlogVO> search(int rankNum) {
		return my.selectList("blog.search", rankNum);
	}
}
