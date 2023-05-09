package com.multi.dorae.sns;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RestController {

	@RequestMapping("search")
	@ResponseBody
	public ArrayList<BlogVO> searchBlog(@RequestParam("query") String query) {
		ArrayList<BlogVO> resultList = BlogAPI.searchNaverBlog(query);
		return resultList;
	}

}
