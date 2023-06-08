<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/css/businessSidebars.css">
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {

		$('#btnRecover').click(function() {
			//기존의 것 삭제됨.

			$.ajax({
				type : "post",
				url : "businessRecover",
				data : {
					play_id : $('#play_id').val()
				},
				success : function(x) {
					alert('공연 복원 성공')
					window.close()
				},//success
				error : function() {
					alert('삭제 실패')
				}//error
			})//ajax
		})//b1

	})//$
</script>
</head>
<body>
	<div class="new-page">
		<div
			class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
			<h1 class="h2">공연 상세</h1>
		</div>
		<!-- el 속성만 받아올 수 있는 표현식 -->
		<input id="play_id" type="hidden" value="${vo.play_id}">

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">제목</label>
			<div class="col-sm-10">
				<input class="form-control" id="play_name" value="${vo.play_name}"
					readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">장르</label>
			<div class="col-sm-10">
				<input class="form-control" id="genre_name" value="${vo.genre_name}"
					readonly>
			</div>
		</div>

		<input id="stage_id" type="hidden" value="${vo.stage_id}">
		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">공연장</label>
			<div class="col-sm-10">
				<input class="form-control" id="stage_name" value="${vo.stage_name}"
					readonly>
			</div>
		</div>

		<!-- 달력 -->
		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">기간 </label>
			<div class="col-sm-10">
				<input class="form-control" id="play_start"
					value="${vo.play_start} ~ ${vo.play_end}" readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">공연
				시간</label>
			<div class="col-sm-10">
				<input class="form-control" id="play_time" value="${vo.play_time}"
					readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">런타임</label>
			<div class="col-sm-10">
				<input class="form-control" id="runtime" value="${vo.runtime}"
					readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">관람연령</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="play_age"
					value="${vo.play_age}" readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">출연진</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="casting"
					value="${vo.casting}" readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">제작진</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="crew" value="${vo.crew}"
					readonly>
			</div>
		</div>
		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">기업</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="enterprise"
					value="${vo.enterprise}" readonly>
			</div>
		</div>
		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">가격</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="price"
					value="${vo.price}" readonly>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">포스터</label>
			<div class="col-sm-10">
				<img src="${vo.poster}" width="200" height="250">
			</div>
		</div>


		<div class="mb-3 row">
			<label for="noticeContent" class="col-sm-2 col-form-label">내용</label>
			<div class="col-sm-10">
				<textarea class="form-control" id="content" rows="5" readonly>${vo.content}</textarea>
			</div>
		</div>

		<div class="mb-3 row">
			<label for="noticeTitle" class="col-sm-2 col-form-label">오픈런</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" id="openrun"
					value="${vo.openrun}" readonly>
			</div>
		</div>

		<button class="btn btn-primary mb-3" id="btnRecover">복원</button>
	</div>

</body>
</html>