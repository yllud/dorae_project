package com.multi.dorae.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.sql.Date;

@Controller
public class BusinessController {

	@Autowired
	BusinessDAO dao;

	@Autowired
	PlayDAO dao2;

	@RequestMapping(value = "search/business", method = RequestMethod.POST)
	public void businessPage(String email, Model model) {

		System.out.println("(Controller) business 요청");

	}

	@RequestMapping(value = "search/businessList", method = RequestMethod.POST)
	public void businessList(CriteriaB cri, Model model) {

		System.out.println("(Controller) business list 요청");
		System.out.println(cri.getEmail());
		System.out.println(cri.getPage());

		int count = dao.count(cri); // 리스트 개수
		System.out.println("list count>> " + count);
		int page_cnt = cri.makePageBtn(count); // 페이지 버튼 개수
		System.out.println("page count>> " + page_cnt);

		cri.setStartEnd(cri.getPage()); // 페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list = dao.list(cri);

		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("page_cnt", page_cnt);
	}

	@RequestMapping(value = "search/businessList2", method = RequestMethod.POST)
	public void businessList2(CriteriaB cri, Model model) {

		System.out.println("(Controller) business list2 요청");

		cri.setStartEnd(cri.getPage()); // 페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list2 = dao.list(cri);

		model.addAttribute("list2", list2);
		model.addAttribute("cri", cri);

	}

	@PostMapping("search/businessInsert")
//	@RequestMapping(value = "search/businessInsert")
	public void businessInsert() {
		System.out.println("(Controller) business insert 요청");
	}

	// 오늘 날짜
	public Date CurrentDateTime() {

		// 현재 날짜 구하기
		LocalDate now = LocalDate.now();

		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		// 포맷 적용
		String formatedNow = now.format(formatter);

		Date today = Date.valueOf(formatedNow);

		// 결과 출력
		System.out.println(formatedNow);
		return today;
	}

	public String playState(Date start, Date end, Date now) {

		int s = start.compareTo(now);
		int e = end.compareTo(now);
		if (e < 0) {
			return "공연완료";
		} else if (s <= 0) {
			return "공연중";
		} else {
			return "공연예정";
		}
	}

	@PostMapping("search/businessInsert2")
//	@RequestMapping(value = "search/businessInsert2")
	public void businessInsert2(String email, PlayVO vo, Model model) {
		System.out.println("(Controller) business insert2 요청");
		System.out.println(vo.getPlay_name());

		String play_id = "PF9548462";
		vo.setPlay_id(play_id);
		vo.setStage_id("FC000020");

		//공연 기간에 따라 공연 상태 설정
		Date today = CurrentDateTime();
		vo.setState(playState(vo.getPlay_start(), vo.getPlay_end(), today));
		dao2.insert(vo);

		BusinessVO vo2 = new BusinessVO();
		vo2.setPlay_id(play_id);
		vo2.setEmail(email);
		dao.insert(vo2);

//		String referer = request.getHeader("Referer");
//	    return "redirect:"+ referer;
//	    return "redirect:/search/businessInsert";
	}

	@RequestMapping(value = "search/businessUpdate", method = RequestMethod.POST)
	public void businessUpdate(String play_id, Model model) {
		System.out.println("(Controller) business update 요청");
		System.out.println(play_id);
		PlayVO vo = dao2.playDetail(play_id);

		model.addAttribute("vo", vo);
	}
}
