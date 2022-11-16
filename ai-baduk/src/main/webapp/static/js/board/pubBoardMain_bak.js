$(function() {
	"use strict"

	$('#btn-select').click(function() {
		goPage(1);
		return false;
	});

	$('#btn-insert').click(function() {
		window.location.href="/board/notice/insert";
	});

	$('#btn-delete').click(function() {
		noticeDelete();
		return false;
	});

	$(document).on('click', '.file-zip-download', function() {
		noticeZipFileDownload($(this).data('id'));
	});

	goPage(1);
});

/**
 * 공지사항 조회
 * @param {int} pageNo 페이지번호
 */
function goPage(pageNo) {
	"use strict"
	$('[name=pageNo]').val(pageNo);
	$.ajax({
		type: 'get',
		url: '/board/select-list',
		data: $('#searchForm').serialize(),
		success: function (data) {
			let result = data.result;
			$('#notice-tbody').html($.templates('#notice-template').render(result.data));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 7);
		}
	});
}

/**
 * 공지사항 zip 파일 다운로드
 */
function noticeZipFileDownload(boardId) {
	"use strict"
	if (confirm('파일을 다운로드하시겠습니까?')) {
		let boardGubun = $('input:hidden[name=searchBoardGubun]').val();
		window.location.href='/board/notice/zipFileDownload?boardId='+boardId+'&boardGubun='+boardGubun;
	}
}
/**
 * 공지사항 삭제
 */
function noticeDelete() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm('공지사항을 삭제하시겠습니까?')) {
		$.ajax({
			type: 'post',
			url: '/board/notice/delete',
			contentType: 'application/json',
			data: JSON.stringify(setData()),
			success: function (data) {
				if (data.result) {
					alert('공지사항이 삭제되었습니다.');
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
		alert('삭제할 공지사항을 선택하세요.');
		return true;
	}
	return false;
}
function setData() {
	let data = new Array();
	$('[id^=chk_]:checked').each(function(i, item) {
		let param = {};
		let boardGubun = $('input:hidden[name=searchBoardGubun]').val();
		let boardId = $(this).data('id');
		param.boardGubun = boardGubun;
		param.boardId = boardId;
		data.push(param);
	});
	return data;
}