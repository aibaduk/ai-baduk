<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>엑셀다운로드</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	// 파일 선택(업로드) 이벤트
	/* $("#btnUploadExcel").on("change", function() {
		fnUploadExcel();
	}); */
});

// 엑셀업로드
function fnUploadExcel() {
	$.ajax({
		url: "/admin/analyzeInfo/excel-upload",
		type: "POST",
		data: new FormData($("#form")[0]),
		dataType: "json",
		processData: false,
		contentType: false,
		success: function(data) {
			if (data.result) {
				alert('업로드 성공');
			}
			else {
				alert('업로드 실패');
			}
		}
	});
}
</script>
<body>
	<div id="wrap">
        <!-- 엑셀 업로드 form -->
		<form id="form" name="form" method="post" enctype="multipart/form-data" action="/admin/analyzeInfo/excel-upload">
			<div class="btn btn-primary btn-file">
				엑셀업로드<input type="file" id="file" name="file" accept=".xlsx, .xls" onchange="fnUploadExcel()">
				<!-- <input type="submit" id="submit"> -->
			</div>
		</form>
	</div>
</body>
</html>