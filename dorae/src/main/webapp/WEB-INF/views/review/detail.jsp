<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css"
	href="../resources/css/reviewStyle.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<!--출력화면내용  -->
<div class="centered">
	<table id = "detail-table">
		<tr>
			<td><img src="../resources/img/pin.png" width="35" height="40"></td>
			<td>${review.tag}</td>
		</tr>
		<tr>
			<td colspan="2"><c:choose>
					<c:when test="${not empty review.images}">
						<div class="imageContainer">
							<button id="prevButton" ${review.images.size() > 1 ? '' : 'disabled'}>&lt;</button>
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
		<tr>
			<td colspan="2" class="bold-text">${review.title}</td>
		</tr>
		<tr>
			<td colspan="2" class="light-text">${review.email}</td>
		</tr>
		<tr>
			<td colspan="2"><div class="scrollable-content">${review.content}</div></td>
		</tr>
	</table>
</div>
<!--본인 게시글만 수정, 삭제 가능 -->
<c:if test="${sessionScope.email eq review.email}">
	<div id="upAndDel">
		<form action="update" method="post">
			<input type="hidden" name="id" value="${review.id}">
			<button>후기 수정</button>
		</form>
		<form action="delete" method="post" id="deleteForm">
			<input type="hidden" name="id" value="${review.id}">
			<button type="button" onclick="confirmDelete()">후기 삭제</button>
		</form>
		<div class="clear"></div>
	</div>
</c:if>
<!-- 이미지 뷰 넘어가는 설정 코드 수정 -->
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
    prevButton.style.display = currentIndex > 0 ? "block" : "none"; // 이전 버튼 표시 여부 설정
    nextButton.style.display =
      currentIndex < images.length - 1 ? "block" : "none"; // 다음 버튼 표시 여부 설정
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
  function confirmDelete() {
    var confirmation = confirm("정말 삭제하시겠습니까?");

    if (confirmation) {
      $("#deleteForm").submit();
    }
  }
</script>
