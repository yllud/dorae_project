package com.multi.dorae.search;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component("scheduler")
public class Scheduler {

	//초 분 시 일 월 일 
	@Scheduled(cron = "00 43 10 * * *")
	public void auto() {
		System.out.println("오후 10:41에 매일 호출됨...");
	}
}
