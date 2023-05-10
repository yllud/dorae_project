package com.multi.dorae.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("admin")
@Controller
public class AdminController {
	
	@RequestMapping
	public String adminMain() {
		return "admin/admin";
	}
}
