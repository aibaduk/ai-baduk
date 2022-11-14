<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>AI 컨텐츠 메인</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#btn-select').click(function() {
		goPage(1);
		return false;
	});
	$('#btn-add').click(function() {
		let currPage = $('[name=pageSize]').val();
		$('[name=pageSize]').val(Number(currPage) + 10);
		$('[name=pageNo]').val(1);
		$('[name=chnlGubun]').val("MB");
		$.ajax({
			type: 'get',
			url: '/prod/select-list',
			data: $('#searchForm').serialize(),
			success: function (data) {
				let result = data.result;
				$(tbody).html($.templates(template).render(result.data, {
					setSaleProdPrice: setSaleProdPrice
				}));
				$('#allCheck').prop('checked', false);
				controlBtnAdd(result);
			}
		});
		return false;
	});

	goPage(1);
});

/**
 * 더보기 버튼 제어
 * @param {object} result 조회 데이터
 */
function controlBtnAdd(result) {
	"use strict"
	let width = $(window).width();
	if (width >= 751) {
		$('.btn-more').css('display', 'none');
	} else {
		$('.pagination').hide();
		let pageSize = $('[name=pageSize]').val();
		if (pageSize >= result.pageInfo.totalCount) {
			$('.btn-more').css('display', 'none');
		} else {
			$('.btn-more').css('display', 'block');
		}
	}
}

/**
 * 공통코드 조회
 * @param {int} pageNo 페이지번호
 */
function goPage(pageNo) {
	"use strict"
	$('[name=pageSize]').val(10);
	$('[name=chnlGubun]').val("PC");
	$('[name=pageNo]').val(pageNo);
	$.ajax({
		type: 'get',
		url: '/prod/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			let result = data.result;
			$('#prod-tbody').html($.templates('#prod-template').render(result.data, {
				setSaleProdPrice: setSaleProdPrice
			}));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 8);
			controlBtnAdd(result);
		}
	});
}

function setSaleProdPrice(data) {
	let saleProdPrice = Number(replaceComma(data.prodPrice)) * ((100 - Number(data.prodDiscountRate)) / 100);
	return saleProdPrice.toLocaleString();
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="pageSize" value="10">
			<input type="hidden" name="chnlGubun" value="PC">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap">
		                    <ul class="tab-menu"></ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>AI컨텐츠</h2>
		                            <div class="search-wrap">
		                                <select id="searchKey" name="searchKey" title="검색 구분 선택">
		                                    <option value="prodNm" selected>상품명</option>
		                                    <option value="prodClNm">상품구분</option>
		                                </select>
		                                <div class="srch-word">
		                                    <input type="text" id="searchValue" name="searchValue" title="검색어 입력">
		                                    <button id="btn-select">검색</button>
		                                </div>
		                            </div>
		                            <table class="table-col prod">
		                                <thead>
		                                    <tr>
		                                    	<th>번호</th>
		                                        <th>상품구분</th>
		                                        <th>상품명</th>
		                                        <th class="show-pc">상품가격</th>
		                                        <th class="show-pc">판매처</th>
		                                        <th class="show-pc">등록일</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="prod-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap">
		                            	<button type="button" class="btn-more" id="btn-add">더보기</button>
		                            	<div class="pagination"></div>
			                            <!-- <div class="btn-right">
		                                    <a href="javascript:void(0)" id="btn-insert" class="btns point btn-role-s">등록</a>
		                                </div> -->
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
<script type="text/template" id="prod-template">
<tr>
	<td>{{:rowId}}</td>
	<td>{{:prodClNm}}</td>
	<td class="subject l-data">
		<a href="/prod/detail?prodId={{:prodId}}&prodClCd={{:prodClCd}}">{{:prodNm}}
			{{if newYn == 'Y'}}<span><em>new</em></span>{{/if}}
		</a>
	</td>
	<td class="show-pc r-data subject">
		{{if prodDiscountRate != '0'}}
			<s>{{:prodPrice}}</s>
			<span><em style="background-color:red;">{{:prodDiscountRate}}%</em> <b>{{:~setSaleProdPrice(#data)}}</b></span>
			{{else}}{{:prodPrice}}
		{{/if}}
	</td>
	<td class="show-pc l-data">{{:prodMarket}}</td>
	<td class="show-pc">{{:fstCreDtm}}</td>
</tr>
</script>
</html>