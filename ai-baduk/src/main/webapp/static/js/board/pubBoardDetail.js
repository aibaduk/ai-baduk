$(function() {
	"use strict"

	$('#btn-cancle').click(function() {
		window.location.href = mainUrl;
	});

	$('.file-download').click(function() {
		fileDownload($(this));
	});

});

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
		window.location.href='/board/'+path+'/fileDownload?targetId='+targetId+'&targetGubun='+targetGubun+'&fileNm='+fileNm+'&fileOgNm='+fileOgNm;
	}
}