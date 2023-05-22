package com.multi.dorae.ticket;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class time {
	
	int start;
	int end;
	
	public static void main(String[] args) {
		
		String input="화요일 ~ 금요일(19:30), 토요일 ~ 일요일(14:10,19:00)";
		String input2[] =input.split(", ");
		ArrayList<String> resultList = new ArrayList<>();
	
		for (int i = 0; i < input2.length; i++) {
			if (input2[i].contains("~")) {
				String a=input2[i].substring(0,3); //월요일
				String b=input2[i].substring(6,9); //금요일
				String time=input2[i].substring(9); //(17:00,20:00)
				System.out.println(a);
				System.out.println(b);
				System.out.println(time);
				
				Map<Integer, String> map = new HashMap<>();
				map.put(1,"월요일");
				map.put(2,"화요일");
				map.put(3,"수요일");
				map.put(4,"목요일");
				map.put(5,"금요일");
				map.put(6,"토요일");
				map.put(7,"일요일");
				
				time t= new time();
				map.forEach((key, value) -> {
		            if(value.equals(a)) {
		            	t.start=key;
		            }
		            if(value.equals(b)) {
		            	t.end=key;
		            }
		        }); //foreach
	
				for(int j=t.start;j<t.end+1;j++) { //리스트에 넣어주기
					//System.out.println((String) map.get(j)+time);
					resultList.add((String) map.get(j) + time);
					//System.out.println(result);
				} //for
			} else {
				resultList.add((String) input2[i]);
			} //else
		} //for
		System.out.println(resultList);
	
        Map<String, List<String>> scheduleMap = new HashMap<>();

        for (String entry : resultList) {
            String[] parts = entry.split("\\("); // ( 기준으로 배열을 만들고 
            String day = parts[0]; // 배열 0번쨰를 요일로 저장
            String[] times = parts[1].replaceAll("\\)", "").split(","); // parts[1] = 시간은 )를 공백으로 바꾸고 , 기준으로 배열을 만든다
            scheduleMap.put(day, Arrays.asList(times)); //키에는 요일, 값에는 시간을 넣는다
        }

        for (Map.Entry<String, List<String>> entry : scheduleMap.entrySet()) {
            String day = entry.getKey();
            List<String> times = entry.getValue();

            System.out.println(day + " = " + times);
        }
	} //main
} //time3


