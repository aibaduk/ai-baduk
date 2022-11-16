$(function() {
	"use strict"

	$('#btn-select').click(function() {
		goPage(1);
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
				$(tbody).html($.templates(template).render(result.data));
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
			$(tbody).html($.templates(template).render(result.data));
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
		let boardGubun = $('input:hidden[name=searchBoardGubun]').val();
		window.location.href='/board/'+path+'/zipFileDownload?boardId='+boardId+'&boardGubun='+boardGubun;
	}
}