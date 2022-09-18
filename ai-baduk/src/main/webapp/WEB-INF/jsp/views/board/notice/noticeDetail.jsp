<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>공지사항 상세</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"

	$('#btn-insert').click(function() {
		noticeInsert();
	});

	$('#btn-update').click(function() {
		noticeUpdate();
	});

	$('#btn-delete').click(function() {
		noticeDelete();
	});

	$('#btn-cancle').click(function() {
		window.location.href="/board/notice/main";
	});

	$('#btn-file').click(function() {
		$('#uploadFile').click();
		return false;
	});

	$('.btn-delete-file').click(function() {
		noticeFileDelete($(this));
	});

	$('.file-download').click(function() {
		noticeFileDownload($(this));
	});

	$('#uploadFile').change(function() {
		let file = new Array();
		for (let i=0; i<this.files.length; i++) {
			file.push(this.files[i].name);
		}
		$('#boardFile').val(file.join(', '));
	});

});
/**
 * 공지사항 등록
 */
function noticeInsert() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm('공지사항을 등록하시겠습니까?')) {
		let formData = new FormData();
		let inputFile = $('#uploadFile');
		let files = inputFile[0].files;

		for (let i=0; i<files.length; i++) {
			formData.append("uploadFiles", files[i]);
		}
		formData.append('boardGubun', $('input:hidden[name=boardGubun]').val());
		formData.append('boardTit', $('#boardTit').val());
		formData.append('impoYn', $('input:radio[name=impoYn]:checked').val());
		formData.append('boardCtt', $('#boardCtt').val());

		$.ajax({
			type: 'post',
			url: '/board/notice/insert',
			processData: false,
			contentType: false,
			data: formData,
			success: function (data) {
				if (data.result) {
					alert('공지사항이 등록되었습니다.');
					window.location.href='/board/notice/detail?boardGubun=01&boardId='+data.boardId;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}

/**
 * 공지사항 수정
 */
function noticeUpdate() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm('공지사항을 수정하시겠습니까?')) {
		let formData = new FormData();
		let inputFile = $('#uploadFile');
		let files = inputFile[0].files;

		for (let i=0; i<files.length; i++) {
			formData.append("uploadFiles", files[i]);
		}
		formData.append('boardId', $('input:hidden[name=boardId]').val());
		formData.append('boardGubun', $('input:hidden[name=boardGubun]').val());
		formData.append('boardTit', $('#boardTit').val());
		formData.append('impoYn', $('input:radio[name=impoYn]:checked').val());
		formData.append('boardCtt', $('#boardCtt').val());

		$.ajax({
			type: 'post',
			url: '/board/notice/update',
			processData: false,
			contentType: false,
			data: formData,
			success: function (data) {
				if (data.result) {
					alert('공지사항이 수정되었습니다.');
					window.location.href='/board/notice/detail?boardGubun=01&boardId='+data.boardId;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
function validation() {
	"use strict"
	let boardTit = $('#boardTit').val();
	if (isNullOrEmpty(boardTit)) {
		alert('공지사항 제목을 입력하세요.');
		$('#boardTit').focus();
		return true;
	}
	return false;
}

/**
 * 공지사항 삭제
 */
function noticeDelete() {
	"use strict"
	if (confirm('공지사항을 삭제하시겠습니까?')) {
		let data = new Array();
		let param = {
			boardGubun: $('input:hidden[name=boardGubun]').val(),
			boardId: $('input:hidden[name=boardId]').val()
		};
		data.push(param);
		$.ajax({
			type: 'post',
			url: '/board/notice/delete',
			contentType: 'application/json',
			data: JSON.stringify(data),
			success: function (data) {
				if (data.result) {
					alert('공지사항이 삭제되었습니다.');
					window.location.href="/board/notice/main";
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
/**
 * 공지사항 파일 삭제
 */
function noticeFileDelete(file) {
	"use strict"
	if (confirm('파일을 삭제하시겠습니까?')) {
		let param = {
			boardGubun: $('input:hidden[name=boardGubun]').val(),
			boardId: $('input:hidden[name=boardId]').val(),
			fileId: file.data('id'),
			fileNm: file.data('name')
		}
		$.ajax({
			type: 'post',
			url: '/board/notice/fileDelete',
			contentType: 'application/json',
			data: JSON.stringify(param),
			success: function (data) {
				if (data.result) {
					alert('파일이 삭제되었습니다.');
					window.location.href='/board/notice/detail?boardGubun=01&boardId='+data.boardId;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
/**
 * 공지사항 파일 다운로드
 */
function noticeFileDownload(file) {
	"use strict"
	if (confirm('파일을 다운로드하시겠습니까?')) {
		let boardId = $('input:hidden[name=boardId]').val();
		let fileNm = file.data('name');
		let fileOgNm = file.text();
		window.location.href='/board/notice/fileDownload?boardId='+boardId+'&fileNm='+fileNm+'&fileOgNm='+fileOgNm;
	}
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<input type="hidden" name="boardGubun" value="01">
		<c:set var="isInsert" value="${empty noticeDetailInfo }"></c:set>
		<c:set var="isDetail" value="${not empty noticeDetailInfo }"></c:set>
		<input type="hidden" name="boardId" value="${noticeDetailInfo.boardId }">
		<section class="container">
       		<div class="keyvi"></div>
       		<section class="content brd">
	            <div class="inner">
	                <div class="tab-wrap ea4">
	                    <ul class="tab-menu">
	                        <li class="on"><a href="javascript:void(0)">공지사항</a></li>
	                        <li><a href="/board/questions/main">자주묻는질문</a></li>
	                        <li><a href="/board/info/main">바둑AI소식</a></li>
	                        <li><a href="/board/storage/main">자료실</a></li>
	                    </ul>
	                    <div class="inner-depth">
	                        <div class="tab-inner">
	                            <h2>공지사항</h2>
	                            <c:if test="${isInsert }">
		                            <ul class="write-box">
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">제목</label><input type="text" id="boardTit" name="boardTit"></span>
		                                </li>
		                                <li class="file">
		                                    <span class="form-ele">
		                                    	<label for="file">첨부파일</label><input type="text" id="boardFile" name="boardFile" readonly="readonly"><button class="btns" id="btn-file">찾아보기</button>
		                                    	<input type="file" id="uploadFile" name="uploadFile" multiple style="display: none;">
		                                    </span>
		                                </li>
		                                <li class="file">
		                                    <div class="form-ele">
		                                    	<label for="impo" class="fm-label">중요여부</label>
		                                    	<div class="fm-group" style="display: inline;">
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoY" value="Y">
					                                    <label class="fm-check-label" for="impoY">Y</label>
					                                </div>
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoN" value="N" checked="checked">
					                                    <label class="fm-check-label" for="impoN">N</label>
					                                </div>
					                            </div>
				                            </div>
		                                </li>
		                                <li class="cont">
		                                    <textarea col="100" row="50" id="boardCtt" name="boardCtt"></textarea>
		                                </li>
		                            </ul>
	                            </c:if>
	                            <c:if test="${isDetail }">
	                            	<!-- 일반사용자 view 화면 -->
	                            	<%-- <ul class="view-box">
		                                <li class="tit">${noticeDetailInfo.boardTit }</li>
		                                <li class="file">
		                                    <c:forEach items="${noticeDetailInfo.fileList }" var="file">
	                                    		<a href="javascript:void(0)" class="file-download" data-name="${file.fileNm}_${file.fileOgNm}">${file.fileOgNm}</a>
	                                    	</c:forEach>
		                                    <span class="date">${noticeDetailInfo.auditDtm }</span>
		                                </li>
		                                <li class="cont">
		                                    ${noticeDetailInfo.boardCtt }
		                                </li>
		                            </ul> --%>
		                            <!-- 관리자 write 화면 -->
		                            <ul class="write-box">
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">제목</label><input type="text" id="boardTit" name="boardTit" value="${noticeDetailInfo.boardTit }"></span>
		                                </li>
		                                <li class="file">
		                                    <span class="form-ele">
		                                    	<label for="file">첨부파일</label><input type="text" id="boardFile" name="boardFile" readonly="readonly"><button class="btns" id="btn-file">찾아보기</button>
		                                    	<input type="file" id="uploadFile" name="uploadFile" multiple style="display: none;">
		                                    </span>
		                                </li>
		                                <li class="file_text">
		                                    <c:forEach items="${noticeDetailInfo.fileList }" var="file">
	                                    		<a href="javascript:void(0)" class="file-download" data-name="${file.fileNm}_${file.fileOgNm}">${file.fileOgNm}</a>
	                                    		<span class='custem_close btn-delete-file' data-id="${file.fileId}" data-name="${file.fileNm}_${file.fileOgNm}">&times;</span>
	                                    	</c:forEach>
		                                </li>
		                                <li class="file">
		                                    <div class="form-ele">
		                                    	<label for="impo" class="fm-label">중요여부</label>
		                                    	<div class="fm-group" style="display: inline;">
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoY" value="Y" <c:if test="${noticeDetailInfo.impoYn eq 'Y' }">checked="checked"</c:if>>
					                                    <label class="fm-check-label" for="impoY">Y</label>
					                                </div>
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoN" value="N" <c:if test="${noticeDetailInfo.impoYn eq 'N' }">checked="checked"</c:if>>
					                                    <label class="fm-check-label" for="impoN">N</label>
					                                </div>
					                            </div>
				                            </div>
		                                </li>
		                                <li class="cont">
		                                    <textarea col="100" row="50" id="boardCtt" name="boardCtt">${noticeDetailInfo.boardCtt }</textarea>
		                                </li>
		                            </ul>
	                            </c:if>
	                        </div>
	                        <!-- 일반사용자 view 화면 -->
	                        <!-- <div class="btn-wrap">
	                        	<a href="javascript:void(0)" id="btn-cancle" class="btns normal fr">목록</a>
	                        </div> -->
	                        <!-- 관리자 write 화면 -->
                            <div class="btn-wrap">
	                            <c:if test="${isInsert }">
	                                <a href="javascript:void(0)" id="btn-insert" class="btns point fl">등록</a>
	                                <a href="javascript:void(0)" id="btn-cancle" class="btns normal fl">취소</a>
                                </c:if>
	                            <c:if test="${isDetail }">
	                                <div class="btn-left">
	                                    <a href="javascript:void(0)" id="btn-update" class="btns point fl">수정</a>
	                                    <a href="javascript:void(0)" id="btn-delete" class="btns gray fl">삭제</a>
	                                </div>
	                                <div class="btn-right">
	                                    <a href="javascript:void(0)" id="btn-cancle" class="btns normal fr">목록</a>
	                                </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
	        </section>
	    </section>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
</html>