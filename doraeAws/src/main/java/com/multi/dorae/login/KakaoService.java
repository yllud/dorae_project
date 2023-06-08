package com.multi.dorae.login;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoService {

	@Autowired
	private KakaoDAO dao;
	
	public String getAccessToken (String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=7d82a34e6c4c00f0c8af6bad0d046044"); //본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8888/dorae/login/kakaoLogin"); // 본인이 설정한 주소
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}
    
	public ArrayList getUserInfo(String access_Token) {
		KakaoVO vo = new KakaoVO();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		int result = 0;
		String total = "";
		ArrayList list = new ArrayList();
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			while ((line = br.readLine()) != null) {
				total += line;
			}
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(total);
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			
			vo.setEmail(email);
			vo.setNickname(nickname);
			list.add(email);
		} catch (IOException e) {
			e.printStackTrace();
		}
		// catch 아래 코드 추가.
		
		System.out.println("userInfo" + vo);
//		KakaoVO result = dao.findkakao(userInfo);
		// 위 코드는 먼저 정보가 저장돼있는지 확인하는 코드.
		//System.out.println("S:" + result);
		//if(result==null) {
		// result가 null이면 정보가 저장이 안되있는거므로 정보를 저장.
			result = dao.insert(vo);
			list.add(result);
			// 위 코드가 정보를 저장하기 위해 Repository로 보내는 코드임.
			//return dao.findkakao(userInfo);
			return list;
			// 위 코드는 정보 저장 후 컨트롤러에 정보를 보내는 코드임.
			//  result를 리턴으로 보내면 null이 리턴되므로 위 코드를 사용.
//		} else {
//			return result;
//			// 정보가 이미 있기 때문에 result를 리턴함.
//		}
			       
	}
	
	public void setSessionAttributes(HttpSession session, KakaoVO vo) {
	    session.setAttribute("email", vo.getEmail());
	    session.setAttribute("nickname", vo.getNickname());
	    session.setAttribute("user_type", vo.getUser_type());
	    // 세션 유지 시간 설정 (옵션)
	    session.setMaxInactiveInterval(60 * 30); // 30분 동안 유지되도록 설정 (단위: 초)
	}
}