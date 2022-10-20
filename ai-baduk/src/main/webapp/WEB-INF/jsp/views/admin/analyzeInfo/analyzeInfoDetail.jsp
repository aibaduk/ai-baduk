<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>분석정보 상세</title>
</head>
<script type="text/javascript">
	$(function() {
		"use strict"
		$('#btn-cancle').click(function() {
			window.location.href="/admin/user/main";
		});
	});
	var user = {
		createOptionForElements: function(id, val) {
			let option = '<option value="'+val+'">'+val+'</option>'
			$('#'+id).append(option);
		},
		changeTheDay: function() {
			let tmpDayVal = fnNull($('#userDay option:selected').val());
			$('#userDay').html('');
			$('#userDay').append('<option value="" disabled="disabled">일</option>');
			let lastDayOfTheMonth = new Date($('#userYear').val(), $('#userMonth').val(), 0).getDate();
			for(let i=1; i<=lastDayOfTheMonth; i++) {
				i = (i < 10) ? "{0}{1}".format('0', i) : i;
				user.createOptionForElements('userDay', i);
			}
			$('#userDay').val(tmpDayVal).prop('selected', true);
		},
		update: function() {
			if (!ai.isValidate($('#form'))) {
				return;
			}
			if (confirm('회원정보를 수정하시겠습니까?')) {
				user.setData();
				$.ajax({
					type: 'post',
					url: '/admin/user/update',
					data: $('#form').serialize(),
					success: function (data) {
						if (data.result) {
							alert('회원정보가 수정되었습니다.');
							window.location.href='/admin/user/detail?userId='+data.userId;
						} else {
							alert(data.msg);
						}
					}
				});
			}
		},
		setData: function() {
			let userYear = fnNull($('#userYear').val());
			let userMonth = fnNull($('#userMonth').val());
			let userDay = fnNull($('#userDay').val());
			let birth = "{0}{1}{2}".format(userYear, userMonth, userDay);
			$('#birth').val(birth);
		},
		changePasswoad: function() {
			if (!ai.isValidate($('#password-form'))) {
				return;
			}
			if (confirm('비밀번호를 변경하시겠습니까?')) {
				$.ajax({
					type: 'post',
					url: '/admin/user/update-password',
					data: $('#password-form').serialize(),
					success: function (data) {
						if (data.result) {
							alert('비밀번호가 변경되었습니다.');
							window.location.href='/admin/user/detail?userId='+data.userId;
						} else {
							alert(data.msg);
						}
					}
				});
			}
		},
		withdrawal: function() {
			if (confirm('회원을 탈퇴시키겠습니까?')) {
				$.ajax({
					type: 'post',
					url: '/admin/user/withdrawal',
					data: {userId: $('#userId').val()},
					success: function (data) {
						if (data.result) {
							alert('회원탈퇴가 처리되었습니다.');
							window.location.href='/admin/withdrawal/main';
						} else {
							alert(data.msg);
						}
					}
				});
			}
		}
	}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="form" name="form">
			<section class="container">
	            <div class="keyvi"></div>
	            <section class="content qna">
	                <div class="inner">
	                    <div class="tab-wrap ea5">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
		                        <li class="on"><a href="/admin/analyzeInfo/main">분석정보</a></li>
		                    </ul>
	                        <div class="inner-depth">
		                        <div class="tab-inner">
		                            <h2>분석정보 상세</h2>
		                            <div class="myinfo">
		                                <div class="div-search">
		                                    <em class="gold" id="grade"></em><!-- silver, gold, vip, vvip  -->
		                                    <strong>홍길동<a class="btn-search" onclick="baduk.layerOpen($(this), 'popPW')"></a></strong>
		                                   <!--  <strong id="userNm"></strong> -->
		                                </div>
		                                <div><span id="analyzeInfoId">대상월</span></div>
		                                <div><span id="leval">기력</span></div>
		                                <div><span id="age">나이</span></div>
		                                <div><span id="team">소속</span></div>
		                            </div>
		                            <div class="analysis">
		                                <div class="mychart-wrap">
		                                    <h3>개인 분석표 (0.00)</h3>
		                                    <div>
		                                        <div class="chart"></div>
		                                        <div class="chart-text">
		                                            <ul>
		                                                <li><em>바둑 성향</em><input type="text" class="analyzeInfo-input" id="badukTendency" name="badukTendency"></li>
		                                                <li><em>승리 패턴</em><input type="text" class="analyzeInfo-input" id="victoryPattern" name="victoryPattern"></li>
		                                                <li><em>BP</em><input type="text" class="analyzeInfo-input" id="bp" name="bp"></li>
		                                                <li><em>IBM</em><input type="text" class="analyzeInfo-input" id="ibm" name="ibm"></li>
		                                                <li><em>목표</em><input type="text" class="analyzeInfo-input" id="target" name="target"></li>
		                                            </ul>
		                                        </div>
		                                    </div>
		                                </div>
		                                <div class="record">
		                                    <h3>기보 분석표</h3>
		                                    <div class="clear">
		                                        <div class="record-item">
		                                            <h4>포석<p><strong><input type="text" class="analyzeInfo-input2" id="target" name="target"></strong>/100</p></h4>
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
		</form>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
	<section class="wrap-layer-popup" id="popPW">
	    <div class="dimmed"></div>
	    <div class="pop-layer">
	        <div class="head">
	            <h1>사용자를 선택해주세요</h1>
	            <button class="btn-close">Close</button>
	        </div>
	        <div class="contents">
				<form id="user-form" name="user-form">
	                <span class="form-ele">
	                	<label for="pop-userId">사용자ID</label>
	                	<input type="text" id="pop-userId" title="사용자ID" required>
	                </span>
	                <span class="form-ele">
	                	<label for="pop-analyzeInfoId">대상월</label>
	                	<input type="text" id="pop-analyzeInfoId" title="대상월" placeholder="202210" required>
	                </span>
	                <div>
	                    <button type="button" id="btn-complet">확인</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</section>
</body>
</html>