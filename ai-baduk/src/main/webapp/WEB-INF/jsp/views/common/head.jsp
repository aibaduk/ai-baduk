<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximun-scale=1.0, user-scalable=no">

<%@ include file="/WEB-INF/jsp/views/common/taglib.jsp" %>

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
$(function() {
	"use strict"
	head.processTopMenu();
});
var head = {
	processTopMenu: function() {
		$.ajax({
			type: 'get',
			url: '/common/menu/header',
			success: function (data) {
				if (data.result) {
					$.each(data.menuList, function(i, item) {
						if (item.dpYn == 'Y') {
							$('#gnb').append('<a href="'+item.menuUrl+'">'+item.menuNm+'</a>');
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