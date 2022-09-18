<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- <header>
    <div class="inner">
        <h1><a href="/">한국바둑AI연구소</a></h1>
        <nav>
            <a href="/introduce/main">연구소 소개</a>
            <a href="javascript:void(0)" style="display: none;">개인학습페이지</a>

            	1. 마이페이지 클릭시 로그인 여부 체크.
            	2. 로그인 되어 있을 시 마이페이지 > 개인 분석정보 페이지
            	3. 비로그인시 로그인 페이지 전환 처리.

            <a href="/mypage/analyzeInfo/detail">마이페이지</a>
            <a href="/board/notice/main">게시판</a>
            <a href="/admin/code/main">관리자 페이지</a>
        </nav>
        <div class="util">
            <a href="/">처음으로</a>
            <a id="btn-top-login" href="/">로그인</a>
            <a id="btn-top-logout" href="/logout" style="display: none;">로그아웃</a>
        </div>
    </div>
</header> -->
<header>
    <div class="inner">
        <h1><a href="/">한국바둑AI연구소</a></h1>
        <button class="btn-menu"><span></span><span></span><span></span></button>
        <nav class="gnb">
            <a href="/introduce/main">연구소 소개</a>
            <a href="javascript:void(0)" style="display: none;">개인학습페이지</a>
            <!--
            	1. 마이페이지 클릭시 로그인 여부 체크.
            	2. 로그인 되어 있을 시 마이페이지 > 개인 분석정보 페이지
            	3. 비로그인시 로그인 페이지 전환 처리.
            -->
            <a href="/mypage/analyzeInfo/detail">마이페이지</a>
            <a href="/board/notice/main">게시판</a>
            <a href="/admin/code/main">관리자 페이지</a>
        </nav>
        <aside>
            <div>
                <div class="aside-top">
                    <div class="util">
                        <button type="button" class="btns">내정보 수정</button>
                        <button type="button" id="btn-top-logout" class="btns">로그아웃</button>
                        <button type="button" class="btn-close">닫기</button>
                    </div>
                    <div class="log-box">
                        <!-- 로그인 전 --
                        <h3>LOGIN</h3>
                        <form>
                            <span class="form-ele"><label for="userID" class="blind">아이디</label><input type="text" id="userID" name="userID" placeholder="아이디를 입력해주세요."></span>
                            <span class="form-ele"><label for="userPW" class="blind">비밀번호</label><input type="password" id="userPW" name="userPW" placeholder="비밀번호를 입력해주세요."></span>
                            <button type="button">로그인</button>
                            <div>
                                <a href="#">아이디/비밀번호를 잊으셨나요?</a>
                                <a href="#">회원가입 안내</a>
                            </div>
                        </form>
                        <!-- //로그인 전 -->
                        <!-- 로그인 후 -->
                        <div class="info">
                            <span class="vvip"></span><!-- silver, gold, vip, vvip  -->
                            <p><strong>홍길동</strong>님 환영합니다.</p>
                        </div>
                        <div class="learning">
                            <a href="#" download class="btn-submit">학습자료제출</a>
                            <a href="#" download class="btn-receive">학습자료받기</a>
                        </div>
                        <!-- //로그인 후 -->
                    </div>
                </div>
                <nav>
                    <ul>
                        <li><a href="javascript:void(0)" data-location="introduce">연구소 소개</a>
                            <ul>
                                <li><a href="introduce.html">연구소 소개</a></li>
                                <li><a href="curriculum.html">커리큘럼</a></li>
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
                                <li><a href="board-list.html">공지사항</a></li>
                                <li><a href="board2-list.html">자주묻는질문</a></li>
                                <li><a href="board3-list.html">바둑AI소식</a></li>
                                <li><a href="board4-list.html">자료실</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </aside>
    </div>
</header>