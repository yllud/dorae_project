<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(function() {

		$.ajax({
			url : "all",
			type : "GET",
			dataType : "json",
			success : function(data) {
				// 데이터를 받아와서 후기 목록을 처리하고 업데이트합니다.
				var reviewListDiv = $("#reviewList");
				reviewListDiv.empty(); // 기존 내용을 지웁니다.

				if (data && data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						var review = data[i];
						
						// 각 후기를 분리하여 <div> 요소로 추가합니다.
						var reviewDiv = $("<div></div>");
						var titleElement = $("<h3></h3>").text("제목: " + review.title);
						var contentElement = $("<p></p>").text("내용: " + review.content);
						var tagElement = $("<p></p>").text("태그: " + review.tag);
						
						reviewDiv.append(titleElement); // 제목
						reviewDiv.append(tagElement); // 태그
						// 이미지가 있는 경우 처리
						if (review.images && review.images.length > 0) {
                        for (var j = 0; j < review.images.length; j++) {
                            var imageUrl = "../resources/upload/" + review.images[j];
                            var imageElement = $("<img>").attr("src", imageUrl).attr("alt", "후기 이미지").attr("width", "300").attr("height", "300");
                            reviewDiv.append(imageElement);
                        }
                    }
						
						reviewDiv.append(contentElement); // 내용
						reviewListDiv.append(reviewDiv);
					}
				} else {
					reviewListDiv.html("후기가 없습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.log("후기 데이터를 가져오는 중 오류가 발생했습니다: " + error);
			}
		});
		
		$('#tagSearch').click(function() {
			var tag = $('#tag').val();
			$.ajax({
				url : "tagSearch",
				type : "GET",
				dataType : "json",
				data : {
					tag : tag
				},
				success : function(data) {
					// 데이터를 받아와서 후기 목록을 처리하고 업데이트합니다.
					var reviewListDiv = $("#reviewList");
					reviewListDiv.empty(); // 기존 내용을 지웁니다.

					if (data && data.length > 0) {
						for (var i = 0; i < data.length; i++) {
							var review = data[i];
							
							// 각 후기를 분리하여 <div> 요소로 추가합니다.
							var reviewDiv = $("<div></div>");
							var titleElement = $("<h3></h3>").text("제목: " + review.title);
							var contentElement = $("<p></p>").text("내용: " + review.content);
							var tagElement = $("<p></p>").text("태그: " + review.tag);
							
							reviewDiv.append(titleElement); // 제목
							reviewDiv.append(tagElement); // 태그
							// 이미지가 있는 경우 처리
							if (review.images && review.images.length > 0) {
	                        for (var j = 0; j < review.images.length; j++) {
	                            var imageUrl = "../resources/upload/" + review.images[j];
	                            var imageElement = $("<img>").attr("src", imageUrl).attr("alt", "후기 이미지").attr("width", "300").attr("height", "300");
	                            reviewDiv.append(imageElement);
	                        }
	                    }
							
							reviewDiv.append(contentElement); // 내용
							reviewListDiv.append(reviewDiv);
						}
					} else {
						reviewListDiv.html("후기가 없습니다.");
					}
				},
				error : function(xhr, status, error) {
					console.log("후기 데이터를 가져오는 중 오류가 발생했습니다: " + error);
				}
			});
		})

	});
	// 후기 작성 페이지 여는 함수
	function openMyReviewPage() {
		window.location.href = "myReview2.jsp";
	}
</script>
</head>
<body>
	<input type="text" id = "tag"><button id = "tagSearch">태그 검색</button>
	<button onclick="openMyReviewPage()">후기 작성</button>
	<div id="reviewList"></div>
</body>
</html>