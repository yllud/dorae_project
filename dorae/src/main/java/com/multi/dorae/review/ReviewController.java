package com.multi.dorae.review;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.multi.dorae.search.PlayVO;

@Controller
public class ReviewController {

	@Autowired
	ReviewDAO dao;

	// 다녀온 후기 등록(사진 복수 첨부)
	@RequestMapping("review/insert")
	public String insert(ReviewVO reviewVO, HttpServletRequest request, MultipartFile[] files, Model model)
			throws Exception {
		// 세션에서 email 값을 가져와서 reviewVO에 설정
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		reviewVO.setEmail(email);

		List<String> savedNames = new ArrayList<>();
		String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");

		if (files != null && files.length > 0) {
			for (MultipartFile file : files) {
				if (!file.isEmpty()) {
					String originalFilename = file.getOriginalFilename();
					String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
					String uuid = UUID.randomUUID().toString(); // UUID 생성

					// 파일명 -> 회원이메일+UUID+확장자로 설정 -> 파일명 중복 방지
					String savedName = reviewVO.getEmail() + "_" + uuid + extension;
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
		System.out.println("업로드경로: " + uploadPath);
		dao.insert(reviewVO);
		return "redirect:/review/reviewBbs.jsp";
	}

//	다녀온 후기 전체 리스트 불러오기
	@RequestMapping("review/all")
	public void all(ReviewPageVO vo, Model model) {
//		페이징 처리
		vo.reviewStartEnd(vo.getPage());
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

		// 버튼 페이징
		int currentPage = vo.getPage(); // 현재 페이지 값
		int buttonsPerPage = 10;
		int currentButtonPage = (int) Math.ceil((double) currentPage / buttonsPerPage); // currentButtonPage 계산
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

//	태그로 후기 검색
	@RequestMapping("review/tagSearch")
	public void tagSearch(ReviewPageVO vo, String tag, Model model) {
		vo.reviewStartEnd(vo.getPage());

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

		// 버튼 페이징
		int currentPage = vo.getPage(); // 현재 페이지 값
		int buttonsPerPage = 10;
		int currentButtonPage = (int) Math.ceil((double) currentPage / buttonsPerPage); // currentButtonPage 계산
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 상세페이지
	@RequestMapping("review/detail")
	public void detail(int id, Model model) {
		ReviewVO review = dao.one(id);
		model.addAttribute("review", review);
	}

	// 수정 전 정보를 불러와서 띄워주기
	@RequestMapping("review/update")
	public void update(int id, Model model) {
		ReviewVO review = dao.one(id);
		model.addAttribute("review", review);
	}

	// 후기 수정
	@RequestMapping("review/update2")
	public String update2(ReviewVO vo) {
		dao.update(vo);
		return "redirect:/review/reviewBbs.jsp";
	}

	// 사진 수정
	@RequestMapping("review/imgUpdate")
	public String imgUpdate(ReviewVO reviewVO, HttpServletRequest request, MultipartFile[] files, Model model)
			throws Exception {

		List<String> savedNames = new ArrayList<>();
		String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");

		if (files != null && files.length > 0) {
			for (MultipartFile file : files) {
				if (!file.isEmpty()) {
					String originalFilename = file.getOriginalFilename();
					String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
					String uuid = UUID.randomUUID().toString(); // UUID 생성

					// 파일명 -> 회원이메일+UUID+확장자로 설정 -> 파일명 중복 방지
					String savedName = reviewVO.getEmail() + "_" + uuid + extension;
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
		System.out.println("업로드경로: " + uploadPath);
		dao.imgUpdate(reviewVO);
		return "redirect:/review/reviewBbs.jsp";
	}

	// 후기 삭제
	@RequestMapping("review/delete")
	public String delete(int id) {
		dao.delete(id);
		return "redirect:/review/reviewBbs.jsp";
	}

	// 태그 공연명 연동
	@RequestMapping("review/tag")
	public void tag(ReviewPageVO vo, Model model) {
		vo.tagStartEnd(vo.getPage());

		int count = dao.playCount();
		int pages = 0;
		if (count % 10 == 0) {
			pages = count / 10;
		} else {
			pages = count / 10 + 1;
		}

		List<PlayVO> tag = dao.tag(vo);
		model.addAttribute("tag", tag);
		model.addAttribute("pages", pages);

		// 버튼 페이징
		int currentPage = vo.getPage(); // 현재 페이지 값
		int buttonsPerPage = 10;
		int currentButtonPage = (int) Math.ceil((double) currentPage / buttonsPerPage); // currentButtonPage 계산
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 태그 공연명 연동 검색
	@RequestMapping("review/playSearch")
	public void playSearch(ReviewPageVO vo, String query, Model model) {
		vo.tagStartEnd(vo.getPage());

		int count = dao.playSearchCount(query);
		int pages = 0;
		if (count % 10 == 0) {
			pages = count / 10;
		} else {
			pages = count / 10 + 1;
		}

		List<PlayVO> tag = dao.playSearch(vo, query);
		System.out.println("---------검색 결과 : " + tag);
		model.addAttribute("tag", tag);
		model.addAttribute("pages", pages);

		// 버튼 페이징
		int currentPage = vo.getPage(); // 현재 페이지 값
		int buttonsPerPage = 10;
		int currentButtonPage = (int) Math.ceil((double) currentPage / buttonsPerPage); // currentButtonPage 계산
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 장르로 공연명 검색
	@RequestMapping("review/genreSearch")
	public void genreSearch(ReviewPageVO vo, String genre, Model model) {
		vo.tagStartEnd(vo.getPage());

		int count = dao.genreCount(genre);
		int pages = 0;
		if (count % 10 == 0) {
			pages = count / 10;
		} else {
			pages = count / 10 + 1;
		}

		List<PlayVO> tag = dao.genreSearch(vo, genre);
		System.out.println("---------검색 결과 : " + tag);
		model.addAttribute("tag", tag);
		model.addAttribute("pages", pages);

		// 버튼 페이징
		int currentPage = vo.getPage(); // 현재 페이지 값
		int buttonsPerPage = 10;
		int currentButtonPage = (int) Math.ceil((double) currentPage / buttonsPerPage); // currentButtonPage 계산
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 임시로 세션값 설정-> 테스트용
	@RequestMapping("review/setSession")
	public ResponseEntity<String> setSession(HttpServletRequest request) {
		request.getSession().setAttribute("email", "test@example.com");
		return ResponseEntity.ok("세션 값이 설정되었습니다.");
	}

	@RequestMapping("review/clearSession")
	public ResponseEntity<String> clearSession(HttpServletRequest request) {
		request.getSession().invalidate();
		return ResponseEntity.ok("세션 값이 비워졌습니다.");
	}

}
