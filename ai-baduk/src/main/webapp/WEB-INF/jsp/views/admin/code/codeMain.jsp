<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>공통코드 메인</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#btn-select').click(function() {
		goPage(1);
		return false;
	});
	$('#btn-insert').click(function() {
		window.location.href="/admin/code/insert";
	});

	goPage(1);
});

/**
 * 공통코드 조회
 * @param {int} pageNo 페이지번호
 */
function goPage(pageNo) {
	"use strict"
	$('[name=pageNo]').val(pageNo);
	$.ajax({
		type: 'get',
		url: '/admin/code/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			let result = data.result;
			$('#code-tbody').html($.templates('#code-template').render(result.data));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 8);
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
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea5">
		                    <ul class="tab-menu">
		                        <li class="on"><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="javascript:void(0)">사용자관리</a></li>
		                        <li><a href="javascript:void(0)">분석정보</a></li>
		                        <li><a href="/admin/signUp">회원가입</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>공통코드</h2>
		                            <div class="search-wrap">
		                                <select id="searchKey" name="searchKey" title="검색 구분 선택">
		                                    <option value="lCd" selected>공통코드ID</option>
		                                    <option value="codeNm">공통코드명</option>
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
		                                    <col width="10%">
		                                    <col width="13%">
		                                </colgroup>
		                                <thead>
		                                    <tr>
		                                    	<th>번호</th>
		                                        <th>상위코드ID</th>
		                                        <th>상위코드명</th>
		                                        <th>비고1</th>
		                                        <th>비고2</th>
		                                        <th>비고3</th>
		                                        <th>등록자</th>
		                                        <th>등록일</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="code-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap">
		                            	<div class="pagination"></div>
			                            <div class="btn-right">
		                                    <a href="javascript:void(0)" id="btn-insert" class="btns point btn-role-s">등록</a>
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
<script type="text/template" id="code-template">
<tr>
	<td>{{:rowId}}</td>
	<td>{{:lcd}}</td>
	<td class="subject"><a href="/admin/code/detail?lCd={{:lcd}}">{{:codeNm}}</a></td>
	<td>{{:ref1}}</td>
	<td>{{:ref2}}</td>
	<td>{{:ref3}}</td>
	<td>{{:fstCrerNm}}</td>
	<td>{{:fstCreDtm}}</td>
</tr>
</script>
</html>