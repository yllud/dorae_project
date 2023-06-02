<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style>
span.selected-label {
	font-size: 12pt;
}
#check-container{
	 align-items: center;
	 margin-top: 175px;
 	 padding: 80px;
 	 padding-bottom: 0;
}
</style>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
var genreCount = 0;
var areaCount = 0;
var userEmail = "";
var selectedOrders = {
	area : [],
	genre : []

}; // 체크된 항목의 순서를 저장하는 배열

	$(function() {
		$("#header").load("../header/header.jsp");
		
		$('#submit').click(function() {
			<% if (session.getAttribute("email") != null) { %>
				userEmail = '<%= session.getAttribute("email") %>';
				console.log("Button clicked");
				var selectedGenre = selectedOrders.genre.map(function(checkbox) {
					return checkbox.value;
				}).slice(0, 3);
				var selectedArea = selectedOrders.area.map(function(checkbox) {
					return checkbox.value;
				}).slice(0, 3);
				
				if(selectedGenre[0] == null || selectedArea[0] == null){
					alert("지역과 장르는 1가지 이상 필수로 선택해야합니다.");
				}else{
					alert("설정이 완료되었습니다!");
					$.ajax({
						url : "insert_preference",
						type : "POST",
						data : {
							genre1: selectedGenre[0],
							 genre2: selectedGenre[1],
							 genre3: selectedGenre[2],
							 area1: selectedArea[0],
							 area2: selectedArea[1],
							 area3: selectedArea[2],
							 email: userEmail
						},
						success : function(response) {
							if (response === "success") {
								console.log("Preference inserted successfully");
								// 성공 처리 로직 작성
							} else {
								console.log("Failed to insert preference");
								// 실패 처리 로직 작성
							}
						},
						error : function(xhr, status, error) {
							console.log("Error: " + error);
							// 에러 처리 로직 작성
						}
					});
					
					window.location.href = "main.jsp";
				}
			<% } else {%>
				alert("로그인이 필요합니다!");
				window.location.href = "/dorae/login/login.jsp";
			<% } %>
		});
	});

	function limitCheckboxSelection(checkbox) {
		var checkboxes = document.getElementsByName(checkbox.name);
		var checkedCount = 0;
		var isFirstCheckboxChecked = false;

		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].checked) {
				checkedCount++;
			}
		}

		if (checkedCount > 3) {
			checkbox.checked = false;
			alert("최대 3개까지 선택 가능합니다.");
			return;
		}

		if (checkbox.checked) {
			// 해당 체크박스가 속한 그룹 (지역 또는 장르) 확인
			var group = checkbox.name;

			// 해당 그룹에 대한 selectedOrder 배열 가져오기
			var selectedOrder = selectedOrders[group];

			// 가장 먼저 push된 체크박스는 1순위로 유지되도록 배열의 맨 앞에 추가(unshift)
			if (selectedOrder.length === 0) {
				selectedOrder.unshift(checkbox);
				isFirstCheckboxChecked = true;
			} else if (selectedOrder.length < 3) {
				// 2순위인 경우 배열 맨 뒤에 추가(push)
				selectedOrder.push(checkbox);
			} else {
				// 3순위인 경우 배열 중간에 추가
				selectedOrder.splice(1, 0, checkbox);
			}
		} else {
			// 체크박스가 선택 해제되면 배열에서 제거
			var group = checkbox.name;
			var selectedOrder = selectedOrders[group];
			var index = selectedOrder.indexOf(checkbox);
			if (index > -1) {
				selectedOrder.splice(index, 1);
			}
		}

		// 순위 표시 업데이트
		for (var i = 0; i < checkboxes.length; i++) {
			var label = document.getElementById(checkbox.name + "_selected_"
					+ checkboxes[i].id);
			var group = checkbox.name;
			var selectedOrder = selectedOrders[group];

			if (checkboxes[i] === checkbox) {
				if (isFirstCheckboxChecked) {
					label.innerHTML = "1순위";
				} else {
					label.innerHTML = "";
				}
			} else if (checkboxes[i].checked) {
				var order = selectedOrder.indexOf(checkboxes[i]) + 1;
				label.innerHTML = order + "순위";
			} else {
				label.innerHTML = "";
			}
		}

		// 체크박스의 순위를 업데이트
		for (var i = 0; i < checkboxes.length; i++) {
			var label = document.getElementById(checkbox.name + "_selected_"
					+ checkboxes[i].id);
			if (checkboxes[i].checked) {
				label.innerHTML = selectedOrder.indexOf(checkboxes[i]) + 1
						+ "순위";
			}
		}
		console.log("selectedOrders genre 값 >>> "
				+ selectedOrders["genre"].map(function(checkbox) {
					return checkbox.value;
				}).join(", "));
		console.log("selectedOrders area 값 >>> "
				+ selectedOrders["area"].map(function(checkbox) {
					return checkbox.value;
				}).join(", "));
	}
</script>
<link rel="stylesheet" href="../resources/css/recommend.css" />
<body>
	<header id="header"></header>
	<div id="check-container">
	<table><tr>
		<td>
			<div class="search_tit">
				<strong> 선호하는 장르 선택</strong> 선택한 장르에 따라 공연을 추천해드려요
			</div>
			<table class="frame">
				<tr>
					<td><input type="checkbox" name="genre" id="genre1" value="뮤지컬"
						onclick="limitCheckboxSelection(this)"> 뮤지컬 <span
						id="genre_selected_genre1" class="selected-label"></span></td>
					<td><input type="checkbox" name="genre" id="genre2" value="연극"
						onclick="limitCheckboxSelection(this)"> 연극 <span
						id="genre_selected_genre2" class="selected-label"></span></td>
					<td><input type="checkbox" name="genre" id="genre3" value="서커스/마술"
						onclick="limitCheckboxSelection(this)"> 서커스/마술 <span
						id="genre_selected_genre3" class="selected-label"></span></td>
					<td><input type="checkbox" name="genre" id="genre4" value="클래식"
						onclick="limitCheckboxSelection(this)"> 서양음악(클래식) <span
						id="genre_selected_genre4" class="selected-label"></span></td>
					<td><input type="checkbox" name="genre" id="genre5" value="한국음악(국악)"
						onclick="limitCheckboxSelection(this)"> 한국음악(국악) <span
						id="genre_selected_genre5" class="selected-label"></span></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="genre" id="genre6" value="대중음악"
						onclick="limitCheckboxSelection(this)"> 대중음악 <span
						id="genre_selected_genre6" class="selected-label"></span></td>
					<td><input type="checkbox" name="genre" id="genre7" value="복합"
						onclick="limitCheckboxSelection(this)"> 복합 <span
						id="genre_selected_genre7" class="selected-label"></span></td>
					<td><input type="checkbox" name="genre" id="genre8" value="무용"
						onclick="limitCheckboxSelection(this)"> 무용 <span
						id="genre_selected_genre8" class="selected-label"></span></td>
					<td><input type="checkbox" name="genre" id="genre9" value="대중무용"
						onclick="limitCheckboxSelection(this)"> 대중무용 <span
						id="genre_selected_genre9" class="selected-label"></span></td>
				</tr>
			</table>
		
			<br>
			<br>
		
			<div class="search_tit">
				<strong> 원하는 지역 선택</strong> 선택한 지역에 따라 공연을 추천해드려요
			</div>
			<table class="frame">
				<tr>
					<td><input type="checkbox" name="area" id="area1" value="서울"
						onclick="limitCheckboxSelection(this)"> 서울 <span
						id="area_selected_area1" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area2" value="경기도"
						onclick="limitCheckboxSelection(this)"> 경기도 <span
						id="area_selected_area2" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area3" value="부산"
						onclick="limitCheckboxSelection(this)"> 부산 <span
						id="area_selected_area3" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area4" value="인천"
						onclick="limitCheckboxSelection(this)"> 인천 <span
						id="area_selected_area4" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area5" value="대구"
						onclick="limitCheckboxSelection(this)"> 대구 <span
						id="area_selected_area5" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area6" value="광주"
						onclick="limitCheckboxSelection(this)"> 광주 <span
						id="area_selected_area6" class="selected-label"></span></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="area" id="area7" value="대전"
						onclick="limitCheckboxSelection(this)"> 대전 <span
						id="area_selected_area7" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area8" value="울산"
						onclick="limitCheckboxSelection(this)"> 울산 <span
						id="area_selected_area8" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area9" value="충청"
						onclick="limitCheckboxSelection(this)"> 충청도 <span
						id="area_selected_area9" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area10" value="경상"
						onclick="limitCheckboxSelection(this)"> 경상도 <span
						id="area_selected_area10" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area11" value="전라"
						onclick="limitCheckboxSelection(this)"> 전라도 <span
						id="area_selected_area11" class="selected-label"></span></td>
					<td><input type="checkbox" name="area" id="area12" value="제주"
						onclick="limitCheckboxSelection(this)"> 제주도 <span
						id="area_selected_area12" class="selected-label"></span></td>
				</tr>
			</table>
			<br><br>
			<div class="wrap_btn_zone">
				<button class="btn cancle">취소</button>
				<button id="submit" class="btn submit">설정완료</button>
			</div>
		</td>
		<td style="width:90px;"></td>
	</tr></table>
		
	</div>
</body>
</html>