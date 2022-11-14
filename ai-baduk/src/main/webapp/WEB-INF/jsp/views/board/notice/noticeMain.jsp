<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>공지사항</title>
</head>
<script type="text/javascript">
	let insertUrl = '/board/notice/insert';
	let tbody = '#notice-tbody';
	let template = '#notice-template';
	let path = 'notice';
	let deleteMsg = '공지사항을 삭제하시겠습니까?';
	let deleteUrl = '/board/notice/delete';
	let deleteComplteMsg = '공지사항이 삭제되었습니다.';
	let deleteValidMsg = '삭제할 공지사항을 선택하세요.';
</script>
<script type="text/javascript" src="/static/js/board/boardMain.js?var=${version }"></script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="pageSize" value="10">
			<input type="hidden" name="searchBoardGubun" value="01">
			<input type="hidden" name="chnlGubun" value="PC">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap">
		                    <ul class="tab-menu"></ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>공지사항</h2>
		                            <div class="search-wrap">
		                                <select id="searchKey" name="searchKey" title="검색 구분 선택">
		                                    <option value="01" selected>제목 + 내용</option>
		                                    <option value="02">제목</option>
		                                    <option value="03">내용</option>
		                                </select>
		                                <div class="srch-word">
		                                    <input type="text" id="searchValue" name="searchValue" title="검색어 입력">
		                                    <button id="btn-select">검색</button>
		                                </div>
		                            </div>
		                            <table class="table-col qna">
		                                <thead>
		                                    <tr>
		                                    	<th class="show-pc">
			                                    	<div class="fm-group">
														<div class="fm-check fm-inline fm-round">
															<input class="fm-check-input" type="checkbox" name="allCheck" id="allCheck">
															<label class="fm-check-label" for="allCheck"></label>
														</div>
													</div>
		                                    	</th>
		                                        <th>NO</th>
		                                        <th>제목</th>
		                                        <th class="show-pc">첨부</th>
		                                        <th class="show-pc">첨부파일</th>
		                                        <th class="show-pc">등록자</th>
		                                        <th>등록일</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="notice-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap">
                                    	<button type="button" class="btn-more" id="btn-add">더보기</button>
		                            	<div class="pagination"></div>
			                            <div class="btn-right">
		                                    <a href="javascript:void(0)" id="btn-insert" class="btns point btn-role-s">등록</a>
		                                    <a href="javascript:void(0)" id="btn-delete" class="btns gray btn-role-d">삭제</a>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </section>
		    </section>
		</form>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
<!-- Template 소스 {{:boardGubun}}-->
<script type="text/template" id="notice-template">
<tr {{if impoYn == 'Y'}}class="hot"{{/if}}>
	<td class="show-pc">
		<div class="fm-group">
			<div class="fm-check fm-inline fm-round">
				<input class="fm-check-input" type="checkbox" id="chk_{{:(#index + 1)}}" data-id="{{:boardId}}">
				<label class="fm-check-label" for="chk_{{:(#index + 1)}}"></label>
			</div>
		</div>
	</td>
	<td>{{if impoYn == 'Y'}}HOT{{else}}{{:rowId}}{{/if}}</td>
	<td class="l-data subject">
		<span><a href="/board/notice/detail?boardGubun=01&boardId={{:boardId}}">{{:boardTit}}</a></span>
		{{if newYn == 'Y'}}<span><em>new</em></span>{{/if}}
	</td>
	<td class="show-pc">{{:fileYn}}</td>
	<td class="show-pc">{{if fileYn == 'N'}}-{{else}}<a href="javascript:void(0)" class="file-zip-download" data-id="{{:boardId}}"><img src="/static/images/icon_file.png" alt="첨부파일 다운로드"></a>{{/if}}</td>
	<td class="show-pc">{{:fstCrerNm}}</td>
	<td>{{:fstCreDtm}}</td>
</tr>
</script>
</html>