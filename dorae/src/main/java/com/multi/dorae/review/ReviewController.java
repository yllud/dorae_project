package com.multi.dorae.review;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.multi.dorae.search.PlayVO;

@Controller
public class ReviewController {

	@Autowired
	ReviewDAO dao;
	@Autowired
	private ServletContext servletContext;

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
	// PostMapping으로 URL 접근 차단
	@PostMapping("review/update")
	public void update(int id, Model model) {
		ReviewVO review = dao.one(id);
		model.addAttribute("review", review);
	}

	// 후기 수정
	@RequestMapping("review/update2")
	public void update2(ReviewVO vo, HttpServletResponse response) throws IOException {
		dao.update(vo);

		// 작업 완료 후 팝업 창을 닫고 이전 창을 새로고침하는 JavaScript 코드
		String script = "<script>" + "alert('게시글 수정이 완료되었습니다.');" + "window.opener.location.reload();" + // 이전 창 새로고침
				"window.close();" + // 팝업 창 닫기
				"</script>";

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(script);
		response.getWriter().flush();
	}

	// 사진 수정
	@RequestMapping("review/imgUpdate")
	public void imgUpdate(ReviewVO reviewVO, HttpServletResponse response, HttpServletRequest request,
			MultipartFile[] files, Model model) throws Exception {

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

		// 작업 완료 후 알림 팝업 창을 띄우고 이전페이지로 돌아가는 JavaScript 코드
		String script = "<script>alert('사진 수정이 완료되었습니다.'); history.back();</script>";

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(script);
		response.getWriter().flush();
		
		
	}

	// 후기 삭제
	@RequestMapping("review/delete")
	public void delete(int id, HttpServletResponse response) throws IOException {
		// 이미지 삭제 처리를 위한 이미지 리스트 받아오기
		List<String> deletedImgList = dao.deletedImg(id);
		// 이미지가 존재할 경우 삭제
		String uploadPath = servletContext.getRealPath("/resources/upload");
		for (String deletedImg : deletedImgList) {
			if (deletedImg == null) {
				continue;
			}
			String filePathString = uploadPath + "/" + deletedImg;
			Path filePath = Paths.get(filePathString);

			try {
				Files.delete(filePath);
				System.out.println("-----삭제한 파일: " + deletedImg);
			} catch (Exception e) {
				System.out.println("-----삭제 실패한 파일: " + deletedImg);
				e.printStackTrace();
			}
		}

		// db 삭제 처리
		dao.delete(id);

		// 작업 완료 후 팝업 창을 닫고 이전 창을 새로고침하는 JavaScript 코드
		String script = "<script>" + "alert('게시글 삭제가 완료되었습니다.');" + "window.opener.location.reload();" + // 이전 창 새로고침
				"window.close();" + // 팝업 창 닫기
				"</script>";

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(script);
		response.getWriter().flush();
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
