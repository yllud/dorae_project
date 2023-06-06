<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매완료</title>
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>

<script type="text/javascript">

function check() {
	opener.location.href="http://localhost:8888/dorae/login/mypage";
	window.close();
};

</script>
</head>
<body>
<div class="container my-5">
  <div class="p-5 text-center bg-body-tertiary rounded-3">
    <i class="bi bi-ticket-perforated" style="font-size: 10rem; color: orange;"></i>
    <h2 class="text-body-emphasis">예매완료</h2>
    <p class="col-lg-8 mx-auto fs-5 text-muted">
      결제가 정상적으로 완료되었습니다.<br>
      마이페이지에서 예매내역 확인하실 수 있습니다.
    </p>
    <div class="d-inline-flex gap-2 mb-5">
      <button class="d-inline-flex align-items-center btn btn-outline-warning btn-lg px-4 rounded-pill" onclick='check()'>
        예매내역확인
      </button>
      <button class="btn btn-outline-secondary btn-lg px-4 rounded-pill" onclick="window.close()">
        닫기
      </button>
    </div>
  </div>
</div>

</body>
</html>