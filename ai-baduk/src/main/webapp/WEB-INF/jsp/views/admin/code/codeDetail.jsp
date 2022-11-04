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

	$('#btn-save').click(function() {
		code.save();
	});

	$('#btn-cancle').click(function() {
		window.location.href="/admin/code/main";
	});

	$('#btn-add').click(function() {
		$('#code-tbody').append(code.addHtml());
	});

	code.init();
});

var code = {
	init: function() {
		let codeList = new Array();
		<c:forEach items="${codeList }" var="code">
			<c:if test="${code.codeId ne '*'}">
		    	var code = {};
		    	code.codeId = '${code.codeId }';
		    	code.codeNm = '${code.codeNm }';
		    	code.ref1 = '${code.ref1 }';
		    	code.ref2 = '${code.ref2 }';
		    	code.ref3 = '${code.ref3 }';
		    	code.sortSeq = '${code.sortSeq }';
		    	codeList.push(code);
			</c:if>
		</c:forEach>
		$.each(codeList, function(count, item) {
			let codeHtml = '';
			codeHtml += '<tr>';
			codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="codeId-'+count+'" name="codeId" value="'+item.codeId+'" maxlength="20"/></div></td>';
			codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="codeNm-'+count+'" name="codeNm" value="'+item.codeNm+'"/></div></td>';
			codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="ref1-'+count+'" name="ref1" value="'+item.ref1+'"/></div></td>';
			codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="ref2-'+count+'" name="ref2" value="'+item.ref2+'"/></div></td>';
			codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="ref3-'+count+'" name="ref3" value="'+item.ref3+'"/></div></td>';
			codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="sortSeq-'+count+'" name="sortSeq" value="'+item.sortSeq+'"/></div></td>';
			codeHtml += '</tr>';
			$('#code-tbody').append(codeHtml);
		});
	},
	addHtml: function() {
		let count = $('#code-tbody tr').length;
		let codeHtml = '';
		codeHtml += '<tr>';
		codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="codeId-'+count+'" name="codeId" value="" maxlength="20"/></div></td>';
		codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="codeNm-'+count+'" name="codeNm" value=""/></div></td>';
		codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="ref1-'+count+'" name="ref1" value=""/></div></td>';
		codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="ref2-'+count+'" name="ref2" value=""/></div></td>';
		codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="ref3-'+count+'" name="ref3" value=""/></div></td>';
		codeHtml += 	'<td><div class="fm-group" style="width: 90%;"><input type="text" id="sortSeq-'+count+'" name="sortSeq" value=""/></div></td>';
		codeHtml += '</tr>';
		return codeHtml;
	},
	save: function() {
		if (!code.validate()) {
			return;
		}
		var msg = $('#code_tit span').text();
		if (confirm('공통코드를 '+msg+'하시겠습니까?')) {
			$.ajax({
				type: 'post',
				url: '/admin/code/merge',
				contentType: 'application/json',
				data: JSON.stringify(code.setData()),
				success: function (data) {
					if (data.result) {
						alert('공통코드가 저장되었습니다.');
						window.location.href='/admin/code/detail?lCd='+data.lCd;
					} else {
						alert(data.msg);
					}
				}
			});
		}
	},
	validate: function() {
		if (isNullOrEmpty($('#majorId').val())) {
			alert('상위코드를 입력하세요.');
			$('#majorId').focus();
			return false;
		}
		if ($('#code-tbody tr').length < 1) {
			alert('추가할 공통코드를 입력하세요.');
			return false;
		}
		let flag = true;
		$('#code-tbody tr').each(function(i, item) {
			let codeId = $(item).find(':input[name=codeId]').val();
			let sortSeq = $(item).find(':input[name=sortSeq]').val();
			if (!isNullOrEmpty(codeId) && isNullOrEmpty(sortSeq)) {
				alert('정렬순번을 입력하세요.');
				$(item).find(':input[name=sortSeq]').focus();
				flag = false;
				return false;
			}
		});
		return flag;
	},
	setData: function() {
		let data = {};
		data.majorId = $('#majorId').val().toUpperCase();
		data.majorNm = $('#majorNm').val();
		let codeList = new Array();
		$('#code-tbody tr').each(function(i, item) {
			if (!isNullOrEmpty($(item).find(':input[name=codeId]').val())) {
				let code = new Object();
				code.codeId = $(item).find(':input[name=codeId]').val();
				code.codeNm = $(item).find(':input[name=codeNm]').val();
				code.ref1 = $(item).find(':input[name=ref1]').val();
				code.ref2 = $(item).find(':input[name=ref2]').val();
				code.ref3 = $(item).find(':input[name=ref3]').val();
				code.sortSeq = $(item).find(':input[name=sortSeq]').val();
				codeList.push(code);
			}
		});
		data.codeList = codeList;
		return data;
	}
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<c:set var="isInsert" value="${empty codeList }"></c:set>
			<c:set var="isDetail" value="${not empty codeList }"></c:set>
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea7">
		                    <ul class="tab-menu">
		                        <li class="on"><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
		                        <li><a href="/admin/analyzeInfo/main">분석정보</a></li>
		                        <li><a href="/admin/prod/main">AI 컨텐츠</a></li>
		                        <li><a href="/admin/down/prod/main">AI 컨텐츠 다운로드</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2 id="code_tit">
		                            	공통코드
		                            	<span><c:if test="${isInsert }">등록</c:if></span>
		                            	<span><c:if test="${isDetail }">수정</c:if></span>
		                            </h2>
		                            <div>
		                            	<table>
		                            		<colgroup>
			                                    <col width="8%">
			                                    <col width="15%">
			                                    <col width="9%">
			                                    <col width="40%">
			                                </colgroup>
		                            		<tbody>
		                            			<tr>
		                            				<th>상위코드</th>
		                            				<c:if test="${isInsert }">
		                            					<td>
		                            						<div class="fm-group" style="width: 90%;">
		                            							<input type="text" id="majorId" name="majorId" title="상위코드" value="${upCodeVo.majorId }" maxlength="5" style="text-transform: uppercase;"/>
		                            						</div>
		                            					</td>
		                            				</c:if>
		                            				<c:if test="${isDetail }">
		                            					<input type="hidden" id="majorId" value="${upCodeVo.majorId }">
		                            					<td class="l-data">${upCodeVo.majorId }</td>
		                            				</c:if>
		                            				<th>상위코드명</th>
		                            				<td>
	                            						<div class="fm-group" style="width: 90%;">
	                            							<input type="text" id="majorNm" name="majorNm" title="상위코드" value="${upCodeVo.codeNm }" maxlength="20">
	                            						</div>
	                            					</td>
		                            			</tr>
		                            		</tbody>
		                            	</table>
		                            </div>
		                            <div class="btn-wrap">
                                    	<a href="javascript:void(0)" id="btn-add" class="btns point btn-role-s fr">추가</a>
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
		                                <tbody id="code-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap">
		                            	<div class="pagination"></div>
			                            <div class="btn-right">
		                                    <a href="javascript:void(0)" id="btn-save" class="btns point btn-role-s">저장</a>
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