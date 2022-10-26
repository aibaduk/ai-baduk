$(function() {
	"use strict"

	$('#btn-insert').click(function() {
		boardInsert();
	});

	$('#btn-update').click(function() {
		boardUpdate();
	});

	$('#btn-delete').click(function() {
		boardDelete();
	});

	$('#btn-cancle').click(function() {
		window.location.href = mainUrl;
	});

	$('#btn-file').click(function() {
		$('#uploadFile').click();
		return false;
	});

	$('.btn-delete-file').click(function() {
		fileDelete($(this));
	});

	$('.file-download').click(function() {
		fileDownload($(this));
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
 * 게시판 등록
 */
function boardInsert() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm(insertMsg)) {
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
			url: insertUrl,
			processData: false,
			contentType: false,
			data: formData,
			success: function (data) {
				if (data.result) {
					alert(insertComplteMsg);
					window.location.href='/board/'+path+'/detail?boardGubun='+boardGubun+'&boardId='+data.boardId;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}

/**
 * 게시판 수정
 */
function boardUpdate() {
	"use strict"
	if (validation()) {
		return;
	}
	if (confirm(updateMsg)) {
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
			url: updateUrl,
			processData: false,
			contentType: false,
			data: formData,
			success: function (data) {
				if (data.result) {
					alert(updateComplteMsg);
					window.location.href='/board/'+path+'/detail?boardGubun='+boardGubun+'&boardId='+data.boardId;
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
		alert(updateValidMsg);
		$('#boardTit').focus();
		return true;
	}
	return false;
}

/**
 * 게시판 삭제
 */
function boardDelete() {
	"use strict"
	if (confirm(deleteMsg)) {
		let data = new Array();
		let param = {
			boardGubun: $('input:hidden[name=boardGubun]').val(),
			boardId: $('input:hidden[name=boardId]').val()
		};
		data.push(param);
		$.ajax({
			type: 'post',
			url: deleteUrl,
			contentType: 'application/json',
			data: JSON.stringify(data),
			success: function (data) {
				if (data.result) {
					alert(deleteComplteMsg);
					window.location.href = mainUrl;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
/**
 * 게시판 파일 삭제
 */
function fileDelete(file) {
	"use strict"
	if (confirm('파일을 삭제하시겠습니까?')) {
		let param = {
			chnlId: 'BOARD',
			targetGubun: $('input:hidden[name=boardGubun]').val(),
			targetId: $('input:hidden[name=boardId]').val(),
			fileId: file.data('id'),
			fileNm: file.data('name')
		}
		$.ajax({
			type: 'post',
			url: fileDeleteUrl,
			contentType: 'application/json',
			data: JSON.stringify(param),
			success: function (data) {
				if (data.result) {
					alert('파일이 삭제되었습니다.');
					window.location.href='/board/'+path+'/detail?boardGubun='+boardGubun+'&boardId='+data.boardId;
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
/**
 * 게시판 파일 다운로드
 */
function fileDownload(file) {
	"use strict"
	if (confirm('파일을 다운로드하시겠습니까?')) {
		let targetId = $('input:hidden[name=boardId]').val();
		let targetGubun = $('input:hidden[name=boardGubun]').val();
		let fileNm = file.data('name');
		let fileOgNm = file.text();
		window.location.href='/board/'+path+'/fileDownload?chnlId=BOARD&targetId='+targetId+'&targetGubun='+targetGubun+'&fileNm='+fileNm+'&fileOgNm='+fileOgNm;
	}
}