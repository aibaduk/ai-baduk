$(function() {
	"use strict"

	$('#btn-select').click(function() {
		goPage(1);
		return false;
	});

	$('#btn-insert').click(function() {
		window.location.href=insertUrl;
	});

	$('#btn-delete').click(function() {
		fnDelete();
		return false;
	});

	$(document).on('click', '.file-zip-download', function() {
		fnZipFileDownload($(this).data('id'));
	});

	goPage(1);
});

/**
 * 게시판 조회
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
			$(tbody).html($.templates(template).render(result.data));
			$('#allCheck').prop('checked', false);
			paginateArea(result, 7);
		}
	});
}

/**
 * 게시판 zip 파일 다운로드
 */
function fnZipFileDownload(boardId) {
	"use strict"
	if (confirm('파일을 다운로드하시겠습니까?')) {
		let boardGubun = $('input:hidden[name=searchBoardGubun]').val();
		window.location.href='/board/'+path+'/zipFileDownload?boardId='+boardId+'&boardGubun='+boardGubun;
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
			url: deleteUrl,
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
		let boardGubun = $('input:hidden[name=searchBoardGubun]').val();
		let boardId = $(this).data('id');
		param.boardGubun = boardGubun;
		param.boardId = boardId;
		data.push(param);
	});
	return data;
}