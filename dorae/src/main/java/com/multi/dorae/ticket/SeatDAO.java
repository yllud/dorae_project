package com.multi.dorae.ticket;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.multi.dorae.login.KakaoVO;
import com.multi.dorae.login.MemberVO;
import com.multi.dorae.login.NaverVO;
import com.multi.dorae.search.PlayVO;

@Component
public class SeatDAO  {

	@Autowired
	SqlSessionTemplate my;
	
	  // 공연 id로 공연 한개 검색(예매페이지)
		public PlayVO one(String play_id) {
			PlayVO vo = my.selectOne("play.one", play_id);
			return vo;
		}
		
		
		public PlayVO one2(String play_id) {
			PlayVO vo = my.selectOne("play.one", play_id);
			return vo;
		}
		
		// 결제 시 좌석 정보 저장
		public int  insert(SeatVO seatvo) {
	        int result = my.insert("seat.insert", seatvo);
	        return result;
		}
		
		// 다음버튼 눌렀을 때 네이버 회원정보 가져오기
		public NaverVO naverMember(String email) {
			NaverVO naverMember = my.selectOne("naverMember.naverFind", email);
			System.out.println(naverMember);
			return naverMember;
		}
		
		// 다음버튼 눌렀을 때 카카오 회원정보 가져오기
		public KakaoVO kakaoMember(String email) {
			KakaoVO kakaoMember = my.selectOne("kakaoMember.kakaoFind", email);
			System.out.println(kakaoMember);
			return kakaoMember;
		}
		
		// 다음버튼 눌렀을 때 자체 회원정보 가져오기
		public MemberVO member(String email) {
			MemberVO member = my.selectOne("member.find", email);
			System.out.println(member);
			return member;
		}
		
		// 좌석선택 누르면 select
		public List<String> list(Map<String, Object> params) {
		    List<String> list = my.selectList("seat.select", params);
		    System.out.println(list);
		    return list;
		}
		
		
}
