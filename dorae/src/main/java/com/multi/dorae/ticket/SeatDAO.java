package com.multi.dorae.ticket;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.multi.dorae.search.PlayVO;

@Component
public class SeatDAO {

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
		public int insert(SeatVO bag) {
			int result = my.insert("seat.insert", bag);
			return result;
		}
}
