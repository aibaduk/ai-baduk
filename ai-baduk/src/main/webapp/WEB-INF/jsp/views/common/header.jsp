<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/views/common/taglib.jsp" %>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#btn-mobile-login').click(function() {
		let mUserId = $('#mUserId').val();
		if (isNullOrEmpty(mUserId)) {
			alert("아이디를 입력하세요.");
			$('#mUserId').focus();
			return false;
		}
		let mUserPw = $('#mUserPw').val();
		if (isNullOrEmpty(mUserPw)) {
			alert("비밀번호를 입력하세요.");
			$('#mUserPw').focus();
			return false;
		}

		$('#mFrm').submit();
		return false;
	});

	$('#btn-logout').click(function() {
		window.location.href='/logout';
	});
});
</script>
<header>
    <div class="inner">
        <h1><a href="/">한국바둑AI연구소</a></h1>
        <button class="btn-menu"><span></span><span></span><span></span></button>
        <nav class="gnb">
            <a href="/introduce/main">연구소 소개</a>
            <a href="/mypage/analyzeInfo/detail">마이페이지</a>
            <a href="/board/notice/main">게시판</a>
            <a href="/admin/code/main">관리자 페이지</a>
        </nav>
        <aside>
            <div>
                <div class="aside-top">
                    <div class="util">
                        <c:if test="${not empty userInfo }">
                        	<button type="button" class="btns">내정보 수정</button>
                        	<button type="button" class="btns" id="btn-logout">로그아웃</button>
                        </c:if>
                        <button type="button" class="btn-close">닫기</button>
                    </div>
                    <div class="log-box">
                        <c:if test="${empty userInfo }">
	                        <h3>LOGIN</h3>
	                        <form id="mFrm" action="/login_proc" method="post">
	                            <span class="form-ele"><label for="userID" class="blind">아이디</label><input type="text" id="mUserId" name="username" placeholder="아이디를 입력해주세요."></span>
	                            <span class="form-ele"><label for="userPW" class="blind">비밀번호</label><input type="password" id="mUserPw" name="password" placeholder="비밀번호를 입력해주세요."></span>
	                            <button type="button" id="btn-mobile-login">로그인</button>
	                            <div>
	                                <a href="javascript:void(0)">아이디/비밀번호를 잊으셨나요?</a>
			                        <a href="javascript:void(0)">회원가입 안내</a>
	                            </div>
	                        </form>
	                    </c:if>
                        <c:if test="${not empty userInfo }">
			                <div class="info">
			                    <span class="${userInfo.userGrade }">${userInfo.userGrade }</span><!-- silver, gold, vip, vvip -->
			                    <p><strong>${userInfo.userNm }</strong>님 환영합니다.</p>
			                </div>
	                    </c:if>
	                    <!-- <div class="learning loginForm">
		                    <a href="#" download class="btn-submit">학습자료제출</a>
		                    <a href="#" download class="btn-receive">학습자료받기</a>
		                </div> -->
                    </div>
                </div>
                <nav>
                    <ul>
                        <li><a href="javascript:void(0)" data-location="introduce">연구소 소개</a>
                            <ul>
                                <li><a href="/introduce/main?tab=0">연구소 소개</a></li>
                                <li><a href="/introduce/main?tab=1">커리큘럼</a></li>
                            </ul>
                        </li>
                        <li><a href="#">개인학습 페이지</a></li>
                        <li><a href="javascript:void(0)" data-location="myinfo">마이페이지</a>
                            <ul>
                                <li><a href="myinfo.html">개인분석정보</a></li>
                                <li><a href="personal.html">회원정보수정</a></li>
                                <li><a href="qna-list.html">1:1문의</a></li>
                                <li><a href="learn-list.html">학습과제받기</a></li>
                                <li><a href="learn-submit-list.html">학습과제제출</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0)" data-location="board-list">게시판</a>
                            <ul>
                                <li><a href="/board/notice/main">공지사항</a></li>
                                <li><a href="/board/question/main">자주묻는질문</a></li>
                                <li><a href="/board/info/main">바둑AI소식</a></li>
                                <li><a href="/board/storage/main">자료실</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </aside>
    </div>
</header>