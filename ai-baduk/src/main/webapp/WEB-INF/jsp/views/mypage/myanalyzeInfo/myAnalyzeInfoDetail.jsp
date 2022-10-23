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
	$('#analyzeInfoId').change(function() {
		analyzeInfo.search($(this).find('option:selected').val());
	});
	analyzeInfo.initChart();
});
var analyzeInfo = {
	search: function(analyzeInfoId) {
		"use strict"
		$.ajax({
			type: 'get',
			url: '/mypage/analyzeInfo/search',
			data: {
				'userId': $('#userId').val(),
				'analyzeInfoId': analyzeInfoId
			},
			success: function (data) {
				let analyzeInfoDetail = data.analyzeInfoDetail;
				if (!isNullOrEmpty(analyzeInfoDetail)) {
					$('#userGrade').removeClass();
					$('#userGrade').addClass(analyzeInfoDetail.userGrade);
					$('#userNm').text(analyzeInfoDetail.userNm);

					$('.after_team').empty();

					// after event
					$('#levelNm').after('<p class="after_team">'+analyzeInfoDetail.levelNm+'</p>');
					$('#age').after('<p class="after_team">'+analyzeInfoDetail.age+'</p>');
					$('#team').after('<p class="after_team">'+analyzeInfoDetail.team+'</p>');
					$('#badukTendency').after('<p class="after_team">'+analyzeInfoDetail.badukTendency+'</p>');
					$('#victoryPattern').after('<p class="after_team">'+analyzeInfoDetail.victoryPattern+'</p>');
					$('#bp').after('<p class="after_team">'+analyzeInfoDetail.bp+'</p>');
					$('#ibm').after('<p class="after_team">'+analyzeInfoDetail.ibm+'</p>');
					$('#target').after('<p class="after_team">'+analyzeInfoDetail.target+'</p>');

					// chart_data
					$('#opening').val(analyzeInfoDetail.opening);
					$('#endGame').val(analyzeInfoDetail.endGame);
					$('#middleGame').val(analyzeInfoDetail.middleGame);
					$('#gameTiming').val(analyzeInfoDetail.gameTiming);
					$('#technique').val(analyzeInfoDetail.technique);
					$('#endGameDefenseFailure').val(analyzeInfoDetail.endGameDefenseFailure);
					$('#endGameTurnTheTables').val(analyzeInfoDetail.endGameTurnTheTables);

					// text
					$('#event_opening').text(analyzeInfoDetail.opening);
					$('#event_endGame').text(analyzeInfoDetail.endGame);
					$('#event_gameTiming').text(analyzeInfoDetail.gameTiming);
					$('#event_middleGame').text(analyzeInfoDetail.middleGame);
					$('#event_technique').text(analyzeInfoDetail.technique);
					$('#event_endGameDefenseFailure').text(analyzeInfoDetail.endGameDefenseFailure);
					$('#event_endGameTurnTheTables').text(analyzeInfoDetail.endGameTurnTheTables);

					$('#openingStarting').text(analyzeInfoDetail.openingStarting);
					$('#openingAiMatchRate').text(analyzeInfoDetail.openingAiMatchRate);
					$('#openingAiGraph').text(analyzeInfoDetail.openingAiGraph);
					$('#openingMissRate').text(analyzeInfoDetail.openingMissRate);
					$('#middleGameCombativePower').text(analyzeInfoDetail.middleGameCombativePower);
					$('#middleGameSaveRate').text(analyzeInfoDetail.middleGameSaveRate);
					$('#middleGameMissCnt').text(analyzeInfoDetail.middleGameMissCnt);
					$('#middleGameMissRate').text(analyzeInfoDetail.middleGameMissRate);
					$('#endGameDefense').text(analyzeInfoDetail.endGameDefense);
					$('#endGameMissCnt').text(analyzeInfoDetail.endGameMissCnt);
					$('#gameTimingWave').text(analyzeInfoDetail.gameTimingWave);
					$('#gameTimingDefence').text(analyzeInfoDetail.gameTimingDefence);
					$('#techniqueValueJudgment').text(analyzeInfoDetail.techniqueValueJudgment);
					$('#techniqueHaengma').text(analyzeInfoDetail.techniqueHaengma);
					$('#techniqueReading').text(analyzeInfoDetail.techniqueReading);
					$('#examOpeningPositionalJudgment').text(analyzeInfoDetail.examOpeningPositionalJudgment);
					$('#examHaengmaValueJudgment').text(analyzeInfoDetail.examHaengmaValueJudgment);
					$('#examReadingLifeAndDeath').text(analyzeInfoDetail.examReadingLifeAndDeath);
					$('#examEndGameCounting').text(analyzeInfoDetail.examEndGameCounting);
					$('#examTotal').text(analyzeInfoDetail.examTotal);
					$('#etc').text(analyzeInfoDetail.etc);
					$('.span-mm').text(Number(analyzeInfoId.substr(4,2)));
					analyzeInfo.initChart();
				} else {
					alert('조회된 데이터가 없습니다.');
				}
			}
		});
	},
	changeChart: function(obj) {
		let objId = obj.attr('id');
		let objValue = obj.val();
		if (!analyzeInfo.isMychartEmpty()) {
			$.each(mychart[0].axes, function(i, item) {
				if (objId == item.id) {
					item.value = Number(objValue);
					return false;
				}
			});
			baduk.myChart('.mychart-wrap .chart', mychart);
		}
		$.each(record, function(i, item) {
			if (objId == item.id) {
				item.percent = Number(objValue);
				return false;
			}
		});
		baduk.recordChart('.record .chart', record);
	},
	initChart: function() {
		$('.event-chart').each(function() {
			analyzeInfo.changeChart($(this));
		});
	},
	isMychartEmpty: function() {
		let value = 0;
		$('.event-mychart').each(function() {
			value += Number(isNullOrEmpty($(this).val()) ? 0 : $(this).val());
		});
		return value == 0;
	}
}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<section class="container">
	        <div class="keyvi"></div>
	        <section class="content qna">
	            <div class="inner">
	                <div class="tab-wrap ea2">
	                    <ul class="tab-menu">
	                        <li><a href="/mypage/user/detail">회원정보수정</a></li>
	                        <li class="on"><a href="/mypage/analyzeInfo/detail">개인 분석정보</a></li>
	                    </ul>
	                    <div class="inner-depth">
	                        <div class="tab-inner">
	                            <h2>개인 분석정보</h2>
	                            <div class="myinfo">
	                                <div>
	                                    <em class="${analyzeInfoDetail.userGrade }" id="userGrade"></em>
	                                    <strong id="userNm">${analyzeInfoDetail.userNm }</strong>
	                                </div>
	                                <div>
	                                	<span>대상년월</span>
	                                	<div class="fm-group">
		                                	<select id="analyzeInfoId" name="analyzeInfoId" title="대상년월 선택" style="padding: 7px 27px 7px 7px;">
			                                    <c:forEach items="${analyzeInfoIdList }" var="item">
													<option value="${item }" <c:if test="${analyzeInfoDetail.analyzeInfoId eq item }">selected</c:if>>${item }</option>
			                                   	</c:forEach>
			                                </select>
			                                <input type="hidden" id="userId" value="${userId }">
	                                	</div>
	                                </div>
	                                <div><span id="levelNm">기력</span><p class="after_team">${analyzeInfoDetail.levelNm }<p></div>
	                                <div><span id="age">나이</span><p class="after_team">${analyzeInfoDetail.age }</p></div>
	                                <div><span id="team">소속</span><p class="after_team">${analyzeInfoDetail.team }</p></div>
	                            </div>
	                            <div class="analysis">
	                                <input type="hidden" class="event-chart event-mychart" id="opening" value="${analyzeInfoDetail.opening }">
	                                <input type="hidden" class="event-chart event-mychart" id="middleGame" value="${analyzeInfoDetail.middleGame }">
	                                <input type="hidden" class="event-chart event-mychart" id="endGame" value="${analyzeInfoDetail.endGame }">
	                                <input type="hidden" class="event-chart event-mychart" id="gameTiming" value="${analyzeInfoDetail.gameTiming }">
	                                <input type="hidden" class="event-chart event-mychart" id="technique" value="${analyzeInfoDetail.technique }">
	                                <input type="hidden" class="event-chart" id="endGameDefenseFailure" value="${analyzeInfoDetail.endGameDefenseFailure }">
	                                <input type="hidden" class="event-chart" id="endGameTurnTheTables" value="${analyzeInfoDetail.endGameTurnTheTables }">
	                                <div class="mychart-wrap">
	                                    <h3 id="allTotal">개인 분석표 (${analyzeInfoDetail.allTotal })</h3>
	                                    <div>
	                                        <div class="chart"></div>
	                                        <div class="chart-text">
	                                            <ul>
	                                                <li><em id="badukTendency">바둑 성향</em><p class="after_team">${analyzeInfoDetail.badukTendency }</p></li>
	                                                <li><em id="victoryPattern">승리 패턴</em><p class="after_team">${analyzeInfoDetail.victoryPattern }</p></li>
	                                                <li><em id="bp">BP</em><p class="after_team">${analyzeInfoDetail.bp }</p></li>
	                                                <li><em id="ibm">IBM</em><p class="after_team">${analyzeInfoDetail.ibm }</p></li>
	                                                <li><em id="target">목표</em><p class="after_team">${analyzeInfoDetail.target }</p></li>
	                                            </ul>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="record">
	                                    <h3>기보 분석표</h3>
	                                    <div class="clear">
	                                        <div class="record-item">
	                                            <h4>포석<p><strong id="event_opening">${analyzeInfoDetail.opening }</strong>/100</p></h4>
	                                            <ul>
	                                                <li>포석 starting : <span id="openingStarting">${analyzeInfoDetail.openingStarting }</span></li>
	                                                <li>포석 AI일치율 : <span id="openingAiMatchRate">${analyzeInfoDetail.openingAiMatchRate }</span></li>
	                                                <li>포석 AI그래프 : <span id="openingAiGraph">${analyzeInfoDetail.openingAiGraph }</span></li>
	                                                <li>포석 실착률 : <span id="openingMissRate">${analyzeInfoDetail.openingMissRate }</span></li>
	                                            </ul>
	                                        </div>
	                                        <div class="record-item">
	                                            <h4>중반<p><strong id="event_middleGame">${analyzeInfoDetail.middleGame }</strong>/100</p></h4>
	                                            <ul>
	                                                <li>중반 전투력 : <span id="middleGameCombativePower">${analyzeInfoDetail.middleGameCombativePower }</span></li>
	                                                <li>중반 선방율 : <span id="middleGameSaveRate">${analyzeInfoDetail.middleGameSaveRate }</span></li>
	                                                <li>중반 실착횟수 : <span id="middleGameMissCnt">${analyzeInfoDetail.middleGameMissCnt }</span></li>
	                                                <li>중반 실착율 : <span id="middleGameMissRate">${analyzeInfoDetail.middleGameMissRate }</span></li>
	                                            </ul>
	                                        </div>
	                                        <div class="record-item">
	                                            <h4>끝내기<p><strong id="event_endGame">${analyzeInfoDetail.endGame }</strong>/100</p></h4>
	                                            <ul>
	                                                <li>끝내기 DEFENSE : <span id="endGameDefense">${analyzeInfoDetail.endGameDefense }</span></li>
	                                                <li>끝내기 DEFENSE_FAILURE : <span id="event_endGameDefenseFailure">${analyzeInfoDetail.endGameDefenseFailure }</span></li>
	                                                <li>끝내기 TURN_THE_TABLES : <span id="event_endGameTurnTheTables">${analyzeInfoDetail.endGameTurnTheTables }</span></li>
	                                                <li>끝내기 실착횟수 : <span id="endGameMissCnt">${analyzeInfoDetail.endGameMissCnt }</span></li>
	                                            </ul>
	                                        </div>
	                                    </div>
	                                    <div class="clear">
	                                        <div class="record-item">
	                                            <h4>승부호흡<p><strong id="event_gameTiming">${analyzeInfoDetail.gameTiming }</strong>/100</p></h4>
	                                            <ul>
	                                                <li>승부호흡 흔들기 : <span id="gameTimingWave">${analyzeInfoDetail.gameTimingWave }</span></li>
		                                            <li>승부호흡 수비 : <span id="gameTimingDefence">${analyzeInfoDetail.gameTimingDefence }</span></li>
	                                            </ul>
	                                        </div>
	                                        <div class="record-item">
	                                            <h4>기술<p><strong id="event_technique">${analyzeInfoDetail.technique }</strong>/100</p></h4>
	                                            <ul>
	                                                <li>기술 가치판단 : <span id="techniqueValueJudgment">${analyzeInfoDetail.techniqueValueJudgment }</span></li>
	                                                <li>기술 행마 : <span id="techniqueHaengma">${analyzeInfoDetail.techniqueHaengma }</span></li>
	                                                <li>기술 수읽기 : <span id="techniqueReading">${analyzeInfoDetail.techniqueReading }</span></li>
	                                            </ul>
	                                        </div>
	                                    </div>
	                                    <div class="chart"></div>
	                                </div>
	                                <div class="inner">
	                                    <c:set var="iszero" value="${(fn:substring(analyzeInfoDetail.analyzeInfoId, 4, 5) ne '0') ? 4 : 5 }"></c:set>
	                                    <h3><span class="span-mm">${fn:substring(analyzeInfoDetail.analyzeInfoId, iszero, 6) }</span>월 시험성적</h3>
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
	                                                <td id="examOpeningPositionalJudgment">${analyzeInfoDetail.examOpeningPositionalJudgment }</td>
	                                                <td id="examHaengmaValueJudgment">${analyzeInfoDetail.examHaengmaValueJudgment }</td>
	                                                <td id="examReadingLifeAndDeath">${analyzeInfoDetail.examReadingLifeAndDeath }</td>
	                                                <td id="examEndGameCounting">${analyzeInfoDetail.examEndGameCounting }</td>
	                                                <td id="examTotal">${analyzeInfoDetail.examTotal }</td>
	                                            </tr>
	                                        </tbody>
	                                    </table>
	                                </div>
	                                <div class="inner">
	                                    <h3><span class="span-mm">${fn:substring(analyzeInfoDetail.analyzeInfoId, 4, 6) }</span>월 메모사항</h3>
	                                    <div class="memo" id="etc">${analyzeInfoDetail.etc }</div>
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