
	$('#payment').click(function() {
		var IMP = window.IMP; // 생략가능
		IMP.init('imp60843063'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		IMP.request_pay({//******* API : 함수를 불러서 처리해 달라고 할 때 사용하는 함수의 집합
			pg : 'kakaopay', // version 1.1.0부터 지원.
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '결제테스트',
			amount : $("#total").text(),
			buyer_name : $("#name").val(),
			buyer_tel : $("#tel").val(),
			buyer_email : $("#email").val(),
			m_redirect_url : 'www.yourdomain.com/payments/complete'
		}, function(rsp) {
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
			      alert(msg);
			      location.href = "ticket.jsp" 
			      $.ajax({
			    	  url: "insert",
			    	  data: {
			    		 imp_uid: rsp.imp_uid, //결제고유번호
			    		 merchant_uid: rsp.merchant_uid, //주문번호
			    		 apply_num: rsp.apply_num, //결제카드번호
			    		 paid_amount: rsp.paid_amount, //결제금액
			    		 pay_member: ahryee, //회원ID
			    		 buyer_name: rsp.buyer_name, //주문자 이름
			    		 buyer_tel: rsp.buyer_tel, //주문자 전화번호
			    		 buyer_email: rsp.buyer_email, //주문자 이메일
			    		 play_id: '${vo.play_id}', //공연ID
			    		 booking: 'today',//예매일
			    		 seat_id: 20230518001//티켓번호
			    		 
			    	  },
			    	  success: function(){
			    		  
			    	  }//success
			      })//ajax - insert
			      $.ajax({
			    	  url: "insert2",
			    	  data: {
			    		  seat_member: ahryee, //회원ID
			    		  play_id: '${vo.play_id}', //공연ID
			    		  seat_date: 20230518001, //공연날짜
			    		  seat_time: 20230518001, //공연시간
			    		  seat_number: 20230518001, //좌석번호
			    		  seat_id: 20230518001//티켓번호(pk)
			    	  },
			    	  success: function() {
						
					} //success
			      }) //ajax - insert2
			      
			    } else {
			      var msg = '결제에 실패하였습니다.';
			      msg += '에러내용 : ' + rsp.error_msg;
			      alert(msg);
			    } //else
			  });
	})//click
