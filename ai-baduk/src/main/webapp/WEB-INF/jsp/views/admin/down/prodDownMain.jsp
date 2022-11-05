<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>AI 컨텐츠 다운로드</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#btn-select').click(function() {
		goPage(1);
		return false;
	});
	$('#btn-approval').click(function() {
		approval();
		return false;
	});
	$('#btn-add').click(function() {
		let currPage = $('[name=pageSize]').val();
		$('[name=pageSize]').val(Number(currPage) + 10);
		$('[name=pageNo]').val(1);
		$('[name=chnlGubun]').val("MB");
		$.ajax({
			type: 'get',
			url: '/admin/down/prod/select-list',
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
		url: '/admin/down/prod/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			let result = data.result;
			$('#down-tbody').html($.templates('#down-template').render(result.data, {
				setSaleProdPrice: setSaleProdPrice
			}));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 7);
			controlBtnAdd(result);
		}
	});
}

function setSaleProdPrice(data) {
	let saleProdPrice = Number(replaceComma(data.prodPrice)) * ((100 - Number(data.prodDiscountRate)) / 100);
	return saleProdPrice.toLocaleString();
}

function approval() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm('선택한 컨텐츠를 승인하시겠습니까?')) {
		$.ajax({
			type: 'post',
			url: '/admin/down/prod/update-down-status',
			contentType: 'application/json',
			data: JSON.stringify(setData()),
			success: function (data) {
				if (data.result) {
					alert("승인이 정상적으로 이루어졌습니다.");
					goPage(1);
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
function validation() {
	"use strict"
	let checked = $('[id^=chk_]:checked').length;
	if (checked < 1) {
		alert("승인할 컨텐츠를 선택하세요.");
		return true;
	}
	return false;
}
function setData() {
	let data = new Array();
	$('[id^=chk_]:checked').each(function() {
		let param = {};
		let id = $(this).data('id');
		param.menuId =  $('#menuId').val();
		param.prodId = id.split('|')[0];
		param.prodClCd = id.split('|')[1];
		param.downId = id.split('|')[2];
		param.downStatus = '02';
		data.push(param);
	});
	return data;
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="pageSize" value="10">
			<input type="hidden" name="chnlGubun" value="PC">
			<input type="hidden" id="menuId" value="00002">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea7">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
		                        <li><a href="/admin/analyzeInfo/main">분석정보</a></li>
		                        <li><a href="/admin/prod/main">AI 컨텐츠</a></li>
		                        <li class="on"><a href="/admin/down/prod/main">AI 컨텐츠 다운로드</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>AI 컨텐츠 다운로드</h2>
		                            <div class="search-wrap">
		                                <select id="searchKey" name="searchKey" title="검색 구분 선택">
		                                    <option value="prodNm" selected>상품명</option>
		                                    <option value="prodClNm">상품구분</option>
		                                    <option value="user">회원ID (회원명)</option>
		                                    <option value="status">다운로드상태</option>
		                                </select>
		                                <div class="srch-word">
		                                    <input type="text" id="searchValue" name="searchValue" title="검색어 입력">
		                                    <button id="btn-select">검색</button>
		                                </div>
		                            </div>
		                            <table class="table-col down">
		                                <thead>
		                                    <tr>
		                                    	<th>
			                                    	<div class="fm-group">
														<div class="fm-check fm-inline fm-round">
															<input class="fm-check-input" type="checkbox" name="allCheck" id="allCheck">
															<label class="fm-check-label" for="allCheck"></label>
														</div>
													</div>
		                                    	</th>
		                                    	<th class="show-pc">회원ID (회원명)</th>
		                                        <th class="show-pc">메뉴명</th>
		                                        <th class="show-pc">상품구분</th>
		                                        <th>상품명</th>
		                                        <th class="show-pc">상품가격</th>
		                                        <th>승인상태</th>
		                                        <th class="show-pc">등록일</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="down-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap">
		                            	<button type="button" class="btn-more" id="btn-add">더보기</button>
		                            	<div class="pagination"></div>
			                            <div class="btn-right">
		                                    <a href="javascript:void(0)" id="btn-approval" class="btns point btn-role-s">승인</a>
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
<script type="text/template" id="down-template">
<tr>
	<td>
		<div class="fm-group">
			<div class="fm-check fm-inline fm-round">
				<input class="fm-check-input" type="checkbox" id="chk_{{:(#index + 1)}}" data-id="{{:prodId}}|{{:prodClCd}}|{{:downId}}" {{if downStatus != '01'}}style="display:none;" disabled="disabled"{{/if}}>
				<label class="fm-check-label" for="chk_{{:(#index + 1)}}" {{if downStatus != '01'}}style="display:none;" disabled="disabled"{{/if}}></label>
			</div>
		</div>
	</td>
	<td class="show-pc">{{:userId}} ({{:userNm}})</td>
	<td class="show-pc">{{:menuNm}}</td>
	<td class="show-pc">{{:prodClNm}}</td>
	<td class="subject l-data">
		<a href="/admin/prod/detail?prodId={{:prodId}}&prodClCd={{:prodClCd}}">{{:prodNm}}</a>
	</td>
	<td class="r-data subject show-pc">
		{{if prodDiscountRate != '0'}}
			<s>{{:prodPrice}}</s>
			<span><em style="background-color:red;">{{:prodDiscountRate}}%</em> <b>{{:~setSaleProdPrice(#data)}}</b></span>
			{{else}}{{:prodPrice}}
		{{/if}}
	</td>
	<td>{{:downStatusNm}}</td>
	<td class="show-pc">{{:fstCreDtm}}</td>
</tr>
</script>
</html>