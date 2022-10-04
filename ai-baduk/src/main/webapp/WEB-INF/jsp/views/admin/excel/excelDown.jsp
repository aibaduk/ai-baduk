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

	$('#btnDownExcel').click(function() {
		let frm = $("#frmExcelDown");
		frm.attr("action", "/admin/user/sample-download");
		frm.submit();
	});
});
</script>
<body>
	<div id="wrap">
		<h1>기존방식 Excel Download</h1>
		<form id="frmExcelDown" method="GET">
			<button id="btnDownExcel">엑셀다운로드</button>
		</form>
	</div>
</body>
</html>