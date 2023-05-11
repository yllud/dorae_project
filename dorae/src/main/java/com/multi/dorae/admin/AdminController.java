package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.dorae.help.ContactDAO;
import com.multi.dorae.help.ContactService;
import com.multi.dorae.help.ContactVO;
import com.multi.dorae.help.FaqDAO;
import com.multi.dorae.help.FaqService;
import com.multi.dorae.help.FaqVO;
import com.multi.dorae.help.HelpCategoryService;
import com.multi.dorae.help.HelpCategoryVO;
import com.multi.dorae.help.NoticeDAO;
import com.multi.dorae.help.NoticeService;
import com.multi.dorae.help.NoticeVO;

@RequestMapping("admin")
@Controller
public class AdminController {
	
	@Autowired
	HelpCategoryService helpCategoryService;
	
	@RequestMapping
	public String adminMain() {
		return "admin/admin";
	}
	
	@ResponseBody
	@RequestMapping(value = "hcNameUpdate", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String hcNameUpdateBtn(HelpCategoryVO vo) {
		if (helpCategoryService.updateName(vo) == 1) {
			return "유형 이름 수정 성공";
		} else {
			return "유형 이름 수정 실패";
		}
	}
}
