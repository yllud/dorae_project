package com.multi.dorae.api;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.multi.dorae.search.PlayDAO;
import com.multi.dorae.search.PlayVO;
import com.multi.dorae.search.RankDAO;
import com.multi.dorae.search.RankVO;
import com.multi.dorae.search.StageDAO;
import com.multi.dorae.search.StageVO;

@Service
public class ApiParsing {

	// 싱글톤으로 만든 dao 찾기
	@Autowired
	PlayDAO dao;

	@Autowired
	StageDAO dao2;

	@Autowired
	RankDAO dao3;
	
	// xml에서 태그 값을 읽어오는 함수
	private static String getTagValue(String tag, Element eElement) {
		Node nValue = null;

		NodeList x = eElement.getElementsByTagName(tag);
		Node test = x.item(0);
		NodeList t = null;
		if (test != null) {
			t = test.getChildNodes();
			if ((Node) t.item(0) != null) {
				nValue = (Node) t.item(0);
			}
		}
		if (nValue == null)
			return null;
		return nValue.getNodeValue();
	}

	// API 파싱(play 테이블 추가)
	// "공연" db를 불러와서 공연id만 뽑은 후
	// 그 id 리스트를 "공연상세"의 요청변수에 삽입해 공연상세목록을 불러오기
	public void apiPlay()
			throws IOException, ParserConfigurationException, SAXException, ClassNotFoundException, SQLException {
		// 공연 id 목록을 저장할 리스트 생성
		List<String> idList = new ArrayList<String>();

		// 공연, 축제 api
		String[] kind = { "pblprfr", "prfawad" };
		// 지역 코드
		String[] listSi = { "11", "26", "27", "28", "29", "30", "31", "40", "41", "42", "43", "44", "45", "46", "47",
				"48", "50" };
//		};
		// 지역별로 몇개 추가됐는지 확인
		int[] list_cnt = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

		for (int a = 0; a < 2; a++) {
			for (int i = 0; i < listSi.length; i++) {

				// 20200601~20230601까지 공연중
				// listSi[i]시or도
				// 공연 데이터 중 500개까지 불러옴
				String parsingUrl = "http://www.kopis.or.kr/openApi/restful/" + kind[a]
						+ "?service=e2622608ee6c4fa2a38d5f75a26a7e50"
						+ "&stdate=20200601&eddate=20230601&cpage=1&rows=500&prfstate=02&signgucode=" + listSi[i];

				System.out.println(parsingUrl);

				// 1. 빌더 팩토리 생성.
				DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();

				// 2. 빌더 팩토리로부터 빌더 생성
				DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

				// 3. 빌더를 통해 XML 문서를 파싱해서 Document 객체로 가져온다.
				Document doc = dBuilder.parse(parsingUrl);

				// 문서 구조 안정화
				doc.getDocumentElement().normalize();

				// XML 데이터 중 <db> 태그의 내용을 가져온다.
				NodeList nList = doc.getElementsByTagName("db");
				System.out.println("length: " + nList.getLength());
				list_cnt[i] += nList.getLength();
				// api의 공연id 목록을 idList에 넣어줌
				for (int k = 0; k < nList.getLength(); k++) {
					Node nNode = nList.item(k);
					if (nNode.getNodeType() == Node.ELEMENT_NODE) {
						Element eElement = (Element) nNode;
						idList.add(getTagValue("mt20id", eElement));
						System.out.println(getTagValue("mt20id", eElement));
					}
				}
			}
		}
		// idList.add("PF148232");

		for (String id : idList) {
			String parsingUrl2 = "http://www.kopis.or.kr/openApi/restful/pblprfr/" + id
					+ "?service=e2622608ee6c4fa2a38d5f75a26a7e50";
			System.out.println(parsingUrl2);

			// playVO 사용
			PlayVO bag = new PlayVO();

			// 1. 빌더 팩토리 생성.
			DocumentBuilderFactory dbFactory2 = DocumentBuilderFactory.newInstance();

			// 2. 빌더 팩토리로부터 빌더 생성
			DocumentBuilder dBuilder2 = dbFactory2.newDocumentBuilder();

			// 3. 빌더를 통해 XML 문서를 파싱해서 Document 객체로 가져온다.
			Document doc2 = dBuilder2.parse(parsingUrl2);

			// 문서 구조 안정화
			doc2.getDocumentElement().normalize();

			// XML 데이터 중 <db> 태그의 내용을 가져온다.
			NodeList nList2 = doc2.getElementsByTagName("db");
			System.out.println("length: " + nList2.getLength());
			int result = 0;
			for (int i = 0; i < nList2.getLength(); i++) {

				Node nNode = nList2.item(i);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;

					String playId = getTagValue("mt20id", eElement);
					bag.setPlay_id(playId);
					bag.setStage_id(getTagValue("mt10id", eElement));
					bag.setPlay_name(getTagValue("prfnm", eElement));
					bag.setPlay_start(transformDate(getTagValue("prfpdfrom", eElement)));
					bag.setPlay_end(transformDate(getTagValue("prfpdto", eElement)));
					bag.setStage_name(getTagValue("fcltynm", eElement));
					bag.setCasting(getTagValue("prfcast", eElement));
					bag.setCrew(getTagValue("prfcrew", eElement));
					bag.setRuntime(getTagValue("prfruntime", eElement));
					bag.setPlay_age(getTagValue("prfage", eElement));
					bag.setEnterprise(getTagValue("entrpsnm", eElement));
					bag.setPrice(getTagValue("pcseguidance", eElement));
					bag.setPoster(getTagValue("poster", eElement));
					bag.setContent(getTagValue("sty", eElement));
					bag.setGenre_name(getTagValue("genrenm", eElement));
					bag.setState(getTagValue("prfstate", eElement));
					bag.setOpenrun(getTagValue("openrun", eElement));
					bag.setImage(getTagValue("styurl", eElement));
					bag.setPlay_time(getTagValue("dtguidance", eElement));

					if (playId != null) {
						try {
							System.out.println(getTagValue("prfnm", eElement));
							result = dao.insert(bag);

						} catch (Exception e) {
							System.out.println(e.toString());
						}
					}
				}
			}

			System.out.println("처리 개수" + nList2.getLength());
			if (result > 0) {
				System.out.println("db 추가 성공");
			} else {
				System.out.println("db 추가 실패");
			}
		}
		for (int i = 0; i < list_cnt.length; i++) {
			System.out.println("지역코드 " + listSi[i] + ": " + list_cnt[i]);
		}
	}

	// API 파싱해서 DB에 placeDetail 테이블 추가
	public void apiStage()
			throws IOException, ParserConfigurationException, SAXException, ClassNotFoundException, SQLException {

		// api url에 붙여줄 stage_id 리스트를 play 테이블에서 불러온다(공연에 있는 공연장만 불러옴, 전부 x)
		List<String> stageList = new ArrayList<String>();
		System.out.println("stage 요청1" + dao);
		try {
			stageList = dao.listStageId();

		} catch (Exception e) {
			System.out.println(e);
		}
		System.out.println("stage 요청2");

		// stage 아이디 List에 잘 들어갔는지 확인
		if (stageList != null) {
			try {
				for (String id : stageList) {
					System.out.println(id);
				}
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}

		for (String id : stageList) {
			String parsingUrl = "http://www.kopis.or.kr/openApi/restful/prfplc/" + id
					+ "?service=e2622608ee6c4fa2a38d5f75a26a7e50";
			// String
			// parsingUrl="http://www.kopis.or.kr/openApi/restful/prfplc/FC001247?service=e2622608ee6c4fa2a38d5f75a26a7e50";
			System.out.println(parsingUrl);
			// stageVO 사용
			StageVO bag = new StageVO();

			// 1. 빌더 팩토리 생성.
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();

			// 2. 빌더 팩토리로부터 빌더 생성
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

			// 3. 빌더를 통해 XML 문서를 파싱해서 Document 객체로 가져온다.
			Document doc = dBuilder.parse(parsingUrl);

			// 문서 구조 안정화
			doc.getDocumentElement().normalize();

			// XML 데이터 중 <db> 태그의 내용을 가져온다.
			NodeList nList = doc.getElementsByTagName("db");
			System.out.println("length: " + nList.getLength());
			int result = 0;
			for (int i = 0; i < nList.getLength(); i++) {

				Node nNode = nList.item(i);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;

					String placeId = getTagValue("mt10id", eElement);
					bag.setStage_id(placeId);
					bag.setStage_name(getTagValue("fcltynm", eElement));
					bag.setStage_cnt(getTagValue("mt13cnt", eElement));
					bag.setKind(getTagValue("fcltychartr", eElement));
					bag.setOpen_year(getTagValue("opende", eElement));
					bag.setSeat_cnt(getTagValue("seatscale", eElement));
					bag.setTel(getTagValue("telno", eElement));
					bag.setWebsite(getTagValue("relateurl", eElement));
					bag.setAddress(getTagValue("adres", eElement));
					bag.setLatitude(getTagValue("la", eElement));
					bag.setLongitude(getTagValue("lo", eElement));

					System.out.println(bag);
					if (placeId != null) {
						try {
							// System.out.println("placeid가 있어!");
							result = dao2.insert(bag);

						} catch (Exception e) {
							System.out.println(e.toString());
						}
					}
				}
			}

			System.out.println("처리 개수" + nList.getLength());
			if (result > 0) {
				System.out.println("db 추가 성공");
			} else {
				System.out.println("db 추가 실패");
			}
		}
	}

	public void apiRank()
			throws IOException, ParserConfigurationException, SAXException, ClassNotFoundException, SQLException {
		// 공연 id 목록을 저장할 리스트 생성
		List<String> idList = new ArrayList<String>();

		// 장르 구분
		String[] listGenre = { "AAAA", "GGGA", "CCCA", "CCCC", "CCCD", "BBBC", "BBBR", "EEEB", "EEEA" };
//		, "KID", "OPEN"}
		// 지역 코드
		String[] listSi = { "11", "26", "27", "28", "29", "30", "31", "40", "41", "42", "43", "44", "45", "46", "47",
				"48", "50", "UNI" };
//		};
		// 장르별로 몇개 추가됐는지 확인
		int[] list_cnt = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

		for (int i = 0; i < listGenre.length; i++) {
			//서울만
			for (int j = 0; j < 1; j++) {

				// 20200601~20230601까지 공연중
				// listSi[i]시or도
				// 공연 데이터 중 500개까지 불러옴
				String parsingUrl = "http://kopis.or.kr/openApi/restful/boxoffice?service=e2622608ee6c4fa2a38d5f75a26a7e50"
						+ "&ststype=day&date=20230516&catecode=" + listGenre[i] + "&area=" + listSi[j];

				System.out.println(parsingUrl);

				// 1. 빌더 팩토리 생성.
				DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();

				// 2. 빌더 팩토리로부터 빌더 생성
				DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

				// 3. 빌더를 통해 XML 문서를 파싱해서 Document 객체로 가져온다.
				Document doc = dBuilder.parse(parsingUrl);

				// 문서 구조 안정화
				doc.getDocumentElement().normalize();

				// XML 데이터 중 <boxof> 태그의 내용을 가져온다.
				NodeList nList = doc.getElementsByTagName("boxof");
				System.out.println("length: " + nList.getLength());
				//list_cnt[j] += nList.getLength();

				// rankVO 사용
				RankVO bag = new RankVO();
				int result = 0;

				// api의 공연id 목록을 idList에 넣어줌
				for (int k = 0; k < nList.getLength(); k++) {
					Node nNode = nList.item(k);
					if (nNode.getNodeType() == Node.ELEMENT_NODE) {
						Element eElement = (Element) nNode;

						String playId = getTagValue("mt20id", eElement);
						bag.setPlay_id(playId);
						bag.setRank_genre(getTagValue("cate", eElement));
						bag.setRank_area(getTagValue("area", eElement));
						bag.setRank_date(getTagValue("basedate", eElement));
						bag.setRanking(getTagValue("rnum", eElement));
						

						if (playId != null) {
							try {
								System.out.println(getTagValue("prfnm", eElement));
								result = dao3.insert(bag);

							} catch (Exception e) {
								System.out.println(e.toString());
							}
						}
					}
				}

				System.out.println("처리 개수" + nList.getLength());
				if (result > 0) {
					System.out.println("db 추가 성공");
				} else {
					System.out.println("db 추가 실패");
				}
			}

		}

//		for (int i = 0; i < list_cnt.length; i++) {
//			System.out.println("지역코드 " + listSi[i] + ": " + list_cnt[i]);
//		}
	}
	
	public void dbUpdate()
			throws IOException, ParserConfigurationException, SAXException, ClassNotFoundException, SQLException {
		// 공연 id 목록을 저장할 리스트 생성
		List<PlayVO> list=dao.listPlayDate();
		Date today = CurrentDate();
		for(PlayVO vo:list) {
			vo.setState(playState(vo.getPlay_start(), vo.getPlay_end(), today));
			System.out.println("공연 상태 넣기 후>> " + vo);
			dao.updateState(vo);
		}
	}

	// 날짜가 yyyymmdd 형식으로 입력되었을 경우 Date로 변경
	public static Date transformDate(String date) {
		SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyy.mm.dd");

		// Date로 변경하기 위해서는 날짜 형식을 yyyy-mm-dd로 변경해야 한다.
		SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm-dd");

		java.util.Date tempDate = null;

		try {
			// 현재 yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만든다.
			tempDate = beforeFormat.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// java.util.Date를 yyyy-mm-dd 형식으로 변경하여 String로 반환한다.
		String transDate = afterFormat.format(tempDate);

		// 반환된 String 값을 Date로 변경한다.
		Date d = Date.valueOf(transDate);

		return d;
	}
	
	public Date CurrentDate() {

		// 현재 날짜 구하기
		LocalDate now = LocalDate.now();

		// 포맷 정의
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		// 포맷 적용
		String formatedNow = now.format(formatter);

		Date today = Date.valueOf(formatedNow);

		return today;
	}
	
	public String playState(Date start, Date end, Date now) {

		int s = start.compareTo(now);
		int e = end.compareTo(now);
		if (e < 0) {
			return "공연완료";
		} else if (s <= 0) {
			return "공연중";
		} else {
			return "공연예정";
		}
	}

//	public static void main(String[] args) throws IOException, ParserConfigurationException, SAXException, SQLException, ClassNotFoundException
//	{
//		System.out.println("시작");
//
//		apiPlay();
//		// apiPlayDetail();
//		// apiPlace();
//
//	}
}
