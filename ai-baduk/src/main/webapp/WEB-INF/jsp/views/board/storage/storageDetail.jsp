<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>자료실 상세</title>
</head>
<script type="text/javascript">
	let mainUrl = '/board/storage/main';
	let path = 'storage';
</script>
<script type="text/javascript" src="/static/js/board/pubBoardDetail.js?var=${version }"></script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<input type="hidden" name="boardGubun" value="04">
		<c:set var="isInsert" value="${empty storageDetailInfo }"></c:set>
		<c:set var="isDetail" value="${not empty storageDetailInfo }"></c:set>
		<input type="hidden" name="boardId" value="${storageDetailInfo.boardId }">
		<section class="container">
       		<div class="keyvi"></div>
       		<section class="content brd">
	            <div class="inner">
	                <div class="tab-wrap">
	                    <ul class="tab-menu"></ul>
	                    <div class="inner-depth">
	                        <div class="tab-inner">
	                            <h2>자료실
	                            	<c:if test="${isInsert }">등록</c:if>
	                            	<c:if test="${isDetail }">상세</c:if>
	                            </h2>
	                            <%-- <c:if test="${isInsert }">
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
	                            </c:if> --%>
	                            <c:if test="${isDetail }">
	                            	<!-- 일반사용자 view 화면 -->
	                            	<ul class="view-box">
		                                <li class="tit">${storageDetailInfo.boardTit }</li>
		                                <li class="file">
		                                    <c:forEach items="${storageDetailInfo.fileList }" var="file">
	                                    		<a href="javascript:void(0)" class="file-download" data-name="${file.fileNm}_${file.fileOgNm}">${file.fileOgNm}</a>
	                                    	</c:forEach>
		                                    <span class="date">${storageDetailInfo.auditDtm }</span>
		                                </li>
		                                <li class="cont">
		                                    ${storageDetailInfo.boardCtt }
		                                </li>
		                            </ul>
		                            <%--
		                            <!-- 관리자 write 화면 -->
		                            <ul class="write-box">
		                                <li class="tit">
		                                    <span class="form-ele"><label for="tit">제목</label><input type="text" id="boardTit" name="boardTit" value="${storageDetailInfo.boardTit }"></span>
		                                </li>
		                                <li class="file">
		                                    <span class="form-ele">
		                                    	<label for="file">첨부파일</label><input type="text" id="boardFile" name="boardFile" readonly="readonly"><button class="btns" id="btn-file">찾아보기</button>
		                                    	<input type="file" id="uploadFile" name="uploadFile" multiple style="display: none;">
		                                    </span>
		                                </li>
		                                <li class="file_text">
		                                    <c:forEach items="${storageDetailInfo.fileList }" var="file">
	                                    		<a href="javascript:void(0)" class="file-download" data-name="${file.fileNm}_${file.fileOgNm}">${file.fileOgNm}</a>
	                                    		<span class='custem_close btn-delete-file' data-id="${file.fileId}" data-name="${file.fileNm}_${file.fileOgNm}">&times;</span>
	                                    	</c:forEach>
		                                </li>
		                                <li class="file">
		                                    <div class="form-ele">
		                                    	<label for="impo" class="fm-label">중요여부</label>
		                                    	<div class="fm-group" style="display: inline;">
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoY" value="Y" <c:if test="${storageDetailInfo.impoYn eq 'Y' }">checked="checked"</c:if>>
					                                    <label class="fm-check-label" for="impoY">Y</label>
					                                </div>
					                                <div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="impoYn" id="impoN" value="N" <c:if test="${storageDetailInfo.impoYn eq 'N' }">checked="checked"</c:if>>
					                                    <label class="fm-check-label" for="impoN">N</label>
					                                </div>
					                            </div>
				                            </div>
		                                </li>
		                                <li class="cont">
		                                    <textarea col="100" row="50" id="boardCtt" name="boardCtt">${storageDetailInfo.boardCtt }</textarea>
		                                </li>
		                            </ul> --%>
	                            </c:if>
	                        </div>
	                        <!-- 일반사용자 view 화면 -->
	                        <div class="btn-wrap">
	                        	<a href="javascript:void(0)" id="btn-cancle" class="btns normal">목록</a>
	                        </div>
	                        <%--
	                        <!-- 관리자 write 화면 -->
                            <div class="btn-wrap">
	                            <c:if test="${isInsert }">
	                                <a href="javascript:void(0)" id="btn-insert" class="btns point fl">등록</a>
	                                <a href="javascript:void(0)" id="btn-cancle" class="btns normal fl">취소</a>
                                </c:if>
	                            <c:if test="${isDetail }">
	                                <div class="btn-left">
	                                    <a href="javascript:void(0)" id="btn-update" class="btns point fl">수정</a>
	                                    <a href="javascript:void(0)" id="btn-delete" class="btns gray fl">삭제</a>
	                                </div>
	                                <div class="btn-right">
	                                    <a href="javascript:void(0)" id="btn-cancle" class="btns normal fr">목록</a>
	                                </div>
                                </c:if>
                            </div> --%>
                        </div>
                    </div>
                </div>
	        </section>
	    </section>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
</html>