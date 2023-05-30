<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
function sendRecommendationRequest() {
	var selectedGenres = getSelectedValues("genre");
  	var selectedAreas = getSelectedValues("area");

  	var request = new XMLHttpRequest();
  	request.open("POST", "RecommendationServlet", true);
  	request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  	request.onreadystatechange = function() {
    	if (request.readyState === 4 && request.status === 200) {
    		var response = request.responseText;
      		// 처리된 추천 결과를 이용하여 원하는 방식으로 표시하거나 처리합니다.
      		// 예: 결과를 테이블에 동적으로 추가하는 등의 작업을 수행할 수 있습니다.
  		}
    };
    request.send("genres=" + encodeURIComponent(selectedGenres) + "&areas=" + encodeURIComponent(selectedAreas));
}
function limitCheckboxSelection(checkbox) {
	var checkboxes = document.getElementsByName(checkbox.name);
 	var checkedCount = 0;

  	for (var i = 0; i < checkboxes.length; i++) {
    	if (checkboxes[i].checked) {
      		checkedCount++;
    	}
  	}

  	if (checkedCount > 3) {
    	checkbox.checked = false;
    	alert("최대 3개까지 선택가능합니다.");
  	}
}
</script>
<link rel="stylesheet" href="../resources/css/recommend.css" />
<body>
	<div class="search_tit">
    	<strong> 선호하는 장르 선택</strong> 선택한 장르에 따라 공연을 추천해드려요
    </div>
	<table class="frame">
		<tr>
			<td><input type="checkbox" name="genre" value="뮤지컬" onclick="limitCheckboxSelection(this)"> 뮤지컬 </td>
			<td><input type="checkbox" name="genre" value="연극" onclick="limitCheckboxSelection(this)"> 연극 </td>
			<td><input type="checkbox" name="genre" value="서커스/마술" onclick="limitCheckboxSelection(this)"> 서커스/마술 </td>
			<td><input type="checkbox" name="genre" value="클래식" onclick="limitCheckboxSelection(this)"> 서양음악(클래식) </td>
			<td><input type="checkbox" name="genre" value="국악" onclick="limitCheckboxSelection(this)"> 한국음악(국악) </td>
		</tr>
		<tr>
			<td><input type="checkbox" name="genre" value="대중음악" onclick="limitCheckboxSelection(this)"> 대중음악 </td>
			<td><input type="checkbox" name="genre" value="복합" onclick="limitCheckboxSelection(this)"> 복합 </td>
			<td><input type="checkbox" name="genre" value="무용" onclick="limitCheckboxSelection(this)"> 무용 </td>
			<td><input type="checkbox" name="genre" value="대중무용" onclick="limitCheckboxSelection(this)"> 대중무용 </td>
		</tr>
	</table>
	
	<br><br>
	
	<div class="search_tit">
    	<strong> 원하는 지역 선택</strong> 선택한 지역에 따라 공연을 추천해드려요
    </div>
	<table class="frame">
		<tr>
			<td><input type="checkbox" name="area" value="서울" onclick="limitCheckboxSelection(this)"> 서울 </td>
			<td><input type="checkbox" name="area" value="경기도" onclick="limitCheckboxSelection(this)"> 경기도 </td>
			<td><input type="checkbox" name="area" value="부산" onclick="limitCheckboxSelection(this)"> 부산 </td>
			<td><input type="checkbox" name="area" value="인천" onclick="limitCheckboxSelection(this)"> 인천 </td>
			<td><input type="checkbox" name="area" value="대구" onclick="limitCheckboxSelection(this)"> 대구 </td>
			<td><input type="checkbox" name="area" value="광주" onclick="limitCheckboxSelection(this)"> 광주 </td>
		</tr>
		<tr>
			<td><input type="checkbox" name="area" value="대전" onclick="limitCheckboxSelection(this)"> 대전 </td>
			<td><input type="checkbox" name="area" value="울산" onclick="limitCheckboxSelection(this)"> 울산 </td>
			<td><input type="checkbox" name="area" value="충청도" onclick="limitCheckboxSelection(this)"> 충청도 </td>
			<td><input type="checkbox" name="area" value="경상도" onclick="limitCheckboxSelection(this)"> 경상도 </td>
			<td><input type="checkbox" name="area" value="전라도" onclick="limitCheckboxSelection(this)"> 전라도 </td>
			<td><input type="checkbox" name="area" value="제주도" onclick="limitCheckboxSelection(this)"> 제주도</td>
		</tr>
	</table>
	<br><br>
	
	<div class="wrap_btn_zone">
	    <button class="btn cancle"><a href="">취소</a></button>
	    <button class="btn submit"><a href="">설정완료</a></button>
    </div>
                
                
</body>
</html>