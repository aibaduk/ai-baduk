$(function() {
	"use strict"

	$('#btn-select').click(function() {
		goPage(1);
		return false;
	});

	$('#searchBoardGubun').change(function() {
		$('#searchKey').val('01').prop('selected', true);
		$('#searchValue').val('');
		$('#board-tit').text($("#searchBoardGubun option:checked").text());
		let gubun = $(this).val();
		init(board[gubun]);
		goPage(1);
		return false;
	}).trigger('change');

	$('#btn-insert').click(function() {
		let gubun = $('#searchBoardGubun').val();
		let boardNm = $("#searchBoardGubun option:checked").text();
		window.location.href = '/admin/board/insert?boardGubun='+gubun+'&boardNm='+boardNm;
	});

	$('#btn-delete').click(function() {
		fnDelete();
		return false;
	});

	$(document).on('click', '.file-zip-download', function() {
		fnZipFileDownload($(this).data('id'));
	});

	$('#btn-add').click(function() {
		let currPage = $('[name=pageSize]').val();
		$('[name=pageSize]').val(Number(currPage) + 10);
		$('[name=pageNo]').val(1);
		$('[name=chnlGubun]').val("MB");
		$.ajax({
			type: 'get',
			url: '/board/select-list',
			data: $('#searchForm').serialize(),
			success: function (data) {
				let result = data.result;
				$('#board-tbody').html($.templates(template).render(result.data));
				$('#allCheck').prop('checked', false);
				controlBtnAdd(result);
			}
		});
		return false;
	});
});

/**
 * 화면 인입시 초기화
 * @param {object} data 게시판 데이터
 */
function init(data) {
	tbody = data.tbody;
	template = data.template;
	deleteMsg = data.deleteMsg;
	deleteUrl = data.deleteUrl;
	deleteComplteMsg = data.deleteComplteMsg;
	deleteValidMsg = data.deleteValidMsg;
}

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
 * 게시판 조회
 * @param {int} pageNo 페이지번호
 */
function goPage(pageNo) {
	"use strict"
	$('[name=pageSize]').val(10);
	$('[name=chnlGubun]').val("PC");
	$('[name=pageNo]').val(pageNo);
	$.ajax({
		type: 'get',
		url: '/board/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			let result = data.result;
			$('#board-tbody').html($.templates(template).render(result.data));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 7);
			controlBtnAdd(result);
		}
	});
}

/**
 * 게시판 zip 파일 다운로드
 */
function fnZipFileDownload(boardId) {
	"use strict"
	if (confirm('파일을 다운로드하시겠습니까?')) {
		let boardGubun = $('select[name=searchBoardGubun]').val();
		window.location.href='/admin/board/zipFileDownload?boardId='+boardId+'&boardGubun='+boardGubun;
	}
}
/**
 * 게시판 삭제
 */
function fnDelete() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm(deleteMsg)) {
		$.ajax({
			type: 'post',
			url: '/admin/board/delete',
			contentType: 'application/json',
			data: JSON.stringify(setData()),
			success: function (data) {
				if (data.result) {
					alert(deleteComplteMsg);
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
		alert(deleteValidMsg);
		return true;
	}
	return false;
}
function setData() {
	let data = new Array();
	$('[id^=chk_]:checked').each(function() {
		let param = {};
		let boardGubun = $('select[name=searchBoardGubun]').val();
		let boardId = $(this).data('id');
		param.boardGubun = boardGubun;
		param.boardId = boardId;
		data.push(param);
	});
	return data;
}