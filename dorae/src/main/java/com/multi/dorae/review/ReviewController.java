package com.multi.dorae.review;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
	            	// 파일명 -> 회원이메일+원본파일명으로 해서 파일명겹치더라도 중복안되게 설정(?)
//	            	String savedName = reviewVO.getEmail() + file.getOriginalFilename();
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
	    return "redirect:/review/reviewBbs2.jsp";
	}

//	다녀온 후기 전체 리스트 불러오기
	@RequestMapping("review/all")
	public void all(ReviewPageVO vo, Model model) {
//		페이징 처리
		vo.setStartEnd(vo.getPage());
		List<ReviewVO> list = dao.all(vo);
		int count = dao.count();
		int pages = 0;
		if (count % 4 == 0) {
			pages = count / 4;
		} else {
			pages = count / 4 + 1;
		}
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
	}

//	태그로 후기 검색
	@RequestMapping("review/tagSearch")
	public void tagSearch(ReviewPageVO vo, String tag, Model model) {
		vo.setStartEnd(vo.getPage());
		
		ReviewVO reviewVO = new ReviewVO();
		reviewVO.setTag(tag);
		
		List<ReviewVO> list = dao.tagSearch(vo, tag);
		int count = dao.tagCount(tag);
		int pages = 0;
		if (count % 4 == 0) {
			pages = count / 4;
		} else {
			pages = count / 4 + 1;
		}
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		model.addAttribute("tag", tag);
	}
}
