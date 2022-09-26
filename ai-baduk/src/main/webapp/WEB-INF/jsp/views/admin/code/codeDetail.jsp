<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>공통코드 상세</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"

	$('#btn-insert').click(function() {
		codeUpdate();
	});

	$('#btn-cancle').click(function() {
		window.location.href="/admin/code/main";
	});

	$('#btn-add').click(function() {
		let codeHtml = '';

		codeHtml += '<tr>';
		codeHtml += '<td><input type="text" value="" style="width:95%"/></td>';
		codeHtml += '<td class="l-data"><input type="text" value="" style="width:95%"/></td>';
		codeHtml += '<td><input type="text" value="" style="width:95%"/></td>';
		codeHtml += '<td><input type="text" value="" style="width:95%"/></td>';
		codeHtml += '<td><input type="text" value="" style="width:95%"/></td>';
		codeHtml += '<td><input type="text" value="" style="width:95%"/></td>';
		codeHtml += '</tr>';

		$('#code-tbody').append(codeHtml);
	});
});

/**
 * 공통코드 수정
 */
function codeUpdate() {
	"use strict"
	if (confirm('공통코드를 수정하시겠습니까?')) {
		let upperCodeId = $('#upperCodeId').val();
		let upperCodeNm = $('#upperCodeNm').val();
		let codeList = new Array();
		$('#code-tbody > tr').each(function(i, item) {
			let code = new Object();
			code.codeId = $(this).text();
			code.codeNm = $(this).find('input id^=codeNm').val();
			code.ref1 = $(this).find('input').val();
			code.ref2 = $(this).find('input').val();
			code.ref3 = $(this).find('input').val();
			code.sortSeq = $(this).find('input').val();
			codeList.push(code);
		});
	}
}
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<c:set var="isInsert" value="${empty codeList }"></c:set>
			<c:set var="isDetail" value="${not empty codeList }"></c:set>
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea4">
		                    <ul class="tab-menu">
		                        <li class="on"><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/signUp">회원가입</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>공통코드</h2>
		                            <div>
		                            	<table>
		                            		<colgroup>
			                                    <col width="10%">
			                                    <col width="15%">
			                                    <col width="10%">
			                                    <col width="40%">
			                                    <col width="*">
			                                </colgroup>
		                            		<tbody>
		                            			<tr>
		                            				<th>상위코드</th>
		                            				<c:if test="${isInsert }">
		                            					<td class="l-data"><input type="text" id="upperCodeId" value="${upCodeVo.upperCodeId }" style="width:95%"/></td>
		                            				</c:if>
		                            				<c:if test="${isDetail }">
		                            					<input type="hidden" id="upperCodeId" value="${upCodeVo.upperCodeId }">
		                            					<td class="l-data">${upCodeVo.upperCodeId }</td>
		                            				</c:if>
		                            				<th>상위코드명</th>
		                            				<td><input type="text" id="upperCodeNm" value="${upCodeVo.codeNm }" style="width:95%"/></td>
		                            				<td>
					                                    <a href="javascript:void(0)" id="btn-add" class="btns point btn-role-s">추가</a>
		                            				</td>
		                            			</tr>
		                            		</tbody>
		                            	</table>
		                            </div>
		                            <table class="table-col">
		                                <colgroup>
		                                    <col width="10%">
		                                    <col width="*">
		                                    <col width="13%">
		                                    <col width="13%">
		                                    <col width="13%">
		                                    <col width="10%">
		                                </colgroup>
		                                <thead>
		                                    <tr>
		                                        <th>하위코드ID</th>
		                                        <th>하위코드명</th>
		                                        <th>비고1</th>
		                                        <th>비고2</th>
		                                        <th>비고3</th>
		                                        <th>정렬순번</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="code-tbody">
		                                	<c:forEach items="${codeList }" var="code" varStatus="status">
			                                	<c:if test="${code.codeId ne '*'}">
				                                	<tr>
														<td>${code.codeId }</td>
														<td class="l-data"><input type="text" id="codeNm${status.index }" value="${code.codeNm }" style="width:95%"/></td>
														<td><input type="text" id="ref1${status.index }" value="${code.ref1 }" style="width:95%"/></td>
														<td><input type="text" id="ref2${status.index }" value="${code.ref2 }" style="width:95%"/></td>
														<td><input type="text" id="ref3${status.index }" value="${code.ref3 }" style="width:95%"/></td>
														<td><input type="text" id="sortSeq${status.index }" value="${code.sortSeq }" style="width:95%"/></td>
				                                	</tr>
			                                	</c:if>
		                                    </c:forEach>
		                                </tbody>
		                            </table>
		                            <div class="btn-wrap">
		                            	<div class="pagination"></div>
			                            <div class="btn-right">
		                                    <a href="javascript:void(0)" id="btn-insert" class="btns point btn-role-s">저장</a>
		                                    <a href="javascript:void(0)" id="btn-cancle" class="btns gray">취소</a>
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
</html>