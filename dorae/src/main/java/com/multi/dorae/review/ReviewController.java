package com.multi.dorae.review;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ReviewController {

	@Autowired
	ReviewDAO dao;

	// 다녀온 후기 등록(사진 복수 첨부)
	@RequestMapping("review/insert")
	public String insert(ReviewVO reviewVO, HttpServletRequest request, MultipartFile[] files, Model model)
	        throws Exception {

	    List<String> savedNames = new ArrayList<>();
	    String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");

	    if (files != null && files.length > 0) {
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                String savedName = file.getOriginalFilename();
	                File target = new File(uploadPath + File.separator + savedName);
	                file.transferTo(target);
	                savedNames.add(savedName);
	            }
	        }
	    }

	    if (savedNames.isEmpty()) {
	        reviewVO.setImages(null);
	    } else {
	        reviewVO.setImages(savedNames);
	    }

	    dao.insert(reviewVO);
	    return "redirect:/review/reviewBbs.jsp";
	}

//	다녀온 후기 전체 리스트 불러오기
	@RequestMapping("review/all")
	public List<ReviewVO> all() {
		List<ReviewVO> list = dao.all();
//		System.out.println(list);
		return list;
	}

//	태그로 후기 검색
	@RequestMapping("review/tagSearch")
	public List<ReviewVO> tagSearch(String tag) {
		List<ReviewVO> list = dao.tagSearch(tag);
		System.out.println(list);
		return list;
	}
}
