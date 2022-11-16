<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>자료실 상세</title>
</head>
<script type="text/javascript">

let insertMsg;
let insertComplteMsg;
let boardGubun;
let updateMsg;
let updateComplteMsg;
let updateValidMsg;
let deleteMsg;
let deleteComplteMsg;

let board = {
	'01' : {
		insertMsg: '공지사항을 등록하시겠습니까?',
		insertComplteMsg: '공지사항이 등록되었습니다.',
		boardGubun: '01',
		updateMsg: '공지사항을 수정하시겠습니까?',
		updateComplteMsg: '공지사항이 수정되었습니다.',
		updateValidMsg: '공지사항 제목을 입력하세요.',
		deleteMsg: '공지사항을 삭제하시겠습니까?',
		deleteComplteMsg: '공지사항이 삭제되었습니다.'
	},
	'02' : {
		insertMsg: '자주묻는질문을 등록하시겠습니까?',
		insertComplteMsg: '자주묻는질문이 등록되었습니다.',
		boardGubun: '02',
		updateMsg: '자주묻는질문을 수정하시겠습니까?',
		updateComplteMsg: '자주묻는질문이 수정되었습니다.',
		updateValidMsg: '자주묻는질문 제목을 입력하세요.',
		deleteMsg: '자주묻는질문을 삭제하시겠습니까?',
		deleteComplteMsg: '자주묻는질문이 삭제되었습니다.'
	},
	'03' : {
		insertMsg: '바둑AI소식을 등록하시겠습니까?',
		insertComplteMsg: '바둑AI소식이 등록되었습니다.',
		boardGubun: '03',
		updateMsg: '바둑AI소식을 수정하시겠습니까?',
		updateComplteMsg: '바둑AI소식이 수정되었습니다.',
		updateValidMsg: '바둑AI소식 제목을 입력하세요.',
		deleteMsg: '바둑AI소식을 삭제하시겠습니까?',
		deleteComplteMsg: '바둑AI소식이 삭제되었습니다.'
	},
	'04' : {
		insertMsg: '자료실을 등록하시겠습니까?',
		insertComplteMsg: '자료실이 등록되었습니다.',
		boardGubun: '04',
		updateMsg: '자료실을 수정하시겠습니까?',
		updateComplteMsg: '자료실이 수정되었습니다.',
		updateValidMsg: '자료실 제목을 입력하세요.',
		deleteMsg: '자료실을 삭제하시겠습니까?',
		deleteComplteMsg: '자료실이 삭제되었습니다.'
	}
};
</script>
<script type="text/javascript" src="/static/js/admin/board/boardDetail.js?var=${version }"></script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<input type="hidden" id="boardGubun" name="boardGubun" value="${boardGubun }">
		<c:set var="isInsert" value="${empty boardDetailInfo }"></c:set>
		<c:set var="isDetail" value="${not empty boardDetailInfo }"></c:set>
		<input type="hidden" name="boardId" value="${boardDetailInfo.boardId }">
		<section class="container">
       		<div class="keyvi"></div>
       		<section class="content brd">
	            <div class="inner">
	                <div class="tab-wrap">
	                    <ul class="tab-menu"></ul>
	                    <div class="inner-depth">
	                        <div class="tab-inner">
	                            <h2>${boardTit }
	                            	<c:if test="${isInsert }">등록</c:if>
	                            	<c:if test="${isDetail }">상세</c:if>
	                            </h2>
	                            <c:if test="${isInsert }">
		                            <ul class="write-box">
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">제목</label><input type="text" id="boardTit" name="boardTit"></span>
		                                </li>
		                                <li class="file">
		                                    <span class="form-ele">
		                                    	<label for="file">첨부파일</label><input type="text" id="boardFile" name="boardFile" readonly="readonly"><button class="btns" id="btn-file">찾아보기</button>
		                                    	<input type="file" id="uploadFile" name="uploadFile" multiple style="display: none;">
		                                    </span>
		                                </li>
		                                <li class="file">
		                                    <div class="form-ele">
		                                    	<label for="impo" class="fm-label">중요여부</label>
		                                    	<div class="fm-group" style="display: inline;">
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoY" value="Y">
					                                    <label class="fm-check-label" for="impoY">Y</label>
					                                </div>
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoN" value="N" checked="checked">
					                                    <label class="fm-check-label" for="impoN">N</label>
					                                </div>
					                            </div>
				                            </div>
		                                </li>
		                                <li class="cont">
		                                    <textarea col="100" row="50" id="boardCtt" name="boardCtt"></textarea>
		                                </li>
		                            </ul>
	                            </c:if>
	                            <c:if test="${isDetail }">
		                            <ul class="write-box">
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">제목</label><input type="text" id="boardTit" name="boardTit" value="${boardDetailInfo.boardTit }"></span>
		                                </li>
		                                <li class="file">
		                                    <span class="form-ele">
		                                    	<label for="file">첨부파일</label><input type="text" id="boardFile" name="boardFile" readonly="readonly"><button class="btns" id="btn-file">찾아보기</button>
		                                    	<input type="file" id="uploadFile" name="uploadFile" multiple style="display: none;">
		                                    </span>
		                                </li>
		                                <li class="file_text">
		                                    <c:forEach items="${boardDetailInfo.fileList }" var="file">
	                                    		<a href="javascript:void(0)" class="file-download" data-name="${file.fileNm}_${file.fileOgNm}">${file.fileOgNm}</a>
	                                    		<span class='custem_close btn-delete-file' data-id="${file.fileId}" data-name="${file.fileNm}_${file.fileOgNm}">&times;</span>
	                                    	</c:forEach>
		                                </li>
		                                <li class="file">
		                                    <div class="form-ele">
		                                    	<label for="impo" class="fm-label">중요여부</label>
		                                    	<div class="fm-group" style="display: inline;">
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoY" value="Y" <c:if test="${boardDetailInfo.impoYn eq 'Y' }">checked="checked"</c:if>>
					                                    <label class="fm-check-label" for="impoY">Y</label>
					                                </div>
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoN" value="N" <c:if test="${boardDetailInfo.impoYn eq 'N' }">checked="checked"</c:if>>
					                                    <label class="fm-check-label" for="impoN">N</label>
					                                </div>
					                            </div>
				                            </div>
		                                </li>
		                                <li class="cont">
		                                    <textarea col="100" row="50" id="boardCtt" name="boardCtt">${boardDetailInfo.boardCtt }</textarea>
		                                </li>
		                            </ul>
	                            </c:if>
	                        </div>
                            <div class="btn-wrap">
	                            <c:if test="${isInsert }">
	                                <a href="javascript:void(0)" id="btn-insert" class="btns point">등록</a>
	                                <a href="javascript:void(0)" id="btn-cancle" class="btns normal">목록</a>
                                </c:if>
	                            <c:if test="${isDetail }">
                                    <a href="javascript:void(0)" id="btn-update" class="btns point">수정</a>
                                    <a href="javascript:void(0)" id="btn-delete" class="btns gray">삭제</a>
                                    <a href="javascript:void(0)" id="btn-cancle" class="btns normal">목록</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
	        </section>
	    </section>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
</html>