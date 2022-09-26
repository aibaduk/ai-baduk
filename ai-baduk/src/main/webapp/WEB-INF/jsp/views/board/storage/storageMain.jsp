<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>자료실</title>
</head>
<script type="text/javascript">
	let insertUrl = '/board/storage/insert';
	let tbody = '#storage-tbody';
	let template = '#storage-template';
	let path = 'storage';
	let deleteMsg = '자료실을 삭제하시겠습니까?';
	let deleteUrl = '/board/storage/delete';
	let deleteComplteMsg = '자료실이 삭제되었습니다.';
	let deleteValidMsg = '삭제할 자료실을 선택하세요.';
</script>
<script type="text/javascript" src="/static/js/board/boardMain.js?var=${version }"></script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="searchForm">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="pageSize" value="10">
			<input type="hidden" name="searchBoardGubun" value="04">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea4">
		                    <ul class="tab-menu">
		                        <li><a href="/board/notice/main">공지사항</a></li>
		                        <li><a href="/board/question/main">자주묻는질문</a></li>
		                        <li><a href="/board/info/main">바둑AI소식</a></li>
		                        <li class="on"><a href="javascript:void(0)">자료실</a></li>
		                    </ul>
		                    <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>자료실</h2>
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
		                                <tbody id="storage-tbody"></tbody>
		                            </table>
		                            <div class="btn-wrap">
                                    	<!-- <button type="button" class="btn-more">더보기</button> -->
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
<script type="text/template" id="storage-template">
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
		<span><a href="/board/storage/detail?boardGubun=04&boardId={{:boardId}}">{{:boardTit}}</a></span>
		{{if newYn == 'Y'}}<span><em>new</em></span>{{/if}}
	</td>
	<td class="show-pc">{{:fileYn}}</td>
	<td class="show-pc">{{if fileYn == 'N'}}-{{else}}<a href="javascript:void(0)" class="file-zip-download" data-id="{{:boardId}}"><img src="/static/images/icon_file.png" alt="첨부파일 다운로드"></a>{{/if}}</td>
	<td class="show-pc">{{:fstCrerNm}}</td>
	<td>{{:fstCreDtm}}</td>
</tr>
</script>
</html>