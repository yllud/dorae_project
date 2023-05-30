package com.multi.dorae.search;

import java.io.IOException;
import java.sql.SQLException;

import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.xml.sax.SAXException;

import com.multi.dorae.api.ApiParsing;



@Component("scheduler")
public class Scheduler {

	@Autowired
	ApiParsing service;
	
	//초 분 시 일 월 일 
	@Scheduled(cron = "00 01 00 * * *")
	public void auto() throws ClassNotFoundException, IOException, ParserConfigurationException, SAXException, SQLException {
		System.out.println("오후 10:41에 매일 호출됨...");
		
		//play 공연 상태 업데이트(공연 시작,종료날짜 오늘과 비교)
		service.dbUpdate();
		service.deleteRank();
		service.apiPlay();
		service.apiStage();
		service.apiRank();

	}
	
	
	
}
