<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>공지사항</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"

	$('#btn-select').click(function() {
		goPage(1);
		return false;
	});

	$('#btn-insert').click(function() {
		window.location.href="/board/notice/insert";
	});

	$('#btn-delete').click(function() {
		noticeDelete();
		return false;
	});

	$(document).on('click', '.file-zip-download', function() {
		noticeZipFileDownload($(this).data('id'));
	});

	goPage(1);
});

/**
 * 공지사항 조회
 * @param {int} pageNo 페이지번호
 */
function goPage(pageNo) {
	"use strict"
	$('[name=pageNo]').val(pageNo);
	$.ajax({
		type: 'get',
		url: '/board/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			let result = data.result;
			$('#notice-tbody').html($.templates('#notice-template').render(result.data));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 7);
		}
	});
}

/**
 * 공지사항 zip 파일 다운로드
 */
function noticeZipFileDownload(boardId) {
	"use strict"
	if (confirm('파일을 다운로드하시겠습니까?')) {
		let boardGubun = $('input:hidden[name=searchBoardGubun]').val();
		window.location.href='/board/notice/zipFileDownload?boardId='+boardId+'&boardGubun='+boardGubun;
	}
}
/**
 * 공지사항 삭제
 */
function noticeDelete() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm('공지사항을 삭제하시겠습니까?')) {
		$.ajax({
			type: 'post',
			url: '/board/notice/delete',
			contentType: 'application/json',
			data: JSON.stringify(setData()),
			success: function (data) {
				if (data.result) {
					alert('공지사항이 삭제되었습니다.');
					goPage(1);
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
function validation() {
	"use strict"
	let checked = $('[id^=chk_]:checked').length;
	if (checked < 1) {
		alert('삭제할 공지사항을 선택하세요.');
		return true;
	}
	return false;
}
function setData() {
	let data = new Array();
	$('[id^=chk_]:checked').each(function(i, item) {
		let param = {};
		let boardGubun = $('input:hidden[name=searchBoardGubun]').val();
		let boardId = $(this).data('id');
		param.boardGubun = boardGubun;
		param.boardId = boardId;
		data.push(param);
	});
	return data;
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="pageSize" value="10">
			<input type="hidden" name="searchBoardGubun" value="01">
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
		                            <div class="search-wrap">
		                                <select id="searchKey" name="searchKey" title="검색 구분 선택">
		                                    <option value="01" selected>제목 + 내용</option>
		                                    <option value="02">제목</option>
		                                    <option value="03">내용</option>
		                                </select>
		                                <div class="srch-word">
		                                    <input type="text" id="searchValue" name="searchValue" title="검색어 입력">
		                                    <button id="btn-select">검색</button>
		                                </div>
		                            </div>
		                            <table class="table-col">
		                                <colgroup>
		                                    <col width="5%">
		                                    <col width="10%">
		                                    <col width="*">
		                                    <col width="10%">
		                                    <col width="10%">
		                                    <col width="10%">
		                                    <col width="13%">
		                                </colgroup>
		                                <thead>
		                                    <tr>
		                                    	<th><input type="checkbox" id="allCheck"><label for="allCheck"></label></th>
		                                        <th>NO</th>
		                                        <th>제목</th>
		                                        <th>첨부여부</th>
		                                        <th>첨부파일</th>
		                                        <th>등록자</th>
		                                        <th>등록일</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="notice-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap">
		                            	<div class="pagination"></div>
			                            <div class="btn-right">
		                                    <a href="javascript:void(0)" id="btn-insert" class="btns point btn-role-s">등록</a>
		                                    <a href="javascript:void(0)" id="btn-delete" class="btns gray btn-role-d">삭제</a>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </section>
		    </section>
		</form>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
<!-- Template 소스 {{:boardGubun}}-->
<script type="text/template" id="notice-template">
<tr {{if impoYn == 'Y'}}class="hot"{{/if}}>
	<td><input type="checkbox" id="chk_{{:(#index + 1)}}" data-id="{{:boardId}}"><label for="chk_{{:(#index + 1)}}"></label></td>
	<td>{{if impoYn == 'Y'}}HOT{{else}}{{:rowId}}{{/if}}</td>
	<td class="l-data subject"><a href="/board/notice/detail?boardGubun=01&boardId={{:boardId}}">{{:boardTit}}{{if newYn == 'Y'}}<em>new</em>{{/if}}</a></td>
	<td>{{:fileYn}}</td>
	<td>{{if fileYn == 'N'}}-{{else}}<a href="javascript:void(0)" class="file-zip-download" data-id="{{:boardId}}"><img src="/static/images/icon_file.png" alt="첨부파일 다운로드"></a>{{/if}}</td>
	<td>{{:fstCrerNm}}</td>
	<td>{{:fstCreDtm}}</td>
</tr>
</script>
</html>