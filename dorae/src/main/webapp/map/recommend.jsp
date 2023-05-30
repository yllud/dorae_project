<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
span.selected-label {
  font-size: 12pt;
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
var genreCount = 0;
var areaCount = 0;

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

var selectedOrder = []; // 체크된 항목의 순서를 저장하는 배열

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
        var index = selectedOrder.indexOf(checkbox);
        if (index > -1) {
            selectedOrder.splice(index, 1);
        }
    }
    
 	// 순위 표시 업데이트
    for (var i = 0; i < checkboxes.length; i++) {
        var label = document.getElementById(checkbox.name + "_selected_" + checkboxes[i].id);
        if (checkboxes[i] === checkbox) {
            if (isFirstCheckboxChecked) {
                label.innerHTML = "1순위";
            } else {
                label.innerHTML = "";
            }
        } else if (checkbox.checked && checkboxes[i].checked) {
            var order = selectedOrder.indexOf(checkboxes[i]) + 2;
            label.innerHTML = order + "순위";
        } else if (!checkbox.checked && checkboxes[i].checked) {
            var order = selectedOrder.indexOf(checkboxes[i]) + 1;
            label.innerHTML = order + "순위";
        } else {
            label.innerHTML = "";
        }
    }

    // 체크박스의 순위를 업데이트
    for (var i = 0; i < checkboxes.length; i++) {
        var label = document.getElementById(checkbox.name + "_selected_" + checkboxes[i].id);
        if (checkboxes[i].checked) {
            label.innerHTML = selectedOrder.indexOf(checkboxes[i]) + 1 + "순위";
        }
    }
    
    console.log("selectedOrder 값 >>> " + selectedOrder.map(function(checkbox) {
    	  return checkbox.value;
    	}).join(", "));
}

function getSelectedValues(name) {
    var checkboxes = document.getElementsByName(name);
    var selectedValues = [];

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            selectedValues.push(checkboxes[i].value);
        }
    }

    return selectedValues;
}
</script>
<link rel="stylesheet" href="../resources/css/recommend.css" />
<body>
	<div class="search_tit">
    	<strong> 선호하는 장르 선택</strong> 선택한 장르에 따라 공연을 추천해드려요
    </div>
	<table class="frame">
		<tr>
			<td><input type="checkbox" name="genre" id="genre1" value="뮤지컬" onclick="limitCheckboxSelection(this)"> 뮤지컬 <span id="genre_selected_genre1" class="selected-label"></span></td>
			<td><input type="checkbox" name="genre" id="genre2" value="연극" onclick="limitCheckboxSelection(this)"> 연극 <span id="genre_selected_genre2" class="selected-label"></span></td>
			<td><input type="checkbox" name="genre" id="genre3" value="서커스/마술" onclick="limitCheckboxSelection(this)"> 서커스/마술 <span id="genre_selected_genre3" class="selected-label"></span></td>
			<td><input type="checkbox" name="genre" id="genre4" value="클래식" onclick="limitCheckboxSelection(this)"> 서양음악(클래식) <span id="genre_selected_genre4" class="selected-label"></span></td>
			<td><input type="checkbox" name="genre" id="genre5" value="국악" onclick="limitCheckboxSelection(this)"> 한국음악(국악) <span id="genre_selected_genre5" class="selected-label"></span></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="genre" id="genre6" value="대중음악" onclick="limitCheckboxSelection(this)"> 대중음악 <span id="genre_selected_genre6" class="selected-label"></span></td>
			<td><input type="checkbox" name="genre" id="genre7" value="복합" onclick="limitCheckboxSelection(this)"> 복합 <span id="genre_selected_genre7" class="selected-label"></span></td>
			<td><input type="checkbox" name="genre" id="genre8" value="무용" onclick="limitCheckboxSelection(this)"> 무용 <span id="genre_selected_genre8" class="selected-label"></span></td>
			<td><input type="checkbox" name="genre" id="genre9" value="대중무용" onclick="limitCheckboxSelection(this)"> 대중무용 <span id="genre_selected_genre9" class="selected-label"></span></td>
		</tr>
	</table>
	
	<br><br>
	
	<div class="search_tit">
    	<strong> 원하는 지역 선택</strong> 선택한 지역에 따라 공연을 추천해드려요
    </div>
	<table class="frame">
		<tr>
			<td><input type="checkbox" name="area" id="area1" value="서울" onclick="limitCheckboxSelection(this)"> 서울 <span id="area_selected_area1" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area2" value="경기도" onclick="limitCheckboxSelection(this)"> 경기도 <span id="area_selected_area2" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area3" value="부산" onclick="limitCheckboxSelection(this)"> 부산 <span id="area_selected_area3" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area4" value="인천" onclick="limitCheckboxSelection(this)"> 인천 <span id="area_selected_area4" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area5" value="대구" onclick="limitCheckboxSelection(this)"> 대구 <span id="area_selected_area5" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area6" value="광주" onclick="limitCheckboxSelection(this)"> 광주 <span id="area_selected_area6" class="selected-label"></span></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="area" id="area7" value="대전" onclick="limitCheckboxSelection(this)"> 대전 <span id="area_selected_area7" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area8" value="울산" onclick="limitCheckboxSelection(this)"> 울산 <span id="area_selected_area8" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area9" value="충청도" onclick="limitCheckboxSelection(this)"> 충청도 <span id="area_selected_area9" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area10" value="경상도" onclick="limitCheckboxSelection(this)"> 경상도 <span id="area_selected_area10" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area11" value="전라도" onclick="limitCheckboxSelection(this)"> 전라도 <span id="area_selected_area11" class="selected-label"></span></td>
			<td><input type="checkbox" name="area" id="area12" value="제주도" onclick="limitCheckboxSelection(this)"> 제주도 <span id="area_selected_area12" class="selected-label"></span></td>
		</tr>
	</table>
	<br><br>
	
	<div class="wrap_btn_zone">
	    <button class="btn cancle"><a href="">취소</a></button>
	    <button class="btn submit"><a href="">설정완료</a></button>
    </div>              
</body>
</html>