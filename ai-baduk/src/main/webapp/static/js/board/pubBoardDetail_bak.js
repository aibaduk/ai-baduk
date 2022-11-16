$(function() {
	"use strict"

	$('#btn-insert').click(function() {
		noticeInsert();
	});

	$('#btn-update').click(function() {
		noticeUpdate();
	});

	$('#btn-delete').click(function() {
		noticeDelete();
	});

	$('#btn-cancle').click(function() {
		window.location.href="/board/notice/main";
	});

	$('#btn-file').click(function() {
		$('#uploadFile').click();
		return false;
	});

	$('.btn-delete-file').click(function() {
		noticeFileDelete($(this));
	});

	$('.file-download').click(function() {
		noticeFileDownload($(this));
	});

	$('#uploadFile').change(function() {
		let file = new Array();
		for (let i=0; i<this.files.length; i++) {
			file.push(this.files[i].name);
		}
		$('#boardFile').val(file.join(', '));
	});

});
/**
 * 공지사항 등록
 */
function noticeInsert() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm('공지사항을 등록하시겠습니까?')) {
		let formData = new FormData();
		let inputFile = $('#uploadFile');
		let files = inputFile[0].files;

		for (let i=0; i<files.length; i++) {
			formData.append("uploadFiles", files[i]);
		}
		formData.append('boardGubun', $('input:hidden[name=boardGubun]').val());
		formData.append('boardTit', $('#boardTit').val());
		formData.append('impoYn', $('input:radio[name=impoYn]:checked').val());
		formData.append('boardCtt', $('#boardCtt').val());

		$.ajax({
			type: 'post',
			url: '/board/notice/insert',
			processData: false,
			contentType: false,
			data: formData,
			success: function (data) {
				if (data.result) {
					alert('공지사항이 등록되었습니다.');
					window.location.href='/board/notice/detail?boardGubun=01&boardId='+data.boardId;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}

/**
 * 공지사항 수정
 */
function noticeUpdate() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm('공지사항을 수정하시겠습니까?')) {
		let formData = new FormData();
		let inputFile = $('#uploadFile');
		let files = inputFile[0].files;

		for (let i=0; i<files.length; i++) {
			formData.append("uploadFiles", files[i]);
		}
		formData.append('boardId', $('input:hidden[name=boardId]').val());
		formData.append('boardGubun', $('input:hidden[name=boardGubun]').val());
		formData.append('boardTit', $('#boardTit').val());
		formData.append('impoYn', $('input:radio[name=impoYn]:checked').val());
		formData.append('boardCtt', $('#boardCtt').val());

		$.ajax({
			type: 'post',
			url: '/board/notice/update',
			processData: false,
			contentType: false,
			data: formData,
			success: function (data) {
				if (data.result) {
					alert('공지사항이 수정되었습니다.');
					window.location.href='/board/notice/detail?boardGubun=01&boardId='+data.boardId;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
function validation() {
	"use strict"
	let boardTit = $('#boardTit').val();
	if (isNullOrEmpty(boardTit)) {
		alert('공지사항 제목을 입력하세요.');
		$('#boardTit').focus();
		return true;
	}
	return false;
}

/**
 * 공지사항 삭제
 */
function noticeDelete() {
	"use strict"
	if (confirm('공지사항을 삭제하시겠습니까?')) {
		let data = new Array();
		let param = {
			boardGubun: $('input:hidden[name=boardGubun]').val(),
			boardId: $('input:hidden[name=boardId]').val()
		};
		data.push(param);
		$.ajax({
			type: 'post',
			url: '/board/notice/delete',
			contentType: 'application/json',
			data: JSON.stringify(data),
			success: function (data) {
				if (data.result) {
					alert('공지사항이 삭제되었습니다.');
					window.location.href="/board/notice/main";
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
/**
 * 공지사항 파일 삭제
 */
function noticeFileDelete(file) {
	"use strict"
	if (confirm('파일을 삭제하시겠습니까?')) {
		let param = {
			boardGubun: $('input:hidden[name=boardGubun]').val(),
			boardId: $('input:hidden[name=boardId]').val(),
			fileId: file.data('id'),
			fileNm: file.data('name')
		}
		$.ajax({
			type: 'post',
			url: '/board/notice/fileDelete',
			contentType: 'application/json',
			data: JSON.stringify(param),
			success: function (data) {
				if (data.result) {
					alert('파일이 삭제되었습니다.');
					window.location.href='/board/notice/detail?boardGubun=01&boardId='+data.boardId;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
/**
 * 공지사항 파일 다운로드
 */
function noticeFileDownload(file) {
	"use strict"
	if (confirm('파일을 다운로드하시겠습니까?')) {
		let boardId = $('input:hidden[name=boardId]').val();
		let boardGubun = $('input:hidden[name=boardGubun]').val();
		let fileNm = file.data('name');
		let fileOgNm = file.text();
		window.location.href='/board/notice/fileDownload?boardId='+boardId+'&boardGubun='+boardGubun+'&fileNm='+fileNm+'&fileOgNm='+fileOgNm;
	}
}