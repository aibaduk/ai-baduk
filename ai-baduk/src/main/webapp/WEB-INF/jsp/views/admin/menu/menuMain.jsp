<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>메뉴관리 메인</title>
</head>
<style>
.g-block-1 {
    width: 25%;
    display: inline-block;
    float: left;
}

.g-block-2 {
    width: 75%;
    display: inline-block;
}

.block3 {
    width: 100%;
    height: 20px;
}

.block4{
    width: 100%;
    height: 380px;
}

.block5 {
    width: 100%;
    height: 20px;
}

.block5 {
    width: 100%;
    height: 400px;
}
</style>
<script type="text/javascript">
$(function() {
	"use strict"
	/*
	 * 1. 화면 인입 시 메뉴를 root로 조회해야 한다.
	 * 2. 트리를 클릭 시 id로 메뉴를 조회해야 한다.
	 */
	 menu.tree('root', true);

	$('#btn-update').click(function() {
		if ($('#tree').jstree("get_selected").length < 1) {
			alert('트리에서 메뉴를 선택하세요.');
			return;
		}
		menu.update();
	});

	$('#btn-popup').click(function() {
		if ($('#tree').jstree("get_selected").length < 1) {
			alert('트리에서 메뉴를 선택하세요.');
			return;
		}
		$('#spanUpMenuId span').empty();
		let node = $('#tree').jstree(true).get_node($('#tree').jstree("get_selected"));
		$('#spanUpMenuId').append('<span>'+node.id+'</span>');
		$('#menu-insert-form #upMenuId').val(node.id);
		$('#menu-insert-form #menuDepth').val(Number(node.original.depth) + 1);
		$('#menu-insert-form input:text').val('');
		$('#menu-insert-form input:radio').first().val('Y').prop('checked', true);
		$('#menu-insert-form input:checkbox').prop('checked', false);
		baduk.layerOpen($(this), 'popPW');
	});
});

var menu = {
	tree: function(nodeId, bind) {
		$.ajax({
			type: 'get',
			url: '/admin/menu/select-list',
			success: function (data) {
				if (!isNullOrEmpty(data.result)) {
					var arr = new Array();
			        $.each(data.result, function(idx, item){
			        	arr[idx] = {
			        		id:item.menuId, parent:item.upMenuId, text:item.menuNm, url:item.menuUrl,
			        		visibleYn:item.visibleYn, etc:item.etc, sortSeq:item.sortSeq, depth:item.menuDepth,
			        		roleMenuList: item.roleMenuList
			        	};
			        });
			        if (bind) {
				        menu.event(arr);
			        } else {
			        	$("#tree").jstree(true).settings.core.data = arr;
			        	$("#tree").jstree(true).refresh();
			        }
				}
			}
		});
	},
	event: function(data) {
		$("#tree").jstree({
            core: {
                data: data
            },
            types: {
                'default': {
                    'icon': 'jstree-folder'
                }
            },
            plugins: ['wholerow', 'types']
        })
        .bind('loaded.jstree', function(event, data){
            //트리 로딩 완료 이벤트
       		$("#tree").jstree("open_node", 'root');
       		$("#tree").jstree("select_node", 'root');
        })
        .bind('select_node.jstree', function(event, data){
        	//노드 선택 이벤트
            let node = data.node;
        	console.log(node);
            menu.bind(node);
        })
	},
	bind: function(data) {
		$('#divMenuId').text(data.id);
		$('#menuId').val(data.id);
		$('#menuNm').val(data.text);
		$('#upMenuId').val(data.parent);
		$('#menuUrl').val(data.original.url);
		$('#sortSeq').val(data.original.sortSeq);
		$('#menuDepth').val(data.original.depth);
		$('input:radio[name=visibleYn][value='+data.original.visibleYn+']').prop('checked', true);
		$('input:checkbox[name=roleList]').prop('checked', false);
		$.each(data.original.roleMenuList, function(i, item) {
			$('input:checkbox[name=roleList][value='+item.roleId+']').prop('checked', true);
		});
		$('input:radio[name=visibleYn][value='+data.original.visibleYn+']').prop('checked', true);
		$('#etc').val(data.original.etc);

		// 하위 리스트
		let html = '';
		$.each(data.children, function(i, item) {
			let node = $('#tree').jstree(true).get_node(item);
			let menuNm = node.text;
			let menuUrl = node.original.url;
			let menuId = node.id;
			let upMenuId = node.parent;
			let visibleYn = (node.original.visibleYn == 'Y') ? '활성' : '비활성';
			html += '<tr>';
			html += 	'<td class="subject l-data">'+menuNm+'</td>';
			html += 	'<td class="subject l-data">'+menuUrl+'</td>';
			html += 	'<td>'+menuId+'</td>';
			html += 	'<td>'+upMenuId+'</td>';
			html += 	'<td>'+visibleYn+'</td>';
			html += '</tr>';
		});
		$('#menu-child-tbody').html(html);
	},
	insert: function() {
		if (!ai.isValidate($('#menu-insert-form'))) {
			return;
		}
		if (confirm('메뉴정보를 등록하시겠습니까?')) {
			$.ajax({
				type: 'post',
				url: '/admin/menu/insert',
				data: $('#menu-insert-form').serialize(),
				success: function (data) {
					if (data.result) {
						alert('메뉴정보가 등록되었습니다.');
				        $('.btn-close').trigger('click');
						menu.tree(data.menuId, false);
					} else {
						alert(data.msg);
					}
				}
			});
		}
	},
	update: function() {
		if (!ai.isValidate($('#menu-form'))) {
			return;
		}
		if (confirm('메뉴정보를 수정하시겠습니까?')) {
			$.ajax({
				type: 'post',
				url: '/admin/menu/update',
				data: $('#menu-form').serialize(),
				success: function (data) {
					if (data.result) {
						alert('메뉴정보가 수정되었습니다.');
						menu.tree(data.menuId, false);
					} else {
						alert(data.msg);
					}
				}
			});
		}
	}
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<section class="container">
	        <div class="keyvi"></div>
	        <section class="content">
	            <div class="inner">
	                <div class="tab-wrap ea7">
	                    <ul class="tab-menu">
	                        <li><a href="/admin/code/main">공통코드</a></li>
	                        <li class="on"><a href="/admin/menu/main">메뉴관리</a></li>
	                        <li><a href="/admin/user/main">사용자관리</a></li>
	                        <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
	                        <li><a href="/admin/analyzeInfo/main">분석정보</a></li>
	                        <li><a href="/admin/prod/main">AI 컨텐츠</a></li>
	                        <li><a href="/admin/down/prod/main">AI 컨텐츠 다운로드</a></li>
	                    </ul>
	                    <div class="inner-depth">
	                        <div class="tab-inner">
	                            <h2>메뉴관리</h2>
	                            <div id="tree" class="g-block-1">

								</div>
								<div class="g-block-2">
		                            <a href="javascript:void(0)" id="btn-update" class="btns point" style="margin-left: 754px; margin-bottom: 5px;">수정</a>
	                                <form id="menu-form">
		                                <div class="block4">
			                                <ul class="write-box">
			                                    <li style="width: 50%; float: left;">
			                                    	<strong>메뉴ID</strong><div class="fm-group" style="width: 100%" id="divMenuId"></div>
				                                    <input type="hidden" id="menuId" name="menuId"/>
				                                	<input type="hidden" id="menuDepth" name="menuDepth"/>
			                                    </li>
			                                    <li>
			                                    	<strong>상위메뉴ID</strong><div class="fm-group" style="width: 100%"><input type="text" id="upMenuId" name="upMenuId" maxlength="5" title="상위메뉴ID" required/></div>
			                                    </li>
			                                    <li style="width: 50%; float: left;">
			                                    	<strong>메뉴명</strong><div class="fm-group" style="width: 100%"><input type="text" id="menuNm" name="menuNm" title="메뉴명" required/></div>
			                                    </li>
			                                    <li>
			                                    	<strong>정렬순번</strong><div class="fm-group" style="width: 100%"><input type="text" class="dev-number" id="sortSeq" name="sortSeq" title="정렬순번" maxlength="4" required/></div>
			                                    </li>
			                                    <li>
			                                    	<strong style="width: 138px;">메뉴URL</strong><div class="fm-group" style="width: 100%"><input type="text" id="menuUrl" name="menuUrl" title="메뉴URL" required/></div>
			                                    </li>
			                                    <li>
			                                    	<strong style="width: 118px;">활성화여부</strong>
				                                    <div class="form-ele">
				                                    	<div class="fm-group" style="display: inline;">
							                                <div class="fm-check fm-inline">
							                                    <input class="fm-check-input" type="radio" name="visibleYn" id="visibleY" value="Y" checked="checked">
							                                    <label class="fm-check-label" for="visibleY">Y</label>
							                                </div>
							                                <div class="fm-check fm-inline">
							                                    <input class="fm-check-input" type="radio" name="visibleYn" id="visibleN" value="N">
							                                    <label class="fm-check-label" for="visibleN">N</label>
							                                </div>
							                            </div>
						                            </div>
				                                </li>
				                                <li>
			                                    	<strong style="width: 118px;">권한</strong>
			                                    	<div class="fm-group">
					                                   	<c:forEach items="${codeCU004 }" var="item" varStatus="status">
															<div class="fm-check fm-inline">
							                                    <input class="fm-check-input" type="checkbox" name="roleList" id="roleList${item.codeId }" value="${item.codeId }">
							                                    <label class="fm-check-label" for="roleList${item.codeId }">${item.codeNm }</label>
							                                </div>
					                                   	</c:forEach>
						                            </div>
						                        </li>
			                                    <li>
			                                    	<strong style="width: 138px;">메모</strong><div class="fm-group" style="width: 100%"><input type="text" id="etc" name="etc" value=""/></div>
			                                    </li>
			                                </ul>
		                                </div>
		                            </form>
		                            <a href="javascript:void(0)" id="btn-popup" class="btns point fr" style="margin-bottom: 5px;">신규</a>
	                                <div class="block6">
			                            <table class="table-col">
			                                <colgroup>
			                                    <col width="25%">
			                                    <col width="*">
			                                    <col width="12%">
			                                    <col width="12%">
			                                    <col width="12%">
			                                </colgroup>
			                                <thead>
			                                    <tr>
			                                        <th>메뉴명</th>
			                                        <th>URL</th>
			                                        <th>메뉴ID</th>
			                                        <th>상위메뉴</th>
			                                        <th>활성화여부</th>
			                                    </tr>
			                                </thead>
			                                <tbody id="menu-child-tbody"></tbody>
			                            </table>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </section>
	    </section>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
	<!-- 비밀번호 수정 -->
	<section class="wrap-layer-popup" id="popPW">
	    <div class="dimmed"></div>
	    <div class="pop-layer">
	        <div class="head">
	            <h1>메뉴 등록</h1>
	            <button class="btn-close">Close</button>
	        </div>
	        <div class="contents">
				<form id="menu-insert-form" name="menu-insert-form">
	                <input type="hidden" id="upMenuId" name="upMenuId" value=""/>
	                <input type="hidden" id="menuDepth" name="menuDepth" value=""/>
	                <span class="form-ele"><label for="newPW">메뉴명</label><input type="text" id="menuNm" name="menuNm" title="메뉴명" required></span>
	                <span class="form-ele" id="spanUpMenuId"><label for="newPW">상위메뉴ID</label></span>
	                <span class="form-ele"><label for="newPW">메뉴URL</label><input type="text" id="menuUrl" name="menuUrl" title="메뉴URL" required></span>
	                <span class="form-ele">
	                	<label for="newPW">활성화여부</label>
						<span class="fm-group" style="margin-top: 0px; padding-top: 0px; border: 0">
							<span class="fm-check fm-inline" style="margin-top: 0px; padding-top: 0px; border: 0">
								<input class="fm-check-input" type="radio" name="visibleYn" id="pop-visibleY" value="Y" checked="checked">
								<label class="fm-check-label" for="pop-visibleY" style="width: 70px;">Y</label>
							</span>
							<span class="fm-check fm-inline" style="margin-top: 0px; padding-top: 0px; border: 0">
                               	<input class="fm-check-input" type="radio" name="visibleYn" id="pop-visibleN" value="N">
                               	<label class="fm-check-label" for="pop-visibleN" style="width: 70px;">N</label>
                            </span>
                        </span>
	                </span>
	                <span class="form-ele">
	                	<label for="newPW">권한</label>
	                	<span class="fm-group" style="margin-top: 0px; padding-top: 0px; border: 0">
                        	<c:forEach items="${codeCU004 }" var="item" varStatus="status">
								<div class="fm-check fm-inline" style="margin-top: 0px; padding-top: 0px; border: 0">
                                	<input class="fm-check-input" type="checkbox" name="roleList" id="pop-roleList${item.codeId }" value="${item.codeId }">
                                	<label class="fm-check-label" for="pop-roleList${item.codeId }" style="width: 70px;">${item.codeNm }</label>
                              	</div>
                            </c:forEach>
                        </span>
	                </span>
	                <span class="form-ele"><label for="newPW">정렬순서</label><input type="text" class="dev-number" id="sortSeq" name="sortSeq" title="정렬순서" maxlength="4" required/></span>
	                <span class="form-ele"><label for="newPW">메모</label><input type="text" id="etc" name="etc" title="메모"></span>
	                <div>
	                    <button type="button" id="btn-insert">저장</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</section>
	<script type="text/javascript">
	$(function() {
		"use strict"
		$('#btn-insert').click(function() {
			menu.insert();
		});
	});
	</script>
</body>
</html>