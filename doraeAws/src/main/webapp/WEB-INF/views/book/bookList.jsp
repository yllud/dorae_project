<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.book-icon {
	width: 40px;
}
</style>
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
<script>
function deleteBookmark(playId) {
    $.ajax({
        url: "/dorae/book/delete_book",
        method: "POST",
        data: { 
            play_id: playId,
            email: '<%= session.getAttribute("email") %>'
        },
        success: function(response) {
        	if(response == "success"){
           		alert("북마크 삭제됨!");
        	}else{
        		alert("북마크 이미 삭제되었습니다!");
        	}
        },
        error: function(xhr, status, error) {
            console.log('북마크 삭제 중 에러가 발생했습니다.');
        }
    });
}
</script>
<div id="contentDiv">
<h2>북마크 목록</h2>
	<table style="width:80%;">
		<tr style="text-align: left;">
			<th>공연포스터</th>
			<th>공연이름</th>
			<th>장르이름</th>
			<th>공연장이름</th>
			<th></th>
		</tr><hr>
		<!-- Controller에서 Model 이름을 list로 지정해서 ${list} -->
		<c:forEach items="${list2}" var="list">
			<tr style="min-width: 120px;">
				<td style="min-width: 200px;"><img src="${list.poster}" style="width: 200px; height: 240px;"></td>
				<td style="min-width: 150px;"><a href="../search/playDetail?play_id=${list.play_id}">${list.play_name}</a></td>
				<td style="min-width: 100px;">${list.genre_name}</td>
				<td style="width: 400px;">${list.stage_name}</td>
				<td style="width: 100px;"><img class="book-icon" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_selected.jpg" onclick="deleteBookmark('${list.play_id}')"></td>
			</tr>
		</c:forEach>
	</table>
</div>