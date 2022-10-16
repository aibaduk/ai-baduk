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

	$('#btn-gibo-download').click(function() {
		window.location.href='/gibo-download';
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

	$('#btn-mypage').click(function() {
		window.location.href='/mypage/user/detail';
	});

	$('#btn-info').click(function() {
		let id = $(this).attr('id');
		let text = $(this).text();
		let msg = (id.indexOf('_1') != -1) ? text : text.replace(' 안내', '') + '을 하고싶으신가요?';
		alert(msg + '\nAI바둑연구소로 연락바랍니다. 02-6235-0361');
	});

	$('#btn-join').click(function() {
		window.location.href='/auth/signUp';
	});

	if ('${error}') {
		alert('${exception}');
	}

});
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<div class="container main">
            <section class="keyvi">
                <div class="log-box">
                    <c:if test="${user eq 'anonymousUser'}">
                    	<h3>LOGIN</h3>
	                    <form id="frm" action="/auth/login_proc" method="post">
		                    <span class="form-ele"><label for="userId" class="ir-blind">아이디</label><input type="text" id="userId" name="username" placeholder="아이디를 입력해주세요."></span>
		                    <span class="form-ele"><label for="userPw" class="ir-blind">비밀번호</label><input type="password" id="userPw" name="password" placeholder="비밀번호를 입력해주세요."></span>
		                    <button id="btn-login">로그인</button>
		                    <div>
		                        <a href="javascript:void(0)" id="btn-info">아이디/비밀번호를 잊으셨나요?</a>
		                        <a href="javascript:void(0)" id="btn-join">회원가입</a>
		                    </div>
		                </form>
                    </c:if>
                    <c:if test="${user ne 'anonymousUser'}">
		                <div class="info">
		                    <span class="${user.userGrade }"></span><!-- silver, gold, vip, vvip -->
		                    <strong>${user.userNm }</strong>님 환영합니다.
		                    <a href="javascript:void(0)" id="btn-mypage" data-id=${user.userId }>내정보 수정</a>
		                </div>
                    </c:if>
	                <!-- <div class="learning">
	                    <a href="#" download class="btn-submit">학습자료제출</a>
	                    <a href="#" download class="btn-receive">학습자료받기</a>
	                </div> -->
	                <div class="btn-wrap">
	                    <a href="javascript:void(0)" id="btn-chrome-download">크롬 다운로드</a>
	                    <a href="javascript:void(0)" id="btn-gibo-download">기보 프로그램</a>
	                </div>
                </div>
            </section>
            <section class="board">
                <div class="inner">
                    <div>
	                    <h3>자주묻는질문</h3>
	                    <ul class="main-board">
	                        <c:if test="${empty questionList}">
	                        	<li>
	                        		<p>
	                        			<span>등록된 자주묻는질문이 없습니다.</span>
	                        		</p>
	                        	</li>
	                        </c:if>
	                        <c:if test="${not empty questionList}">
		                        <c:forEach items="${questionList }" var="question">
	                            	<li <c:if test="${question.impoYn eq 'Y' }">class="hot"</c:if>>
	                            		<p class="subject">
	                            			<span><a href="/board/question/detail?boardGubun=02&boardId=${question.boardId }">${question.boardTit }</a></span>
		                            		<c:if test="${question.newYn eq 'Y' }"><span><em>new</em></span></c:if>
		                            	</p>
	                            	</li>
	                            </c:forEach>
	                        </c:if>
	                    </ul>
	                    <a href="/board/question/main" class="btn-more">더보기</a>
	                </div>
                    <div>
	                    <h3>공지사항</h3>
	                    <ul class="main-board">
	                    	<c:if test="${empty noticeList}">
	                        	<li>
	                        		<p>
	                        			<span>등록된 공지사항이 없습니다.</span>
	                        		</p>
	                        	</li>
	                        </c:if>
	                        <c:if test="${not empty noticeList}">
		                        <c:forEach items="${noticeList }" var="notice">
	                            	<li <c:if test="${notice.impoYn eq 'Y' }">class="hot"</c:if>>
	                            		<p class="subject">
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
	                    <ul class="main-board">
	                    	<c:if test="${empty infoList}">
	                        	<li>
	                        		<p>
	                        			<span>등록된 바둑AI소식이 없습니다.</span>
	                        		</p>
	                        	</li>
	                        </c:if>
	                        <c:if test="${not empty infoList}">
		                        <c:forEach items="${infoList }" var="info">
	                            	<li <c:if test="${info.impoYn eq 'Y' }">class="hot"</c:if>>
	                            		<p class="subject">
	                            			<span><a href="/board/info/detail?boardGubun=03&boardId=${info.boardId }">${info.boardTit }</a></span>
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
	                <a href="/introduce/introduce/main"><img src="/static/images/banner_introduce.jpg" alt=""></a>
	                <a href="/introduce/curriculum/main"><img src="/static/images/banner_curriculum.jpg" alt=""></a>
	            </div>
            </section>
        </div>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
</html>