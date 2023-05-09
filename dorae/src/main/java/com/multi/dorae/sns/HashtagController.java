package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HashtagController {

	@Autowired
	HashtagDAO dao;

	@RequestMapping("saveHashtag")
	public void saveHashtag(String keyword) {
		HashtagVO hashtagVO = dao.one(keyword);
		if (hashtagVO == null) {
			dao.insert(keyword);
		} else {
			hashtagVO.setCount(hashtagVO.getCount() + 1);
			dao.update(hashtagVO);
		}
	}

	@RequestMapping("list")
	public void list(Model model) {
		List<HashtagVO> list = dao.list();
		model.addAttribute("list", list);
	}

}
