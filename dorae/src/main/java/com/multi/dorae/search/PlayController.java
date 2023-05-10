package com.multi.dorae.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class PlayController {

	@Autowired
	PlayDAO dao;
	
	@RequestMapping("search/playList")
	public void list(Model model) {
		//Model은 컨트롤러의 list를 views/list.jsp까지만 전달할 수 있는 객체 
		System.out.println("play 전체 list 요청됨..");
		List<PlayVO> list = dao.list();
		model.addAttribute("list", list);
		
		
	}
}
