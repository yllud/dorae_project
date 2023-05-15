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
	
	@RequestMapping("sns/blogSearch")
	@ResponseBody
	public ArrayList<BlogVO> searchBlog(@RequestParam("query") String query) {
		ArrayList<BlogVO> resultList = BlogAPI.searchNaverBlog(query);
//		검색 결과를 몽고db에 저장
		dao.insert(resultList);
//		결과 화면 출력을 위해 반환
		return resultList;
	}
	
	@RequestMapping("sns/blogList")
	public void list(Model model) {
		List<BlogVO> list = dao.list();
		model.addAttribute("list", list);
	}
	
//	추천검색어 추출
	@RequestMapping("sns/recommend")
	@ResponseBody
	public List<String> recommend() {
		List<String> list = dao.recommend();
		return list;
	}
	
//	키워드로 검색한 블로그 데이터를 몽고db 저장
	@RequestMapping("sns/saveBlog")
	public void saveBlog(String query) {
		ArrayList<BlogVO> resultList = BlogAPI.searchNaverBlog(query);
		dao.insert(resultList);
	}
	
//	키워드로 검색한 블로그 data 가져오기
	@RequestMapping("sns/blogList2")
	public void list2(String query, Model model) {
		List<BlogVO> list = dao.list2(query);
		model.addAttribute("list", list);
	}

}
