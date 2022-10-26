<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<title>공통코드 상세</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#prodCtt').summernote({
        height: 300
	});

	$('#btn-save').click(function() {
		product.insert();
	});

	$('#btn-cancle').click(function() {
		window.location.href="/admin/product/main";
	});

	$('#btn-file').click(function() {
		$('#uploadFile').click();
		return false;
	});

	$('#uploadFile').change(function() {
		let file = new Array();
		for (let i=0; i<this.files.length; i++) {
			file.push(this.files[i].name);
		}
		$('#prodFile').val(file.join(', '));
	});

	product.init();
});

var product = {
	init: function() {

	},
	insert: function() {
		"use strict"
		if (!ai.isValidate($('#form'))) {
			return;
		}
		if (confirm("컨텐츠를 등록하시겠습니까?")) {
			let formData = new FormData();
			let inputFile = $('#uploadFile');
			let files = inputFile[0].files;

			for (let i=0; i<files.length; i++) {
				formData.append("uploadFiles", files[i]);
			}
			formData.append('prodNm', $('#prodNm').val());
			formData.append('prodClCd', $('#prodClCd').val());
			formData.append('displayYn', $('input:radio[name=displayYn]:checked').val());
			formData.append('prodDiscountRate', $('#prodDiscountRate').val());
			formData.append('prodMarket', $('#prodMarket').val());
			formData.append('prodPrice', $('#prodPrice').val());
			formData.append('prodCtt', $('#prodCtt').val());

			$.ajax({
				type: 'post',
				url: '/admin/product/insert',
				processData: false,
				contentType: false,
				data: formData,
				success: function (data) {
					if (data.result) {
						alert('컨텐츠가 등록되었습니다.');
						//window.location.href='/admin/product/detail?prodId='+data.productVo.prodId+'&prodClCd='+data.productVo.prodClCd;
					} else {
						alert(data.msg);
					}
				}
			});
		}
	}
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="form">
			<c:set var="isInsert" value="${empty prodList }"></c:set>
			<c:set var="isDetail" value="${not empty prodList }"></c:set>
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea6">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
		                        <li><a href="/admin/analyzeInfo/main">분석정보</a></li>
		                        <li class="on"><a href="/admin/product/main">컨텐츠</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>컨텐츠 상세</h2>
		                            <ul class="write-box">
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">컨텐츠명</label><input type="text" id="prodNm" name="prodNm" required></span>
		                                </li>
		                                <li class="tit">
											<span class="form-ele">
		                                    	<label for="tit">상품구분</label>
				                            	<select id="prodClCd" name="prodClCd">
										            <c:forEach items="${codeCU005 }" var="item">
														<option value="${item.codeId }">${item.codeNm }</option>
				                                   	</c:forEach>
									            </select>
		                                    </span>
		                                </li>
		                                <li class="file">
		                                    <span class="form-ele">
		                                    	<label for="file">컨텐츠파일</label><input type="text" id="prodFile" name="prodFile" readonly="readonly"><button class="btns" id="btn-file">찾아보기</button>
		                                    	<input type="file" id="uploadFile" name="uploadFile" multiple style="display: none;">
		                                    </span>
		                                </li>
		                                <li class="file">
		                                    <div class="form-ele">
		                                    	<label for="impo" class="fm-label">전시여부</label>
		                                    	<div class="fm-group" style="display: inline;">
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="displayYn" id="displayY" value="Y" checked="checked">
					                                    <label class="fm-check-label" for="displayY">Y</label>
					                                </div>
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="displayYn" id="displayN" value="N">
					                                    <label class="fm-check-label" for="displayN">N</label>
					                                </div>
					                            </div>
				                            </div>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">상품할인율</label><input type="text" id="prodDiscountRate" name="prodDiscountRate"></span>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">상품판매처</label><input type="text" id="prodMarket" name="prodMarket"></span>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">상품가격</label><input type="text" id="prodPrice" name="prodPrice"></span>
		                                </li>
		                                <li class="cont">
		                                    <textarea col="100" row="50" id="prodCtt" name="prodCtt"></textarea>
		                                </li>
		                            </ul>
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