package com.multi.dorae.search;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.multi.dorae.mypage.ReplyVO;

@Controller
public class PlayController {

	@Autowired
	PlayDAO dao;

	@Autowired
	StageDAO dao2;

	@Autowired
	RankDAO dao3;

	@RequestMapping("search/playList")
	public void playList(Criteria cri, Model model) {

		System.out.println("(Controller) play list 요청");

		int count = dao.count(cri); // 리스트 개수
		System.out.println("list count>> " + count);
		int page_cnt = cri.makePageBtn(count); // 페이지 버튼 개수
		System.out.println("page count>> " + page_cnt);

		cri.setStartEnd(cri.getPage()); // 페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list = dao.list(cri);

		List<RankVO> list2 = dao3.rankList(cri);

		String genre_name = cri.getGenre();

		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("list2", list2);
		model.addAttribute("page_cnt", page_cnt);
		model.addAttribute("genre_name", genre_name);
	}

	@RequestMapping("search/playList2")
	public void playList2(Criteria cri, Model model) {

		System.out.println("(Controller) play list2 요청");

		int count = dao.count(cri); // 리스트 개수
		System.out.println("all count>> " + count);

		int page_cnt = cri.makePageBtn(count); // 페이지 버튼 개수
		System.out.println("page count>> " + page_cnt);

		cri.setStartEnd(cri.getPage()); // 페이지 번호로 시작번호 끝번호 설정
		System.out.println(cri);
		List<PlayVO> list = dao.list(cri);

		List<RankVO> list2 = dao3.rankList(cri);

		String genre_name = cri.getGenre();

		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("list2", list2);
		model.addAttribute("page_cnt2", page_cnt);
		model.addAttribute("genre_name", genre_name);
	}

	@RequestMapping("search/playDetail")
	public void playDetail(String play_id, Model model) {
		System.out.println("(Controller) playDetail 요청");
		System.out.println(play_id);
		PlayVO vo = dao.playDetail(play_id);
		String stage_id = dao.stageId(play_id);
		
		System.out.println("30일 뒤 날짜:"+ReserveDate());
		
		//30일 이내에 공연이 있으면 예매버튼 활성화
		int a=0;
		int comparison = vo.getPlay_end().compareTo(ReserveDate());
		if (vo.getState().equals("공연완료")) {
			a=0;
		}
		else if(comparison<=0) {
			a=1;
		}

		StageVO vo2 = dao2.stageDetail(stage_id);
		String score= dao.ReviewScore(play_id);
		List<ReplyVO> listReview = dao.ReviewList(play_id);
		
		
		model.addAttribute("vo", vo);
		model.addAttribute("vo2", vo2);
		model.addAttribute("listReview", listReview);
		model.addAttribute("a", a);
		model.addAttribute("score", score);
	}

	// 오늘 날짜
	public Date ReserveDate() {

		// api 날짜 요청 변수 설정
		Date currentDate = new Date(System.currentTimeMillis());

		// 60일 후의 날짜 계산
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(currentDate);
		calendar.add(Calendar.DAY_OF_MONTH, 30);
		Date futureDate = new Date(calendar.getTimeInMillis());

		return futureDate;
	}

}