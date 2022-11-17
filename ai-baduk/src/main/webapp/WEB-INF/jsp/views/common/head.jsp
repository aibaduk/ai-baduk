<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximun-scale=1.0, user-scalable=no">

<%@ include file="/WEB-INF/jsp/views/common/taglib.jsp" %>
<head>
<style type="text/css">
	.wrapper {display: none}
</style>
</head>
<!-- library javascript -->
<script type="text/javascript" src="/static/js/jquery.3.4.1.min.js"></script>
<script type="text/javascript" src="/static/js/jstree.js"></script>
<script type="text/javascript" src="/static/js/d3.v5.min.js"></script>
<script type="text/javascript" src="/static/js/jsrender.js"></script>

<!-- css -->
<link rel="stylesheet" href="/static/css/reset.css">
<link rel="stylesheet" href="/static/css/MalgunGothic.css">
<link rel="stylesheet" href="/static/css/front.css">
<link rel="stylesheet" href="/static/css/jstree.css">

<script type="text/javascript" src="/static/js/chart_data.js"></script>
<script type="text/javascript" src="/static/js/ui.js"></script>
<script type="text/javascript" src="/static/js/common.js"></script>
<script type="text/javascript" src="/static/js/pagers.js"></script>

<!-- 필수, SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--필수, FileSaver savaAs 이용 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<script type="text/javascript">
var ssMenuId = '${ssMenuId}';
var ssPermCnt = '${ssPermCnt}';
var mobileHideList = ['00017', '00020'];
$(function() {
	"use strict"
	head.processTopMenu();
	if (!isNullOrEmpty(ssMenuId)) {
		head.processMenu();
	}
	$('.wrapper').css('display', 'block');
});
var head = {
	processTopMenu: function() {
		$.ajax({
			type: 'get',
			url: '/common/menu/top-header',
			async: false,
			success: function (data) {
				if (data.result) {
					$.each(data.menuList, function(i, item) {
						if (item.dpYn == 'Y' && item.menuDepth == '1') {
							$('#gnb').append('<a href="'+item.menuUrl+'">'+item.menuNm+'</a>');
							let mobileHtml = '';
							mobileHtml += '<li>';
							mobileHtml +=     '<a href="javascript:void(0)" data-location="">'+item.menuNm+'</a>';
							let subList = $.grep(data.menuList, function(value, index) {
											  return (item.menuId == value.upMenuId);
										  });
							if (subList.length > 0) {
								mobileHtml += '<ul>';
								$.each(subList, function(i, children) {
									if ($.inArray(children.menuId, mobileHideList) == -1) {
										mobileHtml += '<li><a href="'+children.menuUrl+'">'+children.menuNm+'</a></li>';
									}
								});
								mobileHtml += '</ul>';
							}
							mobileHtml += '</li>';
							$('#mobile-ul').append(mobileHtml);
						}
					});
					baduk.init();
				} else {
					alert(data.msg);
				}
			}
		});
	},
	processMenu: function() {
		$.ajax({
			type: 'get',
			url: '/common/menu/header/'+ssMenuId,
			async: false,
			success: function (data) {
				if (data.result) {
					let size = data.menuList.length;
					let sizeClass = 'ea' + size;
					$('.tab-menu').parent('.tab-wrap').addClass(sizeClass);
					$.each(data.menuList, function(i, item) {
						if (item.dpYn == 'Y') {
							let on = (ssMenuId == item.menuId) || item.yn == 'Y' ? 'on' : '';
							$('.tab-menu').append('<li class="'+on+'"><a href="'+item.menuUrl+'">'+item.menuNm+'</a></li>');
						}
					});
				} else {
					alert(data.msg);
				}
			}
		});
	}
}
</script>