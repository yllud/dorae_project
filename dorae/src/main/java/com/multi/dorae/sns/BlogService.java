package com.multi.dorae.sns;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BlogService {

	@Autowired
	BlogDAO dao;
	@Autowired
	BlogAPI blogApi;

//	키워드로 검색한 블로그 data 가져오기
	public List<BlogVO> list(int rankNum) {
		return dao.search(rankNum);
	}

	// 키워드로 검색한 블로그 데이터를 db 저장 메서드
	public void saveBlog(String query, int rankNum) {
		ArrayList<BlogVO> resultList = blogApi.searchNaverBlog(query);
		// 각 입력에 대해 rankNum 값을 설정
		for (BlogVO blog : resultList) {
			blog.setRankNum(rankNum);
			dao.insert(blog);
		}
	}

	// db 내용이 있다면 row 삭제
	public void delete() {
		if (dao.count() != 0) {
			dao.delete();
		}
	}
}
