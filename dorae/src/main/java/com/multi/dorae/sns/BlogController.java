package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BlogController {

	@Autowired
	BlogService blogService;
	@Autowired
	BlogAPI blogApi;

//	키워드로 검색한 블로그 data 가져오기
	@RequestMapping("sns/blogList")
	public void list(int rankNum, Model model) {
		List<BlogVO> list = blogService.list(rankNum);
		model.addAttribute("list", list);
	}
  
}
