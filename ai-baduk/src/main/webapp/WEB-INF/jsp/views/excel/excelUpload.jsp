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
	$("#btnUploadExcel").on("change", function() {
		fnUploadExcelRegChk();
	});
});

//엑셀업로드 체크
function fnUploadExcelRegChk() {
	let msg = "";
	let input = event.target;
	let reader = new FileReader();
	reader.onload = function() {
		let fdata = reader.result;
		let read_buffer = XLSX.read(fdata, {type : 'binary'});
		read_buffer.SheetNames.forEach(function(sheetName) {
			let rowdata =XLSX.utils.sheet_to_json(read_buffer.Sheets[sheetName]); // Excel 입력 데이터

			// 행 수 만큼 반복
			for(let i=0;i<rowdata.length;i++) {
				// 필수값 체크
				if(rowdata[i].id == null) {
					msg += 'id 값이 존재하지 않습니다.';
					console.log(msg);
					return false;
				}

				// 정규식 체크
				let keys = Object.keys(rowdata[i]);
				let re=/[^ㄱ-ㅎ가-힣a-zA-Z0-9\-\_\.\@]/gi;
				let reNum=/[^0-9]/gi;
				for(let j=0;j<keys.length;j++) {
					let data = rowdata[i][keys[j]];
					if(keys[j] == 'id') {
						if(reNum.test(data)) {
							msg = keys[j] + '은 숫자만 입력 가능합니다.';
							console.log(msg);
							return false;
						}
					} else {
						if(re.test(data)) {
							msg = keys[j] + '에 허용되지않는 문자가 포함되어있습니다.';
							gfnFailAlert("", msg, gDelay2);
							return false;
						}
					}
				}
			}
			console.log(JSON.stringify(rowdata));
			fnUploadExcel();
		})
	};
	reader.readAsBinaryString(input.files[0]);
}

// 엑셀업로드
function fnUploadExcel() {
	let apiUrl = "/mypage/analyzeInfo/excelUpload";
	$.ajax({
		url : apiUrl,
		type : "POST",
		data : new FormData($("#frmAttachedFiles")[0]),
		dataType: "json",
		processData: false,
		contentType: false,
		success: function(result) {
			if (result.resultCode == "SUCCESS") {
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
		<form id="frmAttachedFiles" class="form-horizontal" enctype="multipart/form-data">
			<div class="btn btn-primary btn-file">
				엑셀업로드<input type="file" id="btnUploadExcel" name="btnUploadExcel">
			</div>
		</form>
	</div>
</body>
</html>