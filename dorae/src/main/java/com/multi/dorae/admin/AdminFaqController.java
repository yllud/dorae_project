package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.multi.dorae.help.FaqService;
import com.multi.dorae.help.FaqVO;
import com.multi.dorae.help.HelpCategoryService;
import com.multi.dorae.help.PageVO;

@RequestMapping("admin/faq")
@Controller
public class AdminFaqController {

	@Autowired
	FaqService faqService;
	@Autowired
	HelpCategoryService categoryService;
	
	@RequestMapping(value = "create", method = RequestMethod.GET)
	public void faqCreatePage(Model model) {
		model.addAttribute("helpCategoryList", categoryService.listByParentId("None"));
	}
	
	@RequestMapping(value = "create", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String faqCreate(FaqVO vo) {
		faqService.create(vo);
		return "redirect:one?faq_id=" + vo.getFaq_id();
	}
	
//	@RequestMapping(value = "create", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
//	public String faqCreate(FaqVO vo) {
//		faqService.create(vo);
//		return "redirect:one?faq_id=" + vo.getFaq_id();
//	}
	
	@RequestMapping(value = "contentTextarea", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String faqUpdate(FaqVO vo) {
		faqService.updateContent(vo);
		return "redirect:one?faq_id=" + vo.getFaq_id();
	}
	
	@RequestMapping("one")
	public void faqOne(int faq_id, Model model) {
		model.addAttribute("faq", faqService.one(faq_id));
	}
	
	@RequestMapping("list")
	public void faqList(String help_category_id, PageVO pageVO, Model model) {
		pageVO.setTotal(faqService.countByCategory(help_category_id));
		pageVO.calc();

		model.addAttribute("page", pageVO);
		model.addAttribute("faqList", faqService.listByCategoryWithPaging(help_category_id, pageVO));
		model.addAttribute("help_category_id", help_category_id);
	}
}
