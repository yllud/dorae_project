package com.multi.dorae.review;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.multi.dorae.search.PlayVO;

@Controller
public class ReviewController {

	@Autowired
	ReviewService reviewService;

	// 다녀온 후기 등록(사진 복수 첨부)
	@RequestMapping("review/insert")
	public String insert(ReviewVO vo, HttpServletRequest request, MultipartFile[] files) throws Exception {
		// 세션에서 email 값을 가져와서 vo에 설정
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		vo.setEmail(email);

		// 파일 업로드 서비스 호출 - 파일명 리턴
		List<String> savedNames = reviewService.upload(vo, request, files);

		// 파일명 vo에 설정
		if (savedNames.isEmpty()) {
			vo.setImages(null);
		} else {
			vo.setImages(savedNames);
		}

		// db 저장 서비스 호출
		reviewService.insert(vo);

		return "redirect:/review/reviewBbs.jsp";
	}

	// 다녀온 후기 전체 리스트 불러오기
	@RequestMapping("review/all")
	public void all(ReviewPageVO vo, Model model) {
		// 전체 리스트 가져오는 서비스 호출
		List<ReviewVO> list = reviewService.getAll(vo);

		// 페이지 수 계산하는 서비스 호출
		int count = reviewService.getAllCount(); // 전체 게시글 수
		int pages = reviewService.getAllpages(); // 전체 게시글 페이징 시 필요한 페이지 수

		// 현재 페이지 서비스 호출
		int currentButtonPage = reviewService.currentButtonPage(vo);

		// 모델에 값 넣기
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 태그로 후기 검색
	@RequestMapping("review/tagSearch")
	public void tagSearch(ReviewPageVO vo, String tag, Model model) {
		// 태그로 검색한 리스트 가져오는 서비스 호출
		List<ReviewVO> list = reviewService.getReviewsByTag(vo, tag);

		// 페이지 수 계산하는 서비스 호출
		int count = reviewService.getTagCount(tag); // 태그로 검색한 게시글 수
		int pages = reviewService.getTagPages(tag); // 태그로 검색한 게시글 페이징 시 필요한 페이지 수

		// 현재 페이지 서비스 호출
		int currentButtonPage = reviewService.currentButtonPage(vo);

		// 모델에 값 넣기
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pages", pages);
		model.addAttribute("tag", tag);
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 상세페이지
	@RequestMapping("review/detail")
	public void detail(int id, Model model) {
		// id로 검색한 값 1개 가져오는 서비스 호출
		ReviewVO review = reviewService.getReviewById(id);
		// 모델에 값 넣기
		model.addAttribute("review", review);
	}

	// 수정 전 정보를 불러와서 띄워주기
	// PostMapping으로 URL 접근 차단
	@PostMapping("review/update")
	public void update(int id, Model model) {
		// id로 검색한 값 1개 가져오는 서비스 호출
		ReviewVO review = reviewService.getReviewById(id);
		// 모델에 값 넣기
		model.addAttribute("review", review);
	}

	// 후기 수정
	@RequestMapping("review/update2")
	public void update2(ReviewVO vo, HttpServletResponse response) throws IOException {
		// 후기 수정 서비스 호출
		reviewService.update(vo);

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
	public void imgUpdate(ReviewVO vo, HttpServletResponse response, HttpServletRequest request, MultipartFile[] files)
			throws Exception {

		// 기존 이미지 삭제 처리를 위한 이미지 리스트 받아오는 서비스 호출
		List<String> deletedImgList = reviewService.getDeletedImg(vo.getId());

		// 이미지 삭제 처리 서비스 호출
		reviewService.deleteImg(deletedImgList);

		// 사진 수정 서비스 호출
		List<String> savedNames = reviewService.upload(vo, request, files);

		// 파일명 vo에 설정
		if (savedNames.isEmpty()) {
			vo.setImages(null);
		} else {
			vo.setImages(savedNames);
		}

		// 수정된 파일명 db 업데이트하는 서비스 호출
		reviewService.updateImg(vo);

		// 작업 완료 후 알림 팝업 창을 띄우고 이전페이지로 돌아가는 JavaScript 코드
		String script = "<script>alert('사진 수정이 완료되었습니다.'); history.back();</script>";

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(script);
		response.getWriter().flush();
	}

	// 후기 삭제
	@RequestMapping("review/delete")
	public void delete(int id, HttpServletResponse response) throws IOException {
		// 이미지 삭제 처리를 위한 이미지 리스트 받아오는 서비스 호출
		List<String> deletedImgList = reviewService.getDeletedImg(id);

		// 이미지 삭제 처리 서비스 호출
		reviewService.deleteImg(deletedImgList);

		// db 삭제 처리
		reviewService.delete(id);

		// 작업 완료 후 팝업 창을 닫고 이전 창을 새로고침하는 JavaScript 코드
		String script = "<script>" + "alert('게시글 삭제가 완료되었습니다.');" + "window.opener.location.reload();" + // 이전 창 새로고침
				"window.close();" + // 팝업 창 닫기
				"</script>";

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(script);
		response.getWriter().flush();
	}

	// 전체 공연명 가져오기- 태그로 선택 기능
	@RequestMapping("review/tag")
	public void tag(ReviewPageVO vo, Model model) {

		// 전체 공연명 리스트 가져오는 서비스 호출
		List<PlayVO> tag = reviewService.getPlayAll(vo);

		// 공연명 페이지 계산 서비스 호출
		int pages = reviewService.getPlayAllPages();

		// 버튼 페이징 서비스 호출
		int currentButtonPage = reviewService.currentButtonPage(vo);

		// 모델에 값 넣기
		model.addAttribute("tag", tag);
		model.addAttribute("pages", pages);
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 검색한 공연명 가져오기
	@RequestMapping("review/playSearch")
	public void playSearch(ReviewPageVO vo, String query, Model model) {

		// 공연명으로 검색한 공연 리스트 가져오는 서비스 호출
		List<PlayVO> tag = reviewService.getPlayByName(vo, query);

		// 공연명으로 검색한 공연 페이지 수 계산 서비스 호출
		int pages = reviewService.getPlayByNamePages(query);

		// 버튼 페이징 서비스 호출
		int currentButtonPage = reviewService.currentButtonPage(vo);
		
		// 모델에 값 넣기
		model.addAttribute("tag", tag);
		model.addAttribute("pages", pages);
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

	// 장르로 공연명 검색
	@RequestMapping("review/genreSearch")
	public void genreSearch(ReviewPageVO vo, String genre, Model model) {

		// 장르로 검색한 공연 리스트 가져오는 서비스 호출
		List<PlayVO> tag = reviewService.getPlayByGenre(vo, genre);

		// 장르로 검색한 공연 페이지 수 계산 서비스 호출
		int pages = reviewService.getPlayByGenrePages(genre);

		// 버튼 페이징 서비스 호출
		int currentButtonPage = reviewService.currentButtonPage(vo);
		
		// 모델에 값 넣기
		model.addAttribute("tag", tag);
		model.addAttribute("pages", pages);
		model.addAttribute("currentButtonPage", currentButtonPage);
	}

}
