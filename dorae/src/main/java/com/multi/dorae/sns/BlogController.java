package com.multi.dorae.sns;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

}
