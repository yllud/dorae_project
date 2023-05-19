package com.multi.dorae.admin;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.Base64;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.net.ssl.HttpsURLConnection;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.multi.dorae.help.ContactVO;

//@PropertySource("classpath:credentials.properties") // properties 경로
@Service
public class EmailSendService {

	// @Value("${accessKey}")
	String accessKey = "4F2BDC69826967D37B65";
	// @Value("${secretKey}")
	String secretKey = "DE6AAA53DEBADD68474D90821B631CB444D1E692";

	public void send(ContactVO vo) {
		try {
			EmailSendRequest esr = new EmailSendRequest(); // 이메일 요청 객체(템플릿용)
			esr.setTemplateSid(9347); // 이메일 템플릿 번호
			esr.addRecipient(new RecipientForRequest("tjdaks0804@naver.com", "허성만")); // 이메일 수신자 추가

			ObjectMapper om = new ObjectMapper();
			System.out.println(om.writeValueAsString(esr));

			URL url = new URL("https://mail.apigw.ntruss.com/api/v1/mails");
			HttpsURLConnection conns = (HttpsURLConnection) url.openConnection();
			conns.setRequestMethod("POST");
			conns.setRequestProperty("Content-Type", "application/json"); // header Content-Type 정보
			conns.setRequestProperty("x-ncp-apigw-timestamp", String.valueOf(System.currentTimeMillis())); // 현재 시간 밀리초
			conns.setRequestProperty("x-ncp-iam-access-key", accessKey); // accessKey
			conns.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature()); // 인증키 생성을 위한 signature
			conns.setRequestProperty("x-ncp-lang", "ko-KR");
			conns.setDoInput(true); // 서버에 전달할 값이 있다면 true
			conns.setDoOutput(true); // 서버로부터 받는 값이 있다면 true

			// 2023-05-13 : 요청 시 문자셋을 UTF-8 로 바꾸니 정상 응답 받음(Created)
			BufferedWriter bw = new BufferedWriter(
					new OutputStreamWriter(conns.getOutputStream(), Charset.forName("UTF-8")));
			bw.write(om.writeValueAsString(esr)); // 버퍼에 담기
			bw.flush(); // 버퍼에 담긴 데이터 전달
			bw.close();

			// 서버로부터 데이터 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conns.getInputStream()));
			StringBuilder sb = new StringBuilder();
			String line = null;
			System.out.println(conns.getResponseMessage());
			while ((line = br.readLine()) != null) { // 읽을 수 있을 때 까지 반복
				sb.append(line);
			}

			System.out.println(sb.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 인증키 생성을 위한 signature 생성
	public String makeSignature() throws Exception {
		String space = " "; // 공백
		String newLine = "\n"; // 줄바꿈
		String method = "POST"; // HTTP 메소드
		String url = "/api/v1/mails"; // 도메인을 제외한 "/" 아래 전체 url (쿼리스트링 포함)
		String timestamp = String.valueOf(System.currentTimeMillis()); // 현재 타임스탬프 (epoch, millisecond), 최대 오차 5분

		String message = new StringBuilder().append(method).append(space).append(url).append(newLine).append(timestamp)
				.append(newLine).append(accessKey).toString();

		SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
		Mac mac = Mac.getInstance("HmacSHA256");
		mac.init(signingKey);

		byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
		String encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);

		return encodeBase64String;

	}
}
