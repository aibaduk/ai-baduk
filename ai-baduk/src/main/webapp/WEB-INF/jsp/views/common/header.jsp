<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/views/common/taglib.jsp" %>
<sec:authentication var="user" property="principal"/>
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

	$('#btn-mobile-mypage').click(function() {
		window.location.href='/mypage/user/detail';
	});

	$('#btn-logout').click(function() {
		window.location.href='/auth/logout';
	});

	$('#btn-mobile-info').click(function() {
		let id = $(this).attr('id');
		let msg = $(this).text();
		alert(msg + '\nAI바둑연구소로 연락바랍니다. 02-6235-0361');
	});

	$('#btn-mobile-join').click(function() {
		window.location.href='/auth/signUp';
	});
	$('#mUserIdArea').click(function() {
		$('#mUserId').focus();
	});
	$('#mUserPwArea').click(function() {
		$('#mUserPw').focus();
	});
});
</script>
<header>
    <div class="inner">
        <h1><a href="/">한국바둑AI연구소</a></h1>
        <button class="btn-menu"><span></span><span></span><span></span></button>
        <nav class="gnb" id="gnb"></nav>
        <c:if test="${user ne 'anonymousUser'}">
	        <div class="logtop">
	            <a href="/auth/logout">로그아웃</a>
	        </div>
        </c:if>
        <aside>
            <div>
                <div class="aside-top">
                    <div class="util">
                        <c:if test="${user ne 'anonymousUser'}">
                        	<button type="button" class="btns" id="btn-mobile-mypage">내정보 수정</button>
                        	<button type="button" class="btns" id="btn-logout">로그아웃</button>
                        </c:if>
                        <button type="button" class="btn-close">닫기</button>
                    </div>
                    <div class="log-box">
                        <c:if test="${user eq 'anonymousUser'}">
	                        <h3>LOGIN</h3>
	                        <form id="mFrm" action="/auth/login_proc" method="post">
	                            <span class="form-ele" id="mUserIdArea"><label for="userID" class="blind">아이디</label><input type="text" id="mUserId" name="username" placeholder="아이디를 입력해주세요."></span>
	                            <span class="form-ele" id="mUserPwArea"><label for="userPW" class="blind">비밀번호</label><input type="password" id="mUserPw" name="password" placeholder="비밀번호를 입력해주세요."></span>
	                            <button type="button" id="btn-mobile-login">로그인</button>
	                            <div>
	                                <a href="javascript:void(0)" id="btn-mobile-info">아이디/비밀번호를 잊으셨나요?</a>
			                        <a href="javascript:void(0)" id="btn-mobile-join">회원가입</a>
	                            </div>
	                        </form>
	                    </c:if>
                        <c:if test="${user ne 'anonymousUser'}">
			                <div class="info">
			                    <span class="${user.userGrade }">${user.userGrade }</span>
			                    <p><strong>${user.userNm }</strong>님 환영합니다.</p>
			                </div>
	                    </c:if>
                    </div>
                </div>
                <nav>
                    <ul>
                        <li><a href="javascript:void(0)" data-location="introduce">연구소 소개</a>
                            <ul>
                                <li><a href="/introduce/introduce/main">연구소 소개</a></li>
                                <li><a href="/introduce/curriculum/main">커리큘럼</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0)" data-location="prod">AI 컨텐츠</a>
                            <ul>
                                <li><a href="/prod/main">AI 컨텐츠</a></li>
                                <li><a href="/down/prod/main">AI 컨텐츠 다운로드</a></li>
                            </ul>
                        </li>
                        <li><a href="javascript:void(0)" data-location="analyzeinfo">AI 분석정보</a>
                            <ul>
                                <li><a href="/mypage/analyzeInfo/detail">AI 분석정보</a></li>
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
                        <li><a href="javascript:void(0)" data-location="admin-list">관리자 페이지</a>
                            <ul>
                                <li><a href="/admin/code/main">코드관리</a></li>
                                <li><a href="javascript:void(0)">메뉴관리</a></li>
                                <li><a href="/admin/user/main">사용자관리</a></li>
                                <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
                                <li class="show-pc"><a href="/admin/analyzeInfo/main">분석정보</a></li>
                                <li><a href="/admin/prod/main">AI 컨텐츠</a></li>
		                        <li><a href="/admin/down/prod/main">AI 컨텐츠 다운로드</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </aside>
    </div>
</header>