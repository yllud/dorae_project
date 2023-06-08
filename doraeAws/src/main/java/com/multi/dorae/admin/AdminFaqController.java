package com.multi.dorae.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@ResponseBody
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public ResponseMessage faqCreate(FaqVO faqVO) {
		ResponseMessage mes = new ResponseMessage();
		if (faqService.create(faqVO)) {
			mes.setSuccess(true);
			mes.setMessage(String.valueOf(faqVO.getFaq_id()));
		}
		return mes;
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public void faqUpdatePage(int faq_id, Model model) {
		model.addAttribute("helpCategoryList", categoryService.listByParentId("None"));
		model.addAttribute("faq_id", faq_id);
	}
	
	@ResponseBody
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public ResponseMessage faqUpdate(FaqVO faqVO) {
		ResponseMessage mes = new ResponseMessage();
		mes.setSuccess(faqService.update(faqVO));
		return mes;		
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
	public void faqList(String help_category_id, PageVO pageVO, Model model) {
		if (help_category_id == null) {
			model.addAttribute("faqList", faqService.listWithPaging(pageVO));
		} else {
			model.addAttribute("faqList", faqService.listByCategoryWithPaging(help_category_id, pageVO));			
		}
		model.addAttribute("page", pageVO);
		model.addAttribute("help_category_id", help_category_id);
	}

	@ResponseBody
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ResponseMessage faqDelete(int faq_id) {
		ResponseMessage mes = new ResponseMessage();
		mes.setSuccess(faqService.delete(faq_id));
		return mes;
	}
}
