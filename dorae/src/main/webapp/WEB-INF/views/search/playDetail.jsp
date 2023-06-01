<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/playDetail.css">
<link rel="stylesheet" href="/dorae/resources/css/bootstrap.min.css">


<title>Insert title here</title>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$("#header").load("../header/header.jsp");
		
		$.ajax({
				url : "playDetailBookCheck",
				data : {
					play_id : $('#play_id').val(),
					email : $('#email_id').val()
				},
				success : function(x) {
// 					alert('북마크 체크 성공')
					$('.bookIcon').attr('src',x);
					
				},//success
				error : function() {
					alert('북마크 체크 실패')
				}//error
			})//ajax
		
		$('#btnBook').click(function() {
			
			var emailId = $('#email_id').val(); // #email_id의 값 가져오기

		    if (emailId=== "null") {
		        // #email_id가 null인 경우
		        alert('로그인해주세요');
		    } 
		    else {
			
			var heartSrc = $('.bookIcon').attr('src');
			if (heartSrc === '../resources/img/heart_empty.png') {
		    $.ajax({
				url : "playDetailBookInsert",
				data : {
					play_id : $('#play_id').val(),
					email : $('#email_id').val()
				},
				success : function(x) {
					$('.bookIcon').attr('src', '../resources/img/heart_fill.png');
					
					// 버튼 요소의 텍스트를 가져옵니다.
				    var buttonText = $('.bookCount').text();

				    // 텍스트를 정수로 변환하고 1을 더합니다.
				    var newCount = parseInt(buttonText) + 1;

				    // 변환된 값을 다시 버튼에 설정합니다.
				    $('.bookCount').text(newCount);
					
				},//success
				error : function() {
					alert('북마크 추가 실패')
				}//error
			})//ajax
		
			}
			else{
				$.ajax({
					url : "playDetailBookDelete",
					data : {
						play_id : $('#play_id').val(),
						email : $('#email_id').val()
					},
					success : function(x) {
						$('.bookIcon').attr('src', '../resources/img/heart_empty.png');
						
						// 버튼 요소의 텍스트를 가져옵니다.
					    var buttonText = $('.bookCount').text();

					    // 텍스트를 정수로 변환하고 1을 더합니다.
					    var newCount = parseInt(buttonText) - 1;

					    // 변환된 값을 다시 버튼에 설정합니다.
					    $('.bookCount').text(newCount);
						
					},//success
					error : function() {
						alert('북마크 삭제 실패')
					}//error
				})//ajax
				
			}
}
			
		});
		
		
		
	})//$
	
	$(window).on('load', function() {
		function snsPopup(playName, stageName) {
			console.log("값넘겨주기!!! >>> " + playName + ", " + stageName);
			var url = "../map/sns_share.jsp?playName=" + encodeURIComponent(playName) + "&stageName=" + encodeURIComponent(stageName);
			//var url = "sns_share.jsp?playName=" + encodeURIComponent(playName) + "&stageName=" + encodeURIComponent(stageName)  + "&latitude=" + encodeURIComponent(share_lat)  + "&longitude=" + encodeURIComponent(share_lng);
		    window.open(url, "_blank", "width=500,height=500");
		}
		//공유 아이콘 클릭 이벤트
// 		$('#infoList').on('click', '.shareIcon', function() {
		$('#btnShare').click(function() {
		    var playName = $('#play_id').val();
		    var stageName = $('#stage_id').val();

		    snsPopup(playName, stageName);
		});
	
	})//$
	
	function openPopup(x) {
		window.open("../seat/one?play_id="+x, "_blank", "width=1050,height=670");
	}

</script>


</head>
<body>

	<header id="header" class="fixed-top"></header>
<!-- 	<div class="body"> -->


		<div class="container">
			<input id="email_id" type="hidden"
				value="<%=session.getAttribute("email")%>">
			<div class="left-items">

				<c:if test="${a == 1}">
					<img src="${vo.poster}" class="poster">
					<button class="reserve" onclick="openPopup('${vo.play_id}')">예매</button>
				</c:if>

			</div>

			<div class="right-items">
				<div id="infoList" class="right-text">
					#${vo.genre_name} #${vo2.stage_name} <br>
					<h1>${vo.play_name}</h1>
					<button id="btnBook" class="btn-book-share">
						<img class='bookIcon' src=""><span
							class="bookCount">${book_cnt}</span>
					</button>
					<button id="btnShare" class="btn-book-share">
						<img class='shareIcon' src='../resources/img/share.png'>공유
					</button>
				</div>
				<div class="right-grade">
					<p style="font-weight: 300; color: #888888;">평점</p>
					<h3>${score_sum}</h3>
				</div>
			</div>
		</div>



		<div class="container2">
			<div class="left-items2">
				<div class="left-text2">
					<input id="play_id" type="hidden" value="${vo.play_id}">
					<h1 class="detail1">${vo.play_name}</h1>
					<h4 class="detail">#${vo.state}</h4>
					<div class="detail">장르 : ${vo.genre_name} / ${vo.runtime}</div>
					<div class="detail">출연 : ${vo.casting}</div>
					<div class="detail">장소 : ${vo2.stage_name}</div>
					<%-- 					<div>런타임: ${vo.runtime}</div> --%>
					<div class="detail">가격 : ${vo.price}</div>
					<div class="detail">기간 : ${vo.play_start} ~ ${vo.play_end}</div>
					<div class="detail">시간 : ${vo.play_time}</div>
					<div class="detail">등급 : ${vo.play_age}</div>
					<div class="detail">오픈런 : ${vo.openrun}</div>
					<div class="detail">
						내용:
						<div class="content-scroll">${vo.content}</div>
					</div>
				</div>
			</div>
			<div class="right-items2">
				<!-- 				<h3>공연장 정보</h3> -->
				<!-- 공연장 위치 -->
				<div id="map" class="map"></div>
				<p class="map-stage">${vo2.stage_name}</p>
				<div class="map-scroll">
					<div class="map-detail">좌석: ${vo2.seat_cnt}석</div>
					<div class="map-detail">주소: ${vo2.address}</div>
					<div class="map-detail">번호: ${vo2.tel}</div>
					<div class="map-detail">
						싸이트: <a href="${vo2.website}">${vo2.website}</a>
					</div>
				</div>
			</div>
		</div>

		<div class="container3">
			<div class="review-items">
				<div class="review-text">
					<h3 class="review-title">Review</h3>
					<c:if test="${empty listReview}">
						<h5 class="review-title">리뷰가 아직 없습니다.</h5>
					</c:if>
				</div>
				<div id="review-scroll" class="table-responsive">
					<table class="table table-striped table-hover aling-middle">
						<tbody>
							<c:forEach items="${listReview}" var="bag">

								<tr>
									<!-- el 속성만 받아올 수 있는 표현식 -->
									<td><div class="review-td">${bag.nickname}</div></td>
									<td><div class="review-td">
											<div class="star-ratings">
												<div class="star-ratings-fill space-x-2 text-lg"
													style="width: ${(bag.score * 10)}%">
													<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
												</div>
												<div class="star-ratings-base space-x-2 text-lg">
													<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
												</div>
											</div><div class="score_one">${bag.score}</div></div></td>
									<td><div class="review-td">${bag.text}</div></td>
									<td><div class="review-td">${bag.upload_date2}</div></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>


				</div>
			</div>
		</div>








<!-- 	</div> -->


	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6c86d97abbc1c8a6096906791ce94735"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(${vo2.latitude}, ${vo2.longitude}), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		

		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(${vo2.latitude}, ${vo2.longitude});

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);
	</script>
</body>
</html>