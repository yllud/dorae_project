package com.multi.dorae.review;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component("reviewScheduler")
public class ReviewScheduler {
	
	@Autowired
	ReviewDAO dao;
	
	@Autowired
	private ServletContext servletContext;
	
	// 초 분 시 일 월 일
	@Scheduled(cron = "0 0 9 1 * *") // 매달 1일 오전9시
	public void auto() {
		List<String> deletedImgList = dao.deletedImg();
		String uploadPath = servletContext.getRealPath("/resources/upload");
		System.out.println("----------삭제할 경로 : " + uploadPath);
		for (String deletedImg : deletedImgList) {
		    String filePathString = uploadPath + "/" + deletedImg;
		    Path filePath = Paths.get(filePathString);
		    
		    try {
		        Files.delete(filePath);
		        System.out.println("-----삭제한 파일: " + deletedImg);
		    } catch (Exception e) {
		        System.out.println("-----삭제 실패한 파일: " + deletedImg);
		        e.printStackTrace();
		    }
		}
	}
}
