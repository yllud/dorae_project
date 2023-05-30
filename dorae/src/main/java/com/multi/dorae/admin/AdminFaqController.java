package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String faqCreate(FaqVO faqVO) {
		faqService.create(faqVO);
		return "redirect:one?faq_id=" + faqVO.getFaq_id();
	}
	
//	@RequestMapping(value = "create", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
//	public String faqCreate(FaqVO vo) {
//		faqService.create(vo);
//		return "redirect:one?faq_id=" + vo.getFaq_id();
//	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public void faqUpdatePage(int faq_id, Model model) {
		model.addAttribute("helpCategoryList", categoryService.listByParentId("None"));
		model.addAttribute("faq_id", faq_id);
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String faqUpdate(FaqVO faqVO) {
		faqService.update(faqVO);
		return "redirect:one?faq_id=" + faqVO.getFaq_id();
	}
	
	@RequestMapping("one")
	public void faqOne(int faq_id, Model model) {
		model.addAttribute("helpCategoryList", categoryService.listByParentId("None"));
		model.addAttribute("faq", faqService.one(faq_id));
	}
	
	@ResponseBody
	@RequestMapping("one.json")
	public FaqVO noticeOneJson(int faq_id) {
		return faqService.one(faq_id);
	}
	
	@RequestMapping("list")
	public void faqList(String help_category_id, int page, Model model) {
		PageVO pageVO = new PageVO();
		pageVO.setPage(page);
		
		if (help_category_id == null) {
			model.addAttribute("faqList", faqService.listWithPaging(pageVO));
		} else {
			model.addAttribute("faqList", faqService.listByCategoryWithPaging(help_category_id, pageVO));			
		}
		model.addAttribute("page", pageVO);
		model.addAttribute("help_category_id", help_category_id);
	}
}
