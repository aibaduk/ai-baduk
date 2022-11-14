/**
 * 체크박스 이벤트
 */
$(document).on('click', '#allCheck', function() {
	$('[id^=chk_]:not(:disabled)').prop('checked', $(this).is(':checked'));
});
$(document).on('click', '[id^=chk_]', function() {
	let total = $("[id^=chk_]:not(':disabled')").length;
	let checked = $("[id^=chk_]:checked").length;
	$('#allCheck').prop("checked", (total == checked));
});
/**
 * 정규식 이벤트
 */
$(document).on('input keyup paste change blur focus', '.dev-number', function() {
	let regExp = /[^0-9]/g;
	let objValue = $(this).val();
	if (regExp.test(objValue)) {
		objValue = objValue.replace(regExp, '');
		$(this).val(objValue);
	}
});

var ai = {
	isValidate: function(o) {
		var isPass = true;
		$.each(o.find(':input'), function(i, item) {
			if($(item).attr('required')) {
				var type = $(item).attr('type');
				if (type == 'checkbox' || type == 'radio') {
					if ($(':input[name='+$(item).attr('name')+']:checked').length == 0) {
						var txt = $(item).attr('title');
						if (isNullOrEmpty(txt)) {
							txt = $(item).attr('placeholder');
						}
						alert(txt + '은 필수입니다.');
						$(item).focus();
						isPass = false;
						return false;
					}
				} else {
					if (isNullOrEmpty($(item).val())) {
						var txt = $(item).attr('title');
						if (isNullOrEmpty(txt)) {
							txt = $(item).attr('placeholder');
						}
						alert(txt + '은 필수입니다.');
						$(item).focus();
						isPass = false;
						return false;
					}
 				}
			}
		});
		return isPass;
	},
	showSuccessMsg: function(oMsg, msg) {
		oMsg.show();
		oMsg.text(msg);
		oMsg.css("color", "#08a600");
	},
	showErrorMsg: function(oMsg, msg) {
		oMsg.show();
		oMsg.text(msg);
		oMsg.css("color", "red");
	},
	setFocusToInputObject(oInput) {
		oInput.focus();
	}
}
/**
 * 페이징 처리
 * @param {pageInfo} rs 페이지 정보
 * @param {int} colcnt 컬럼수
 */
function paginateArea(rs, colcnt) {
	let pageInfo = rs.pageInfo;
	// $('').text(parseCurrency(pageInfo.totalCount));
	if (pageInfo.totalCount == 0) {
		noResult(colcnt);
		$('.pagination').hide();
	} else {
		$('input[name=pageNo]').val(pageInfo.pageNo);
		$('input[name=pageSize]').val(pageInfo.pageSize);
		pagerObject(pageInfo);
		$('.pagination').show();
	}
}

/**
 * 검색 데이터 결과 없는 케이스
 * @param {int} colcnt 페이지 정보
 * @param {String} id 영역 id
 */
function noResult(colcnt, id) {
	let elem = id || '.table-col > tbody';
	$(elem).html('<tr><td colspan='+colcnt+'>일치하는 검색결과가 없습니다.</td></tr>');
}

/**
 * 화폐 변환
 * @param {int} num 페이지 정보
 */
function parseCurrency(num) {
	return isNull(num) ? 0 : String(num).replace(/\B(?=([0-9]{3})+(?![0-9]))/g, ',');
}

/**
 * null 체크
 * @param {String} val 체크할 변수
 */
function isNullOrEmpty(val) {
	return (typeof val === undefined || val == null || val.length <= 0) ? true : false;
}

/**
 * 문자열 연결
 * 가이드: "{1}{2}{3}".format(4, 5, 9);
 */
String.prototype.format = function() {
    var formatted = this;
    for( var arg in arguments ) {
        formatted = formatted.replace("{" + arg + "}", arguments[arg]);
    }
    return formatted;
};

/**
 * null 치환
 * @param {String} val 체크/반환할 변수
 */
function fnNull(val) {
	return (typeof val === undefined || val == null || val.length <= 0) ? '' : val;
}

/**
 * comma 제거
 * @param {String} val comma 제거할 변수
 */
function replaceComma(val) {
	return isNullOrEmpty(val) ? '' : val.replace(/,/g,"");;
}
/**
 * 권한 체크
 */
function checkPermCnt() {
	if (ssPermCnt == '0') {
		alert('해당 페이지의 권한이 없습니다.');
		history.back;
	}
}