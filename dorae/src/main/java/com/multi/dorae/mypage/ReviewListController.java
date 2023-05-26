package com.multi.dorae.mypage;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.multi.dorae.mypage.ReviewListVO;


@Controller
public class ReviewListController {

	@Autowired
	HttpSession session;

	@Autowired
	ReviewListDAO dao;

	@RequestMapping("mypage/reviewList")
	public void reviewList(Model model) {
		System.out.println("replyList 요청됨");
	    String email = (String) session.getAttribute("email");
	    List<ReviewListVO> list = dao.listByEmail(email);
	    System.out.println(list.size());
	    //views아래 list를 전달 
	    model.addAttribute("list", list);
	    //그 다음에 무조건 views/mypage/replyList로 감.
	    //다른 곳으로 가고 싶을 때에는 return 사용!
	}
}
