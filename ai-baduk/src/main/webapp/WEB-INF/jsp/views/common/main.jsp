<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>AI 바둑연구소</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#btn-chrome-download').click(function() {
		window.location.href='/chrome-download';
	});

	$('#btn-login').click(function() {
		let userId = $('#userId').val();
		if (isNullOrEmpty(userId)) {
			alert("아이디를 입력하세요.");
			$('#userId').focus();
			return false;
		}
		let userPw = $('#userPw').val();
		if (isNullOrEmpty(userPw)) {
			alert("비밀번호를 입력하세요.");
			$('#userPw').focus();
			return false;
		}

		$('#frm').submit();
		return false;

	});

	$('#btn-top-logout').click(function() {
		window.location.href='/logout';
	});

	// 로그인 성공시 로그인 성공 화면으로 전환
	if (!isNullOrEmpty('${userInfo }')) {
		$('.loginForm').show();
		$('#frm').hide();
		$('#btn-top-logout').show();
		$('#btn-top-login').hide();
	} else {
		$('.loginForm').hide();
		$('#frm').show();
		$('#btn-top-login').show();
		$('#btn-top-logout').hide();
	}

	// 로그인 실패시 alert 띄우기
	if (!isNullOrEmpty('${errMsg }')) {
		alert('${errMsg }');
	}

});
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<div class="container main">
            <section class="keyvi">
                <div class="log-box">
                    <!-- 로그인 전 -->
                    <h3>LOGIN</h3>
                    <form id="frm" action="/login_proc" method="post" style="display: none;">
	                    <span class="form-ele"><label for="userId" class="ir-blind">아이디</label><input type="text" id="userId" name="username" placeholder="아이디를 입력해주세요."></span>
	                    <span class="form-ele"><label for="userPw" class="ir-blind">비밀번호</label><input type="password" id="userPw" name="password" placeholder="비밀번호를 입력해주세요."></span>
	                    <button id="btn-login">로그인</button>
	                    <div>
	                        <a href="javascript:void(0)">아이디/비밀번호를 잊으셨나요?</a>
	                        <a href="javascript:void(0)">회원가입 안내</a>
	                    </div>
	                </form>
                    <!-- //로그인 전 -->
                    <!-- 로그인 후 -->
	                <div id="loginForm" class="info loginForm" style="display: none;">
	                    <span class="${userInfo.userGrade }"></span><!-- silver, gold, vip, vvip -->
	                    <strong>${userInfo.userNm }</strong>님 환영합니다.
	                    <a href="#">내정보 수정</a>
	                </div>
	                <div class="learning loginForm">
	                    <a href="#" download class="btn-submit">학습자료제출</a>
	                    <a href="#" download class="btn-receive">학습자료받기</a>
	                </div>
	                <!-- //로그인 후 -->
	                <div class="btn-wrap">
	                    <a href="javascript:void(0)" id="btn-chrome-download">크롬 다운로드</a>
	                    <a href="javascript:void(0)" target="_blank">기보 프로그램</a>
	                </div>
                </div>
            </section>
            <section class="board">
                <div class="inner">
                    <div>
	                    <h3>학습자료 업데이트</h3>
	                    <ul>
	                        <c:if test="${empty questionsList}">
	                        	<li>
	                        		<p>
	                        			<span>등록된 학습자료가 없습니다.</span>
	                        		</p>
	                        	</li>
	                        </c:if>
	                        <c:if test="${not empty questionsList}">
		                        <c:forEach items="${questionsList }" var="questions">
	                            	<li>
	                            		<p>
	                            			<span><a href="/board/notice/detail?boardGubun=02&boardId=${questions.boardId }">${questions.boardTit }</a></span>
		                            		<c:if test="${questions.newYn eq 'Y' }"><span><em>new</em></span></c:if>
		                            	</p>
	                            	</li>
	                            </c:forEach>
	                        </c:if>
	                    </ul>
	                    <a href="/board/questions/main" class="btn-more">더보기</a>
	                </div>
                    <div>
	                    <h3>공지사항</h3>
	                    <ul>
	                    	<c:if test="${empty noticeList}">
	                        	<li>
	                        		<p>
	                        			<span>등록된 공지사항이 없습니다.</span>
	                        		</p>
	                        	</li>
	                        </c:if>
	                        <c:if test="${not empty noticeList}">
		                        <c:forEach items="${noticeList }" var="notice">
	                            	<li>
	                            		<p>
	                            			<span><a href="/board/notice/detail?boardGubun=01&boardId=${notice.boardId }">${notice.boardTit }</a></span>
		                            		<c:if test="${notice.newYn eq 'Y' }"><span><em>new</em></span></c:if>
		                            	</p>
	                            	</li>
	                            </c:forEach>
	                        </c:if>
	                    </ul>
	                    <a href="/board/notice/main" class="btn-more">더보기</a>
	                </div>
                    <div>
	                    <h3>바둑AI소식</h3>
	                    <ul>
	                    	<c:if test="${empty infoList}">
	                        	<li>
	                        		<p>
	                        			<span>등록된 바둑AI소식이 없습니다.</span>
	                        		</p>
	                        	</li>
	                        </c:if>
	                        <c:if test="${not empty infoList}">
		                        <c:forEach items="${infoList }" var="info">
	                            	<li>
	                            		<p>
	                            			<span><a href="/board/notice/detail?boardGubun=03&boardId=${info.boardId }">${info.boardTit }</a></span>
		                            		<c:if test="${info.newYn eq 'Y' }"><span><em>new</em></span></c:if>
		                            	</p>
	                            	</li>
	                            </c:forEach>
                            </c:if>
	                    </ul>
	                    <a href="/board/info/main" class="btn-more">더보기</a>
	                </div>
                </div>
            </section>
            <section class="main-banner">
                <div class="inner">
	                <a href="/introduce/main?tab=0"><img src="/static/images/banner_introduce.jpg" alt=""></a>
	                <a href="/introduce/main?tab=1"><img src="/static/images/banner_curriculum.jpg" alt=""></a>
	            </div>
            </section>
        </div>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
</html>