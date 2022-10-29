<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>AI컨텐츠 상세</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"

	$('#btn-cancle').click(function() {
		window.location.href="/product/main";
	});

	$('#btn-buy').click(function() {
		product.buy();
	});

	product.init();
});

var product = {
	init: function() {
		let prodPrice = $('#prodPrice').val();
		let prodDiscountRate = $('#prodDiscountRate').val();
		let saleProdPrice = Number(replaceComma(prodPrice)) * ((100 - Number(prodDiscountRate)) / 100);
		$('#saleProdPrice').text(saleProdPrice.toLocaleString());
	},
	buy: function() {

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
		                <div class="tab-wrap ea1">
		                    <ul class="tab-menu">
		                        <li class="on"><a href="/product/main">AI컨텐츠</a></li>
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
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">상품판매처</label><input type="text" id="prodMarket" name="prodMarket" value="${productDetailInfo.prodMarket }"></span>
		                                </li>
		                                <li class="tit">
		                                    <span class="form-ele subject">
		                                    	<label for="tit">상품가격</label>
		                                    	<input type="hidden" id="prodDiscountRate" value="${productDetailInfo.prodDiscountRate }">
		                                    	<input type="hidden" id="prodPrice" value="${productDetailInfo.prodPrice }">
		                                    	<c:if test="${productDetailInfo.prodDiscountRate ne '0' }">
		                                    		<s>${productDetailInfo.prodPrice }</s>
		                                    		<span><em style="background-color:red;">${productDetailInfo.prodDiscountRate }%</em> <b id="saleProdPrice"></b>원</span>
		                                    	</c:if>
		                                    	<c:if test="${productDetailInfo.prodDiscountRate eq '0' }">
			                                    	${productDetailInfo.prodPrice }원
		                                    	</c:if>
		                                    </span>
		                                </li>
		                                <li class="cont">
		                                    ${productDetailInfo.prodCtt }
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