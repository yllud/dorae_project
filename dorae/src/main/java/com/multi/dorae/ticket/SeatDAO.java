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
			System.out.println(play_id);
			PlayVO vo = my.selectOne("play.one", play_id);

			return vo;

		}
}
