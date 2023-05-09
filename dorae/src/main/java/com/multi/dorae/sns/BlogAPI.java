package com.multi.dorae.sns;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class BlogAPI {

    public static ArrayList<BlogVO> searchNaverBlog(String query) {
        String clientId = "CKhVzHdMLVlxvZKdQevz"; // 네이버 개발자센터에서 발급받은 클라이언트 아이디값
        String clientSecret = "mNO5JmmmJs"; // 네이버 개발자센터에서 발급받은 클라이언트 시크릿값

        ArrayList<BlogVO> resultList = new ArrayList<BlogVO>();

        try {
            String text = URLEncoder.encode(query, "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/search/blog?query=" + text;
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);

            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            JSONParser parser = new JSONParser();
            JSONObject jsonObject = (JSONObject)parser.parse(response.toString());
            JSONArray jsonArray = (JSONArray)jsonObject.get("items");

            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject obj = (JSONObject)jsonArray.get(i);
                BlogVO blogVO = new BlogVO();
                blogVO.setTitle((String)obj.get("title"));
                blogVO.setLink((String)obj.get("link"));
                blogVO.setDescription((String)obj.get("description"));
                blogVO.setBloggername((String)obj.get("bloggername"));
                blogVO.setBloggerlink((String)obj.get("bloggerlink"));
                blogVO.setPostdate((String)obj.get("postdate"));
                resultList.add(blogVO);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return resultList;
    }
}
