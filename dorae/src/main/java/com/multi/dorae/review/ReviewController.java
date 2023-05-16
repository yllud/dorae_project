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
	
	@RequestMapping("review/insert2")
	public void insert2(ReviewVO reviewVO, HttpServletRequest request, MultipartFile[] files, Model model)
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
	}
}
