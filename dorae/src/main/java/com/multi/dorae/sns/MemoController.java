package com.multi.dorae.sns;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller //싱글톤 + 컨트롤러 등록 
public class MemoController {

	@Autowired
	MemoDAO dao;
	
	@RequestMapping("list.memo")
	public void list(Model model) {
		List<MemoVO2> list = dao.list(); 
		System.out.println(list);
		model.addAttribute("list", list);
	}

	@RequestMapping("insert.memo") 
	public void insert(MemoVO2 vo) {
		System.out.println("test...");
		dao.insert(vo);
	}

	@RequestMapping("one.memo")
	public void one(String _id, Model model) {
		System.out.println("one.memo컨트롤러 >> " + _id);
		MemoVO2 vo = dao.one(_id);
		model.addAttribute("vo", vo);
	}

	@RequestMapping("update.memo")
	public String update(String _id, String content, Model model) {
		//400 error --> bad request error
		// _id 붙은 것은 바로 vo로 안들어가서 수동으로 넣어줘야함
		MemoVO2 vo = new MemoVO2();
		vo.set_id(_id);
		vo.setContent(content);
		dao.update(vo);
		System.out.println("update.memo 컨트롤러>> " + vo);
		return "redirect:/mongo_memo.jsp";
	}

	@RequestMapping("delete.memo")
	public String delete(String _id) {
		dao.delete(_id);
		return "redirect:/mongo_memo.jsp";
	}
}
