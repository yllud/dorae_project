package com.multi.dorae.ticket;

import java.util.HashMap;

public class time2 {
    public static void main(String[] args) {
        String playTime = "월요일 ~ 금요일(17:00,20:00), 토요일(13:00,16:00,19:00), 일요일(15:00,18:00)";
        
        HashMap<String, String> playTimeMap = parsePlayTime(playTime);

        // 사용 예시
        String tuesdayPlayTime = playTimeMap.get("토요일");
        System.out.println(tuesdayPlayTime);
    }

    private static HashMap<String, String> parsePlayTime(String playTime) {
        HashMap<String, String> playTimeMap = new HashMap<>();

        String[] timeSegments = playTime.split(", ");
        for (String segment : timeSegments) {
            String[] dayTime = segment.split("\\(");
            String dayPart = dayTime[0].trim();
            String[] days = extractDays(dayPart);
            String time = dayTime[1].replaceAll("[()]", "").trim();
            
            for (String day : days) {
                playTimeMap.put(day, time);
            }
        }

        return playTimeMap;
    }

    private static String[] extractDays(String dayPart) {
        String[] days;
        if (dayPart.contains("~")) {
            String[] range = dayPart.split(" ~ ");
            String startDay = range[0];
            String endDay = range[1];
            
            String[] allDays = {"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"};
            int startIndex = getIndex(allDays, startDay);
            int endIndex = getIndex(allDays, endDay);
            
            if (startIndex <= endIndex) {
                days = new String[endIndex - startIndex + 1];
                System.arraycopy(allDays, startIndex, days, 0, endIndex - startIndex + 1);
            } else {
                int firstPart = allDays.length - startIndex;
                int secondPart = endIndex + 1;
                days = new String[firstPart + secondPart];
                System.arraycopy(allDays, startIndex, days, 0, firstPart);
                System.arraycopy(allDays, 0, days, firstPart, secondPart);
            }
        } else {
            days = new String[] { dayPart };
        }
        return days;
    }

    private static int getIndex(String[] array, String value) {
        for (int i = 0; i < array.length; i++) {
            if (array[i].equals(value)) {
                return i;
            }
        }
        return -1;
    }
}

