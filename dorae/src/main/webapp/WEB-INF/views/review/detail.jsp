<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css"
	href="../resources/css/reviewStyle.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>
.imageContainer {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 10px;
}

.imageContainer img {
	max-width: 100%;
	max-height: 400px;
	object-fit: contain;
	margin: 0 5px;
}

.imageContainer button {
	margin: 0 5px;
	padding: 5px;
}

div.centered {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>
<!--출력화면내용  -->
<div class="centered">
	<table>
		<tr>
			<td>작성자:</td>
			<td>${review.email}</td>
		</tr>
		<tr>
			<td>제목:</td>
			<td>${review.title}</td>
		</tr>
		<tr>
			<td>내용:</td>
			<td>${review.content}</td>
		</tr>
		<tr>
			<td>태그:</td>
			<td>${review.tag}</td>
		</tr>
		<tr>
			<td colspan="2"><c:choose>
					<c:when test="${not empty review.images}">
						<div class="imageContainer">
							<button id="prevButton" disabled>&lt;</button>
							<c:forEach var="image" items="${review.images}">
								<img src="../resources/upload/${image}" alt="후기 이미지" />
							</c:forEach>
							<button id="nextButton"
								${review.images.size() > 1 ? '' : 'disabled'}>&gt;</button>
						</div>
					</c:when>
					<c:otherwise>
						<div class="no-image">후기 이미지가 없습니다.</div>
					</c:otherwise>
				</c:choose></td>
		</tr>
	</table>

	<!--본인 게시글만 수정, 삭제 가능 -->
	<c:if test="${sessionScope.email eq review.email}">
		<a href="update?id=${review.id}">
			<button>후기 수정</button>
		</a>
		<button onclick="confirmDelete(${review.id})">후기 삭제</button>
	</c:if>
</div>
<!--이미지 뷰 넘어가는 설정 코드 -->
<script>
    const images = document.querySelectorAll(".imageContainer img");
    const prevButton = document.getElementById("prevButton");
    const nextButton = document.getElementById("nextButton");
    let currentIndex = 0;

    function showImage(index) {
        images.forEach((image, i) => {
            if (i === index) {
                image.style.display = "block"; // 선택된 이미지 보여줌
            } else {
                image.style.display = "none"; // 선택되지 않은 이미지 숨김
            }
        });
    }

    function updateButtons() {
        prevButton.disabled = currentIndex === 0; // 첫 번째 이미지일 경우 이전 버튼 비활성화
        nextButton.disabled = currentIndex === images.length - 1; // 마지막 이미지일 경우 다음 버튼 비활성화
    }

    prevButton.addEventListener("click", () => {
        if (currentIndex > 0) {
            currentIndex--; // 이전 이미지 인덱스로 변경
            showImage(currentIndex); // 변경된 이미지 보여줌
            updateButtons(); // 버튼 상태 업데이트
        }
    });

    nextButton.addEventListener("click", () => {
        if (currentIndex < images.length - 1) {
            currentIndex++; // 다음 이미지 인덱스로 변경
            showImage(currentIndex); // 변경된 이미지 보여줌
            updateButtons(); // 버튼 상태 업데이트
        }
    });

    showImage(currentIndex); // 초기에 첫 번째 이미지 보여줌
    updateButtons(); // 초기 버튼 상태 업데이트
    
    // 게시물 삭제 처리 함수
    function confirmDelete(id) {
        var result = confirm("정말 삭제하시겠습니까?");
        if (result) {
            // 확인을 누른 경우 Ajax를 통해 삭제 요청 보내기
            var deleteDate = new Date().toISOString().split("T")[0];
            $.ajax({
                url: "delete",
                type: "POST",
                data: {
                    id: id,
                    deleteDate: deleteDate
                },
                success: function() {
                    alert("후기가 삭제되었습니다.");
                    window.opener.location.reload(); // 부모 창 새로고침
                    window.close(); // 팝업 창 닫기
                },
                error: function() {
                    alert("삭제 중에 오류가 발생했습니다.");
                }
            });
        } else {
        	 window.history.back();
        }
    }
</script>