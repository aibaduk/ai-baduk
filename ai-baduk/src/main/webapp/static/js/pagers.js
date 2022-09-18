/**
 * 페이징 처리
 * @param {pageInfo} pageInfo 페이지 정보
 */
function pagerObject(pageInfo) {
	pageInfo = (pageInfo || {});
	dispalyPager(pageInfo);
}

/**
 * 페이징 처리
 * @param {pageInfo} pageInfo 페이지 정보
 */
function dispalyPager(pageInfo) {
	let html = '';
//	let firstPage = 1;
	let totalCount = pagerCheck(pageInfo.totalCount, 1);
	let pageNo = pagerCheck(pageInfo.pageNo, 1);
//	let pageSize = pagerCheck(pageInfo.pageSize, 1);
	let lastPage = pagerCheck(pageInfo.lastPage, 1);
	let prePage = pagerCheck(pageInfo.prePage, (pageNo == 1 ? 1 : pageNo - 1));
	let nextPage = pagerCheck(pageInfo.nextPage, (pageNo == lastPage ? lastPage : pageNo + 1));
	let navigatePages = pagerCheck(pageInfo.navigatePages, 10);
	let indexNum = pageNo <= navigatePages ? 0 : parseInt((pageNo - 1) / navigatePages) * navigatePages;


	if (totalCount > 0) {
		if (pageNo > 1) {
			html += '<span class="navi prev"><a href="javascript:goPage('+prePage+')">이전 페이지</a></span>';
		} else {
			html += '<span class="navi prev"><a href="javascript:void(0)">이전 페이지</a></span>';
		}
		for (let i=1; i<=navigatePages; i++) {
			let pageNum = i + indexNum;

			if (pageNo == pageNum) {
				html += '<span class="btn-num active"><a href="javascript:void(0)" title="현재페이지">'+pageNum+'</a></span>';
			} else {
				html += '<span class="btn-num"><a href="javascript:goPage('+pageNum+')">'+pageNum+'</a></span>';
			}
			if (pageNum == lastPage) {
				break;
			}
		}
		if (pageNo < lastPage) {
			html += '<span class="navi next"><a href="javascript:goPage('+nextPage+')">다음 페이지</a></span>';
		} else {
    		html += '<span class="navi next"><a href="javascript:void(0)">다음 페이지</a></span>';
		}
	}

	$('.pagination').html(html);
}

/**
 * 데이터 검증
 * @param {object} args 항목
 * @param {int} defaultValue 기본값
 */
function pagerCheck(args, defaultValue) {
	return (!args || args < defaultValue) ? defaultValue : args;
}