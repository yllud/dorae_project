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

	@RequestMapping("review/upladForm")
	public void uploadForm(HttpServletRequest request, MultipartFile file, Model model) throws Exception {
		String savedName = file.getOriginalFilename();
		String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");
		File target = new File(uploadPath + "/" + savedName);
		file.transferTo(target);
		model.addAttribute("savedName", savedName);
	}
	
	@RequestMapping("review/insert")
	public void insert(
					ReviewVO reviewVO,
					HttpServletRequest request, 
					MultipartFile file, 
					Model model) throws Exception {
		
		System.out.println("ReviewVO : "+reviewVO);
		System.out.println("file : "+file);
		String savedName = file.getOriginalFilename();
		
		String uploadPath 
			= request.getSession().getServletContext().getRealPath("resources/upload");
		File target = new File(uploadPath + "/" + savedName);
		file.transferTo(target);
		
		model.addAttribute("savedName", savedName);
//		reviewVO.setImg(savedName);
		System.out.println("uploadPath " + uploadPath);
		System.out.println("target : " + target);
		System.out.println("ReviewVO : "+reviewVO);
		dao.insert(reviewVO);
		
	}
	
//	다녀온 후기 등록(사진 복수 첨부)
	@RequestMapping("review/insert2")
	public String insert2(ReviewVO reviewVO, HttpServletRequest request, MultipartFile[] files, Model model)
			throws Exception {

		List<String> savedNames = new ArrayList<>();

		String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");

		for (MultipartFile file : files) {
			String savedName = file.getOriginalFilename();
			File target = new File(uploadPath + File.separator + savedName);
			file.transferTo(target);
			savedNames.add(savedName);
		}

		model.addAttribute("savedNames", savedNames);
		reviewVO.setImages(savedNames);

		dao.insert(reviewVO);
		return "redirect:/review/reviewBbs.jsp";
	}
	
//	다녀온 후기 전체 리스트 불러오기
	@RequestMapping("review/all")
	@ResponseBody
	public List<ReviewVO> all() {
		List<ReviewVO> list = dao.all();
//		System.out.println(list);
		return list;
	}
	
//	태그로 후기 검색
	@RequestMapping("review/tagSearch")
	@ResponseBody
	public List<ReviewVO> tagSearch(String tag) {
		List<ReviewVO> list = dao.tagSearch(tag);
		System.out.println(list);
		return list;
	}
}
