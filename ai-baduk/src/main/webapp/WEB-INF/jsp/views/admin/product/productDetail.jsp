<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	<title>AI컨텐츠관리 상세</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#prodCtt').summernote({
        height: 300
	});

	$('#btn-insert').click(function() {
		product.insert();
	});

	$('#btn-update').click(function() {
		product.update();
	});

	$('#btn-cancle').click(function() {
		window.location.href="/admin/product/main";
	});

	$('#btn-file').click(function() {
		$('#uploadFile').click();
		return false;
	});

	$('.btn-delete-file').click(function() {
		product.fileDelete($(this));
	});

	$('.file-download').click(function() {
		product.fileDownload($(this));
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
			formData.append('prodPrice', replaceComma($('#prodPrice').val()));
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
						window.location.href='/admin/product/detail?prodId='+data.productVo.prodId+'&prodClCd='+data.productVo.prodClCd;
					} else {
						alert(data.msg);
					}
				}
			});
		}
	},
	update: function() {
		if (!ai.isValidate($('#form'))) {
			return;
		}
		if (confirm("컨텐츠를 수정하시겠습니까?")) {
			let formData = new FormData();
			let inputFile = $('#uploadFile');
			let files = inputFile[0].files;

			for (let i=0; i<files.length; i++) {
				formData.append("uploadFiles", files[i]);
			}
			formData.append('prodId', $('#prodId').val());
			formData.append('prodNm', $('#prodNm').val());
			formData.append('prodClCd', $('#prodClCd').val());
			formData.append('displayYn', $('input:radio[name=displayYn]:checked').val());
			formData.append('prodDiscountRate', $('#prodDiscountRate').val());
			formData.append('prodMarket', $('#prodMarket').val());
			formData.append('prodPrice', replaceComma($('#prodPrice').val()));
			formData.append('prodCtt', $('#prodCtt').val());

			$.ajax({
				type: 'post',
				url: '/admin/product/update',
				processData: false,
				contentType: false,
				data: formData,
				success: function (data) {
					if (data.result) {
						alert('컨텐츠가 수정되었습니다.');
						window.location.href='/admin/product/detail?prodId='+data.productVo.prodId+'&prodClCd='+data.productVo.prodClCd;
					} else {
						alert(data.msg);
					}
				}
			});
		}
	},
	fileDelete: function(file) {
		if (confirm('파일을 삭제하시겠습니까?')) {
			let prodClCd = $('#prodClCd').val();
			let prodId = $('input:hidden[name=prodId]').val();
			let param = {
				menuId: '00002',
				targetGubun: prodClCd,
				targetId: prodId,
				fileId: file.data('id'),
				fileNm: file.data('name')
			}
			$.ajax({
				type: 'post',
				url: '/admin/product/fileDelete',
				contentType: 'application/json',
				data: JSON.stringify(param),
				success: function (data) {
					if (data.result) {
						alert('파일이 삭제되었습니다.');
						window.location.href='/admin/product/detail?prodId='+prodId+'&prodClCd='+prodClCd;
					} else {
						alert(data.msg);
					}
				}
			});
		}
	},
	fileDownload: function(file) {
		if (confirm('파일을 다운로드하시겠습니까?')) {
			let targetId = $('input:hidden[name=prodId]').val();
			let targetGubun = $('#prodClCd').val();
			let fileNm = file.data('name');
			let fileOgNm = file.text();
			window.location.href='/admin/product/fileDownload?menuId=00002&targetId='+targetId+'&targetGubun='+targetGubun+'&fileNm='+fileNm+'&fileOgNm='+fileOgNm;
		}
	}
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="form">
			<c:set var="isInsert" value="${empty productDetailInfo }"></c:set>
			<c:set var="isDetail" value="${not empty productDetailInfo }"></c:set>
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
		                                    <span class="form-ele"><label for="tit">컨텐츠명</label><input type="text" id="prodNm" name="prodNm" value="${productDetailInfo.prodNm }" required></span>
		                                    <input type="hidden" id="prodId" name="prodId" value="${productDetailInfo.prodId }">
		                                </li>
		                                <li class="tit">
											<span class="form-ele">
		                                    	<label for="tit">상품구분</label>
				                            	<select id="prodClCd" name="prodClCd">
										            <c:forEach items="${codeCU005 }" var="item">
														<option value="${item.codeId }" <c:if test="${productDetailInfo.prodClCd eq item.codeId }">selected</c:if>>${item.codeNm }</option>
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
		                                <li class="file_text">
		                                    <c:forEach items="${productDetailInfo.fileList }" var="file">
	                                    		<a href="javascript:void(0)" class="file-download" data-name="${file.fileNm}_${file.fileOgNm}">${file.fileOgNm}</a>
	                                    		<span class='custem_close btn-delete-file' data-id="${file.fileId}" data-name="${file.fileNm}_${file.fileOgNm}">&times;</span>
	                                    	</c:forEach>
		                                </li>
		                                <li class="file">
		                                    <div class="form-ele">
		                                    	<label for="impo" class="fm-label">전시여부</label>
		                                    	<div class="fm-group" style="display: inline;">
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="displayYn" id="displayY" value="Y" <c:if test="${empty productDetailInfo or productDetailInfo.displayYn eq 'Y' }">checked="checked"</c:if>>
					                                    <label class="fm-check-label" for="displayY">Y</label>
					                                </div>
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="displayYn" id="displayN" value="N" <c:if test="${productDetailInfo.displayYn eq 'N' }">checked="checked"</c:if>>
					                                    <label class="fm-check-label" for="displayN">N</label>
					                                </div>
					                            </div>
				                            </div>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">상품할인율</label><input type="text" id="prodDiscountRate" name="prodDiscountRate" value="${productDetailInfo.prodDiscountRate }"></span>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">상품판매처</label><input type="text" id="prodMarket" name="prodMarket" value="${productDetailInfo.prodMarket }"></span>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">상품가격</label><input type="text" id="prodPrice" name="prodPrice" value="${productDetailInfo.prodPrice }"></span>
		                                </li>
		                                <li class="cont">
		                                    <textarea col="100" row="50" id="prodCtt" name="prodCtt">${productDetailInfo.prodCtt }</textarea>
		                                </li>
		                            </ul>
		                            <div class="btn-wrap">
		                            	<div class="pagination"></div>
			                            <div class="btn-right">
		                                    <c:if test="${isInsert }"><a href="javascript:void(0)" id="btn-insert" class="btns point btn-role-s">등록</a></c:if>
		                                    <c:if test="${isDetail }"><a href="javascript:void(0)" id="btn-update" class="btns point btn-role-s">수정</a></c:if>
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