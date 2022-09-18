<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>자주묻는질문</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"

	$('#btnSearch').click(function() {
		goPage(1);
	});

	goPage();
});
function goPage(pageNo) {
	$.ajax({
		type: 'get',
		url: '/board/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			console.log(data);
			$('#questions-tbody').html($.templates('#questions-template').render(data));
		}
	});
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="pageSize" value="10">
			<input type="hidden" name="searchBoardGubun" value="02">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea4">
		                    <ul class="tab-menu">
		                        <li><a href="/board/notice/main">공지사항</a></li>
		                        <li class="on"><a href="javascript:void(0)">자주묻는질문</a></li>
		                        <li><a href="/board/info/main">바둑AI소식</a></li>
		                        <li><a href="/board/storage/main">자료실</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>자주묻는질문</h2>
		                            <div class="search-wrap">
		                                <select id="searchKey" name="searchKey" title="검색 구분 선택">
		                                    <option value="01" selected>제목 + 내용</option>
		                                    <option value="02">제목</option>
		                                    <option value="03">내용</option>
		                                </select>
		                                <div class="srch-word">
		                                    <input type="text" id="searchValue" name="searchValue" title="검색어 입력">
		                                    <button id="btnSearch">검색</button>
		                                </div>
		                            </div>
		                            <table class="table-col">
		                                <colgroup>
		                                    <col width="10%">
		                                    <col width="*">
		                                    <col width="10%">
		                                    <col width="10%">
		                                    <col width="10%">
		                                    <col width="13%">
		                                </colgroup>
		                                <thead>
		                                    <tr>
		                                        <th>NO</th>
		                                        <th>제목</th>
		                                        <th>첨부여부</th>
		                                        <th>첨부파일</th>
		                                        <th>등록자</th>
		                                        <th>등록일</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="questions-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap"><div class="pagination"></div></div>
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
<!-- Template 소스 -->
<script type="text/template" id="questions-template">
<tr>
	<td>{{:(#index + 1)}}</td>
	<td class="l-data">{{:boardTit}}</td>
	<td>{{:fileYn}}</td>
	<td>{{if fileYn == 'N'}}-{{else}}<a href="{{:boardFile}}"><img src="/static/images/icon_file.png" alt="첨부파일 다운로드"></a>{{/if}}</td>
	<td>{{:fstCrerNm}}</td>
	<td>{{:fstCreDtm}}</td>
</tr>
</script>
</html>