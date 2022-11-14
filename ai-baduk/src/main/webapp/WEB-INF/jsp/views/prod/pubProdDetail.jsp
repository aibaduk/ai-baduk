<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>AI 컨텐츠 상세</title>
</head>
<sec:authentication var="user" property="principal"/>
<script type="text/javascript">
$(function() {
	"use strict"

	$('#btn-cancle').click(function() {
		window.location.href="/prod/main";
	});

	$('#btn-buy').click(function() {
		prod.buy();
	});

	prod.init();
});

var prod = {
	init: function() {
		let prodPrice = $('#prodPrice').val();
		let prodDiscountRate = $('#prodDiscountRate').val();
		let saleProdPrice = Number(replaceComma(prodPrice)) * ((100 - Number(prodDiscountRate)) / 100);
		$('#saleProdPrice').text(saleProdPrice.toLocaleString());
	},
	buy: function() {
		if ('${user}' == 'anonymousUser') {
			if (confirm("컨텐츠 구매는 로그인이 필요합니다.\n로그인 화면으로 이동하시겠습니까?")) {
				window.location.href='/';
			}
		} else {
			let prodNm = $('#prodNm').val();
			if (confirm(prodNm + "를 구매하시겠습니까?\n구매한 컨텐츠는 AI 컨텐츠 다운로드에서 확인하실 수 있습니다.")) {
				$.ajax({
					type: 'post',
					url: '/down/prod/insert',
					data: $('#form').serialize(),
					success: function (data) {
						if (data.result) {
							alert(prodNm + '를 정상적으로 구매하였습니다.');
							window.location.href='/down/prod/main';
						} else {
							alert(data.msg);
						}
					}
				});
			}
		}
	}
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="form">
			<c:set var="isInsert" value="${empty prodDetailInfo }"></c:set>
			<c:set var="isDetail" value="${not empty prodDetailInfo }"></c:set>
			<input type="hidden" id="menuId" name="menuId" value="00002"/>
			<input type="hidden" id="prodId" name="prodId" value="${prodDetailInfo.prodId }">
			<input type="hidden" id="prodId" name="prodClCd" value="${prodDetailInfo.prodClCd }">
           	<input type="hidden" id="prodDiscountRate" name="prodDiscountRate" value="${prodDetailInfo.prodDiscountRate }">
			<input type="hidden" id="prodNm" name="prodNm" value="${prodDetailInfo.prodNm }"/>
           	<input type="hidden" id="prodPrice" name="prodPrice" value="${prodDetailInfo.prodPrice }">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap">
		                    <ul class="tab-menu"></ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>컨텐츠 상세</h2>
		                            <ul class="write-box">
		                                <li class="tit">
			                                <span class="form-ele"><label for="tit">컨텐츠명</label>${prodDetailInfo.prodNm }</span>
		                                </li>
		                                <li class="tit">
											<span class="form-ele"><label for="tit">상품구분</label>${prodDetailInfo.prodClNm }</span>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">상품판매처</label>${prodDetailInfo.prodMarket }</span>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele subject">
		                                    	<label for="tit">상품가격</label>
		                                    	<c:if test="${prodDetailInfo.prodDiscountRate ne '0' }">
		                                    		<s>${prodDetailInfo.prodPrice }</s>
		                                    		<span><em style="background-color:red;">${prodDetailInfo.prodDiscountRate }%</em> <b id="saleProdPrice"></b>원</span>
		                                    	</c:if>
		                                    	<c:if test="${prodDetailInfo.prodDiscountRate eq '0' }">
			                                    	${prodDetailInfo.prodPrice }원
		                                    	</c:if>
		                                    </span>
		                                </li>
		                                <li class="cont">
		                                    ${prodDetailInfo.prodCtt }
		                                </li>
		                            </ul>
		                            <div class="btn-wrap">
		                            	<div class="pagination"></div>
			                            <div class="btn-right">
		                                    <a href="javascript:void(0)" id="btn-buy" class="btns point btn-role-s">구매</a>
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