package com.multi.dorae.ticket;

import java.util.HashMap;

public class time {

	public static void main(String[] args) {
		String play_time = "월요일 ~ 금요일(17:00,20:00), 토요일(13:00,16:00,19:00), 일요일(15:00,18:00)";
	      
        HashMap<String, String[]> schedule = new HashMap<String, String[]>();
        
        String[] play_time2 = play_time.split(", "); // (, )로 구분해서 배열로 만든다
        
        // 쉼표로 분리한 각 요일 데이터를 순회한다
        for (String dayData : play_time2) {
        	  
            // 요일과 해당하는 시간 데이터를 추출합니다.
            String[] parts = dayData.split("\\("); // ( 기준으로 다시 배열로 만든다
            //{월요일 ~ 금요일, 17:00,20:00)} {토요일, 13:00,16:00,19:00)} {일요일, 15:00,18:00)}
            
            String day = parts[0]; // 요일추출 >> 월요일 ~ 금요일, 토요일, 일요일
            String time = parts[1].replaceAll("\\)", ""); // ) 를 공백으로 변경
            String[] time2 = time.split(","); // times String을 배열로 만들어 준다
           
            schedule.put(day, time2);  // 요일과 시간 데이터를 schedule 맵에 넣는다
        }
        
        // schedule 맵을 순회하여 요일별 가능한 시간을 출력
        for (String day : schedule.keySet()) { // key 목록을 String으로 가져옴
            String[] times = schedule.get(day); // day의 value값(time2)을 배열로 가져온다
            System.out.print(day + ": "); // 날짜 출력
            
            for (int i = 0; i < times.length; i++) {
                System.out.print(times[i]);
                if (i != times.length - 1) {
                    System.out.print(", ");
                } //if (시간은 , 로 표시해서 구분)
            } //for
            System.out.println();
        } //for
    }

	}


