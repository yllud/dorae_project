<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://dorae-aws.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$(function() {
		$('.stageSelect').click(function() {
			//기존의 것 삭제됨.
			$('#select0').empty()
			$('#select0').append($(this).text())
			// 			$('#stage_id').append($(this).text())

			var stageId = $(this).data('stage-id');
			$('#stage_id', window.opener.document).val(stageId);

			var stageName = $(this).text();
			$('#stage_name', window.opener.document).text(stageName);
			// 		    window.close();
		})//stageSelect

		$('#complete').click(function() {
			//기존의 것 삭제됨.

			window.close();
		})//complete

	})//$
</script>
<style type="text/css">
.date {
	width: 80px;
	/*   height:100px; */
	/*   font-size:20px; */
}
</style>
</head>
<body>
	<br>
	<div style="max-height: 400px; overflow-y: auto;">
		
		<table class="table table-striped table-hover aling-middle">

			<tbody>
				<c:forEach items="${list}" var="vo">
					<tr>
						<td><a href="#" data-stage-id="${vo.stage_id}"
							class="stageSelect">${vo.stage_name}</a><br>${vo.address}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<br>
	<mark id="select0"></mark>
	<br>
	<button class="btn btn-primary mb-1" id="complete">선택</button>
</body>
</html>