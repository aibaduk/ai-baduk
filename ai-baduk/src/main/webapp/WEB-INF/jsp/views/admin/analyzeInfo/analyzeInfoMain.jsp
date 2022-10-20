<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>분석정보 메인</title>
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
			url: '/admin/analyzeInfo/select-list',
			data: $('#searchForm').serialize(),
			success: function (data) {
				let result = data.result;
				$(tbody).html($.templates(template).render(result.data));
				$('#allCheck').prop('checked', false);
				controlBtnAdd(result);
			}
		});
		return false;
	});
	$('#btn-insert').click(function() {
		window.location.href="/admin/analyzeInfo/insert";
	});
	$('#btn-delete').click(function() {
		fnDelete();
		return false;
	});
	$('#btn-excel-download').click(function() {
		if (confirm('분석정보 샘플 다운로드하시겠습니까?')) {
			let frm = $("#frmExcelDown");
			frm.attr("action", "/admin/analyzeInfo/sample-download");
			frm.submit();
		}
		return false;
	});
	$('#btn-file').click(function() {
		$('#file').click();
		return false;
	});
	$('#file').change(function() {
		$('#fileNm').val(this.files[0].name);
	});
	$('#btn-upload').click(function() {
		if (isNullOrEmpty($('#fileNm').val())) {
			alert('업로드 파일을 선택하세요');
			return false;
		}
		if (confirm('분석정보를 업로드하시겠습니까?')) {
			$.ajax({
				url: "/admin/analyzeInfo/excel-upload",
				type: "post",
				data: new FormData($("#frmExcelUpload")[0]),
				dataType: "json",
				processData: false,
				contentType: false,
				success: function(data) {
					if (data.result) {
						alert('분석정보가 업로드되었습니다.');
						$('#fileNm').val('');
						$('.btn-close').click();
						goPage(1);
					} else {
						alert(data.msg);
					}
				}
			});
		}
		return false;
	});
	$('#btn-statistics').click(function() {
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
 * 분석정보 조회
 * @param {int} pageNo 페이지번호
 */
function goPage(pageNo) {
	"use strict"
	$('[name=pageSize]').val(10);
	$('[name=chnlGubun]').val("PC");
	$('[name=pageNo]').val(pageNo);
	$.ajax({
		type: 'get',
		url: '/admin/analyzeInfo/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			let result = data.result;
			$('#analyzeInfo-tbody').html($.templates('#analyzeInfo-template').render(result.data));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 6);
			controlBtnAdd(result);
		}
	});
}

/**
  * 분석정보 삭제
  */
function fnDelete() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm('분석정보를 삭제하시겠습니까?')) {
		$.ajax({
			type: 'post',
			url: '/admin/analyzeInfo/delete',
			contentType: 'application/json',
			data: JSON.stringify(setData()),
			success: function (data) {
				if (data.result) {
					alert('분석정보가 삭제되었습니다.');
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
		alert('삭제할 분석정보를 선택하세요.');
		return true;
	}
	return false;
}
function setData() {
	let data = new Array();
	$('[id^=chk_]:checked').each(function() {
		let param = {};
		let id = $(this).data('id').split('|');
		param.userId = id[0];
		param.analyzeInfoId = id[1];
		data.push(param);
	});
	return data;
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="frmExcelDown" method="get"></form>
		<form id="searchForm">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="pageSize" value="10">
			<input type="hidden" name="chnlGubun" value="PC">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea5">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
		                        <li class="on"><a href="/admin/analyzeInfo/main">분석정보</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>분석정보</h2>
		                            <div class="search-wrap">
		                                <select id="searchKey" name="searchKey" title="검색 구분 선택">
		                                    <option value="userId" selected>사용자ID</option>
		                                    <option value="analyzeInfoId">분석정보ID</option>
		                                </select>
		                                <div class="srch-word">
		                                    <input type="text" id="searchValue" name="searchValue" title="검색어 입력">
		                                    <button id="btn-select">검색</button>
		                                </div>
		                            </div>
		                            <table class="table-col analyzeInfo">
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
		                                        <th>회원ID</th>
		                                        <th>분석정보ID</th>
		                                        <th class="show-pc">비고</th>
		                                        <th class="show-pc">등록자</th>
		                                        <th>등록일</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="analyzeInfo-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap">
		                            	<button type="button" class="btn-more" id="btn-add">더보기</button>
		                            	<div class="pagination"></div>
		                            </div>
		                            <div class="btn-right" style="float: right;">
	                                    <a href="javascript:void(0)" id="btn-statistics" class="btns point btn-role-r">통계</a>
	                                    <a href="javascript:void(0)" id="btn-excel-download" class="btns point btn-role-e">다운로드</a>
	                                    <a href="javascript:void(0)" id="btn-excel-upload" class="btns point btn-role-e" onclick="baduk.layerOpen($(this), 'popUpload')">업로드</a>
	                                    <a href="javascript:void(0)" id="btn-insert" class="btns point btn-role-s">등록</a>
	                                    <a href="javascript:void(0)" id="btn-delete" class="btns gray btn-role-d">삭제</a>
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
	<section class="wrap-layer-popup" id="popUpload">
	    <div class="dimmed"></div>
	    <div class="pop-layer">
	        <div class="head">
	            <h1>업로드할 파일을 선택해주세요</h1>
	            <button class="btn-close">Close</button>
	        </div>
	        <div class="contents">
 	            <!-- 엑셀 업로드 form -->
				<form id="frmExcelUpload" name="frmExcelUpload" method="post" enctype="multipart/form-data" action="/admin/analyzeInfo/excel-upload">
					<div class="form-ele">
						<input type="text" id="fileNm" name="fileNm" readonly="readonly" style="width: 193px;"><button class="btns point" id="btn-file">찾기</button>
						<input type="file" id="file" name="file" accept=".xlsx, .xls" style="display: none;">
						<button type="button" class="btns point" id="btn-upload" style="margin-left: 0">업로드</button>
					</div>
				</form>
	        </div>
	    </div>
	</section>
</body>
<script type="text/template" id="analyzeInfo-template">
<tr>
	<td>
		<div class="fm-group">
			<div class="fm-check fm-inline fm-round">
				<input class="fm-check-input" type="checkbox" id="chk_{{:(#index + 1)}}" data-id="{{:userId}}|{{:analyzeInfoId}}">
				<label class="fm-check-label" for="chk_{{:(#index + 1)}}"></label>
			</div>
		</div>
	</td>
	<td class="subject"><a href="/admin/analyzeInfo/detail?userId={{:userId}}&analyzeInfoId={{:analyzeInfoId}}">{{:userId}}</a></td>
	<td>{{:analyzeInfoId}}</td>
	<td class="l-data show-pc">{{:etc}}</td>
	<td class="show-pc">{{:fstCrerNm}}</td>
	<td>{{:fstCreDtm}}</td>
</tr>
</script>
</html>