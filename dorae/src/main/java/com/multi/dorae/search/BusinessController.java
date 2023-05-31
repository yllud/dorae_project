package com.multi.dorae.search;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

//import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.io.File;
import java.io.IOException;
import java.sql.Date;

@Controller
public class BusinessController {

	@Autowired
	BusinessDAO dao;

	@Autowired
	PlayDAO dao2;

	@Autowired
	StageDAO dao3;
	

	@RequestMapping(value = "search/business", method = RequestMethod.POST)
	public void businessPage(String email, Model model) {

		System.out.println("(Controller) business 요청");

	}

	@RequestMapping(value = "search/businessList", method = RequestMethod.POST)
//	@RequestMapping("search/businessList")
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
//	@RequestMapping("search/businessList2")
	public void businessList2(CriteriaB cri, Model model) {

		System.out.println("(Controller) business list2 요청");

		cri.setStartEnd(cri.getPage()); // 페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list2 = dao.list(cri);

		model.addAttribute("list2", list2);
		model.addAttribute("cri", cri);

	}

	@PostMapping("search/businessInsert")
//	@RequestMapping("search/businessInsert")
	public void businessInsert() {
		System.out.println("(Controller) business insert 요청");
	}

	@RequestMapping("search/businessInsertStage")
	public void businessInsertStage() {
		System.out.println("(Controller) business insert stage 요청");
	}

	@RequestMapping("search/businessInsertStage2")
	public void businessInsertStage2(String title, Model model) {
		System.out.println("(Controller) business insert stage2 요청");
		List<StageVO> list = dao3.list(title);
		model.addAttribute("list", list);

	}

	@PostMapping("search/businessInsert2")
//	@RequestMapping("search/businessInsert2")
	public void businessInsert2(HttpServletRequest request, MultipartFile file, String email, PlayVO vo, Model model)
			throws Exception {

		System.out.println("(Controller) business insert2 요청");
		System.out.println(vo.getPlay_name());

		String play_id = "z" + CurrentDate() + CurrentTime() + email.split("@")[0];

		vo.setPlay_id(play_id);

		System.out.println("공연 기간" + vo.getPlay_start() + "~" + vo.getPlay_end());

		// 공연 기간에 따라 공연 상태 설정
		Date today = CurrentDate();
		vo.setState(playState(vo.getPlay_start(), vo.getPlay_end(), today));
		System.out.println("공연 상태 넣기 후>> " + vo);

		// 파일 있으면 업로드
		if (file != null) {
			String savedName0 = file.getOriginalFilename();
			String savedName = play_id + savedName0;

			System.out.println(savedName);
			String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload-play");
			File target = new File(uploadPath + "/" + savedName);
			file.transferTo(target);
			System.out.println("img넣기 전>> " + vo);
			vo.setPoster("../resources/upload-play/" + savedName);
			System.out.println("img넣은 후>> " + vo);
		}
		// 공연 db에 추가
		dao2.insert(vo);

		// 사업자 db 추가
		BusinessVO vo2 = new BusinessVO();
		vo2.setPlay_id(play_id);
		vo2.setEmail(email);
		dao.insert(vo2);

	}

	@RequestMapping(value = "search/businessDetail", method = RequestMethod.POST)
	public void businessDetail(String play_id, Model model) {
		System.out.println("(Controller) business Detail 요청");
		System.out.println(play_id);
		PlayVO vo = dao2.playDetail(play_id);

		model.addAttribute("vo", vo);
	}

	@RequestMapping(value = "search/businessUpdate", method = RequestMethod.POST)
	public void businessUpdate(String play_id, Model model) {
		System.out.println("(Controller) business update 요청");
		System.out.println(play_id);
		PlayVO vo = dao2.playDetail(play_id);

		model.addAttribute("vo", vo);
	}

	@RequestMapping(value = "search/businessUpdate2", method = RequestMethod.POST)
	public void businessUpdate2(HttpServletRequest request, MultipartFile file, PlayVO vo) throws Exception {
		System.out.println("(Controller) business update2 요청");
		System.out.println(vo);

		System.out.println("공연 기간" + vo.getPlay_start() + "~" + vo.getPlay_end());

		// 공연 기간에 따라 공연 상태 설정
		Date today = CurrentDate();
		vo.setState(playState(vo.getPlay_start(), vo.getPlay_end(), today));
		System.out.println("공연 상태 넣기 후>> " + vo);

		// 파일 있으면 업로드
		if (file != null) {
			String savedName0 = file.getOriginalFilename();
			String savedName = vo.getPlay_id() + savedName0;

			System.out.println(savedName);
			String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload-play");
			File target = new File(uploadPath + "/" + savedName);
			file.transferTo(target);
			System.out.println("img넣기 전>> " + vo);
			vo.setPoster("../resources/upload-play/" + savedName);
			System.out.println("img넣은 후>> " + vo);
		}
		// 공연 db에 추가

		dao2.updateAll(vo);

	}
	
	@RequestMapping(value = "search/businessDelete", method = RequestMethod.POST)
	public void businessDelete(String play_id, Model model) {
		System.out.println("(Controller) business delete 요청");
		System.out.println(play_id);
		PlayVO vo=new PlayVO();
		vo.setPlay_id(play_id);
		
		vo.setDelete_date(CurrentDate());
		System.out.println(vo);
		dao2.delete(vo);

	}
	
	
	
	@RequestMapping(value = "search/businessDeleteList", method = RequestMethod.POST)
	public void businessDeleteList(CriteriaB cri, Model model) {

		System.out.println("(Controller) business delete list 요청");
		System.out.println(cri.getEmail());
		System.out.println(cri.getPage());

		int count = dao.countDelete(cri); // 리스트 개수
		System.out.println("list count>> " + count);
		int page_cnt = cri.makePageBtn(count); // 페이지 버튼 개수
		System.out.println("page count>> " + page_cnt);

		cri.setStartEnd(cri.getPage()); // 페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list = dao.listDelete(cri);

		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("page_cnt", page_cnt);
	}

	@RequestMapping(value = "search/businessDeleteList2", method = RequestMethod.POST)
	public void businessDeleteList2(CriteriaB cri, Model model) {

		System.out.println("(Controller) business delete list2 요청");

		cri.setStartEnd(cri.getPage()); // 페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list2 = dao.listDelete(cri);

		model.addAttribute("list2", list2);
		model.addAttribute("cri", cri);
	}
	
	@RequestMapping(value = "search/businessRecover", method = RequestMethod.POST)
	public void businessRecover(String play_id, Model model) {
		System.out.println("(Controller) business recover 요청");
		System.out.println(play_id);
		PlayVO vo=new PlayVO();
		vo.setPlay_id(play_id);
		
		vo.setDelete_date(CurrentDate());
		System.out.println(vo);
		dao2.recover(vo);
	}
	
	@RequestMapping(value = "search/businessDeleteDetail", method = RequestMethod.POST)
	public void businessDeleteDetail(String play_id, Model model) {
		System.out.println("(Controller) business delete Detail 요청");
		System.out.println(play_id);
		PlayVO vo = dao2.playDeleteDetail(play_id);

		model.addAttribute("vo", vo);
	}
	

	// 현재 시간
	public String CurrentTime() {

		// 현재 시간
		LocalTime now = LocalTime.now();

		// 현재시간 출력
//		        System.out.println(now);  // 06:20:57.008731300

		// 포맷 정의하기
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("-HHmmss");

		// 포맷 적용하기
		String formatedNow = now.format(formatter);

		return formatedNow;
	}

	// 오늘 날짜
	public Date CurrentDate() {

		// 현재 날짜 구하기
		LocalDate now = LocalDate.now();

		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		// 포맷 적용
		String formatedNow = now.format(formatter);

		Date today = Date.valueOf(formatedNow);

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
}
