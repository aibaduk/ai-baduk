<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>분석정보</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
});
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<c:set var="isInsert" value="${empty analyzeInfoDetail }"></c:set>
		<c:set var="isDetail" value="${not empty analyzeInfoDetail }"></c:set>
		<section class="container">
	        <div class="keyvi"></div>
	        <section class="content qna">
	            <div class="inner">
	                <div class="tab-wrap ea2">
	                    <ul class="tab-menu">
	                        <li class="on"><a href="/mypage/analyzeInfo/detail">개인 분석정보</a></li>
	                        <li><a href="/mypage/user/detail">회원정보수정</a></li>
	                    </ul>
	                    <div class="inner-depth">
	                        <div class="tab-inner">
	                            <h2>개인 분석정보</h2>
	                            <div class="myinfo">
	                                <div>
	                                    <em class="vip"></em><!-- silver, gold, vip, vvip  -->
	                                    <strong>홍길동<span>Hong Gil Dong</span></strong>
	                                </div>
	                                <div><span>기력</span>9단</div>
	                                <div><span>나이</span>17세</div>
	                                <div><span>소속</span>한국기원 국가대표</div>
	                                <p>* 2020.05기준으로 작성된 데이터입니다.</p>
	                            </div>
	                            <div class="analysis">
	                                <div class="mychart-wrap">
	                                    <h3>개인 분석표 (0.00)</h3>
	                                    <div>
	                                        <div class="chart"></div>
	                                        <div class="chart-text">
	                                            <ul>
	                                                <li><em>바둑 성향</em>공격형2</li>
	                                                <li><em>승리 패턴</em>BP13번 사용 후 전투. 끝내기 전 승리확률 70% 이상 벌릴 확률 40%</li>
	                                                <li><em>BP</em>메인-13번형 / 흑 3, 7, 20번형, 백2, 10번형</li>
	                                                <li><em>IBM</em>1번 23수까지 진행. 파생형 30개 생성.</li>
	                                                <li><em>목표</em>3년 후 입단</li>
	                                            </ul>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="record">
	                                    <h3>기보 분석표</h3>
	                                    <div class="clear">
	                                        <div class="record-item">
	                                            <h4>포석<p><strong>70</strong>/100</p></h4>
	                                            <ul>
	                                                <li>AI 일치율 : <span>45%</span></li>
	                                                <li>포지션 성공률 : <span>45%</span></li>
	                                                <li>파생 성공률 : <span>45%</span></li>
	                                                <li>실착률 : <span>7/40 (22.5%)</span></li>
	                                            </ul>
	                                        </div>
	                                        <div class="record-item">
	                                            <h4>중반<p><strong>80</strong>/100</p></h4>
	                                            <ul>
	                                                <li>유효수읽기 : <span>45%</span></li>
	                                                <li>전투력 : <span>45%</span></li>
	                                                <li>가치판단 : <span>45%</span></li>
	                                                <li>실착률 : <span>7/40 (22.5%)</span></li>
	                                            </ul>
	                                        </div>
	                                        <div class="record-item">
	                                            <h4>끝내기<p><strong>90</strong>/100</p></h4>
	                                            <ul>
	                                                <li>파트1 : <span>50% &#129042; 65%</span></li>
	                                                <li>파트2 : <span>65% &#129042; 55%</span></li>
	                                                <li>파트3 : <span>55% &#129042; 95%</span></li>
	                                                <li>실착률 : <span>20/200(10%)</span></li>
	                                            </ul>
	                                        </div>
	                                    </div>
	                                    <div class="clear">
	                                        <div class="record-item">
	                                            <h4>승부호흡</h4>
	                                            <ul>
	                                                <li><strong>흔들기</strong>(100/15)<span>성공률 50%</span></li>
	                                                <li><strong>수비</strong>(20/10)<span>성공률 70%</span></li>
	                                            </ul>
	                                        </div>
	                                        <div class="record-item">
	                                            <h4>생각시간 활용</h4>
	                                            <ul>
	                                                <li><strong>장고대국</strong>10판 (7승3패)<span>승률 25%</span></li>
	                                                <li><strong>속기대국</strong>10판 (5승5패)<span>승률 70%</span></li>
	                                            </ul>
	                                        </div>
	                                    </div>
	                                    <div class="chart"></div>
	                                </div>
	                                <div class="inner">
	                                    <h3>7월 시험성적</h3>
	                                    <table>
	                                        <colgroup>
	                                            <col width="20%"><col width="20%"><col width="20%"><col width="20%"><col width="20%">
	                                        </colgroup>
	                                        <thead>
	                                            <tr>
	                                                <th>포석</th>
	                                                <th>수읽기(사활포함)</th>
	                                                <th>끝내기</th>
	                                                <th>계가</th>
	                                                <th>총점</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                            <tr>
	                                                <td>20</td>
	                                                <td>25</td>
	                                                <td>20</td>
	                                                <td>25</td>
	                                                <td>90</td>
	                                            </tr>
	                                        </tbody>
	                                    </table>
	                                </div>
	                                <div class="inner">
	                                    <h3>7월 메모사항</h3>
	                                    <div class="memo">2016 중국리그/ 박정환(백)-천야오예 때에 비해 끝내기 실력이 향상되었다. </div>
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
</body>
</html>