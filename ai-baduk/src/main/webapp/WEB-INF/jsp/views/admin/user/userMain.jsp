<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>사용자관리 메인</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#btn-select').click(function() {
		goPage(1);
		return false;
	});
	$('#btn-insert').click(function() {
		window.location.href="/admin/signUp";
	});

	goPage(1);
});

/**
 * 사용자관리 조회
 * @param {int} pageNo 페이지번호
 */
function goPage(pageNo) {
	"use strict"
	$('[name=pageNo]').val(pageNo);
	$.ajax({
		type: 'get',
		url: '/admin/user/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			let result = data.result;
			$('#user-tbody').html($.templates('#user-template').render(result.data));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 8);
		}
	});
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="pageSize" value="10">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea4">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li class="on"><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/signUp">회원가입</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>사용자관리</h2>
		                            <div class="search-wrap">
		                                <select id="searchKey" name="searchKey" title="검색 구분 선택">
		                                    <option value="userId" selected>사용자ID</option>
		                                    <option value="userNm">사용자명</option>
		                                </select>
		                                <div class="srch-word">
		                                    <input type="text" id="searchValue" name="searchValue" title="검색어 입력">
		                                    <button id="btn-select">검색</button>
		                                </div>
		                            </div>
		                            <table class="table-col user">
		                                <!-- <colgroup>
		                                    <col width="5%">
		                                    <col width="10%">
		                                    <col width="*">
		                                    <col width="10%">
		                                    <col width="10%">
		                                    <col width="10%">
		                                    <col width="10%">
		                                    <col width="13%">
		                                </colgroup> -->
		                                <thead>
		                                    <tr>
		                                    	<th>번호</th>
		                                        <th>회원ID</th>
		                                        <th>회원명</th>
		                                        <th class="show-pc">성별</th>
		                                        <th class="show-pc">권한</th>
		                                        <th class="show-pc">회원등급</th>
		                                        <th class="show-pc">등록자</th>
		                                        <th>등록일</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="user-tbody"></tbody>
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
<script type="text/template" id="user-template">
<tr>
	<td>{{:rowId}}</td>
	<td class="subject"><a href="/admin/user/detail?userId={{:userId}}">{{:userId}}</a></td>
	<td class="l-data">{{:userNm}}</td>
	<td class="show-pc">{{:userSexNm}}</td>
	<td class="show-pc">{{:userAuth}}</td>
	<td class="show-pc">{{:userGradeNm}}</td>
	<td class="show-pc">{{:fstCrerNm}}</td>
	<td>{{:fstCreDtm}}</td>
</tr>
</script>
</html>