package com.multi.dorae.sns;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.search.RankVO;

@Controller
public class BlogController {

	@Autowired
	BlogDAO dao;

//	추천검색어 추출
	@RequestMapping("sns/recommend")
	@ResponseBody
	public List<String> recommend() {
		List<String> list = dao.recommend();
		return list;
	}

//	키워드로 검색한 블로그 데이터를 몽고db 저장
	@RequestMapping("sns/saveBlog")
	public void saveBlog(String query, int rank) {
		ArrayList<BlogVO> resultList = BlogAPI.searchNaverBlog(query);
		// 각 입력에 대해 rank 값을 설정
		for (BlogVO blog : resultList) {
			blog.setRank(rank);
		}
		dao.insert(resultList);
	}

//	키워드로 검색한 블로그 data 가져오기
	@RequestMapping("sns/blogList")
	public void list2(int rank, Model model) {
		List<BlogVO> list = dao.list(rank);
		model.addAttribute("list", list);
	}

}
