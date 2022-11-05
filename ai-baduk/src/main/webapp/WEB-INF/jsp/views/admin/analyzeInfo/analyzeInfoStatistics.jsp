<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>분석정보 통계</title>
</head>
<script type="text/javascript">
	$(function() {
		"use strict"
		$('#btn-cancle').click(function() {
			window.location.href="/admin/analyzeInfo/main";
		});
	});
	var analyzeInfo = {
		// changeChart 변경된 값을 차트에 반영하는 함수
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
		// isMychartEmpty 데이터가 없는 경우 default 값 세팅
		isMychartEmpty: function() {
			let value = 0;
			$('.event-mychart').each(function() {
				value += Number(isNullOrEmpty($(this).val()) ? 0 : $(this).val());
			});
			return value == 0;
		},
		changeExamTotal: function(obj) {
			const maxScore = 100;
			let value = 0;
			$('.event-exam').each(function() {
				value += Number(isNullOrEmpty($(this).val()) ? 0 : $(this).val());
			});
			if (maxScore < value) {
				obj.val('');
				value = 0;
				$('.event-exam').not(obj).each(function() {
					value += Number(isNullOrEmpty($(this).val()) ? 0 : $(this).val());
				});
			}
			$('#examTotal').text(value);
		},
		changeAllTotal: function() {
			let value = 0;
			$('.event-mychart').each(function() {
				value += Number(isNullOrEmpty($(this).val()) ? 0 : $(this).val());
			});
			value = Math.round(value / $('.event-mychart').length);
			$('#allTotal').text('개인 분석표 ('+value+')');
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
	                    <div class="tab-wrap ea7">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
		                        <li class="on"><a href="/admin/analyzeInfo/main">분석정보</a></li>
		                        <li><a href="/admin/prod/main">AI 컨텐츠</a></li>
		                        <li><a href="/admin/down/prod/main">AI 컨텐츠 다운로드</a></li>
		                    </ul>
	                        <div class="inner-depth">
	                        	<c:set var="isDetail" value="${not empty analyzeInfoDetailInfo }"></c:set>
	                        	<c:set var="isInsert" value="${empty analyzeInfoDetailInfo }"></c:set>
		                        <div class="tab-inner">
		                            <h2>분석정보 통계</h2>
		                            <div class="myinfo">
		                                <div class="div-search">
		                                    <em class="gold" id="grade"></em>
		                                    <strong id="userNm">홍길동</strong><a class="btn-search" onclick="baduk.layerOpen($(this), 'popAddress')"></a>
		                                    <input type="hidden" id="userId" name="userId">
		                                    <input type="hidden" id="analyzeInfoId" name="analyzeInfoId">
		                                </div>
		                                <div><span id="analyzeInfoyyyymm">대상년월</span></div>
		                                <div><span id="level">기력</span></div>
		                                <div><span id="age">나이</span></div>
		                                <div><span id="team">소속</span></div>
		                            </div>
		                            <div class="analysis">
		                                <input type="hidden" class="event-chart event-mychart" id="opening">
		                                <input type="hidden" class="event-chart event-mychart" id="middleGame">
		                                <input type="hidden" class="event-chart event-mychart" id="endGame">
		                                <input type="hidden" class="event-chart event-mychart" id="gameTiming">
		                                <input type="hidden" class="event-chart event-mychart" id="technique">
		                                <input type="hidden" class="event-chart" id="techniqueValueJudgment">
		                                <input type="hidden" class="event-chart" id="techniqueHaengma">
		                                <input type="hidden" class="event-chart" id="techniqueReading">
		                                <div class="mychart-wrap">
		                                    <h3 id="allTotal">개인 분석표 (0)</h3>
		                                    <div>
		                                        <div class="chart"></div>
		                                        <div class="chart-text">
		                                            <ul>
		                                                <li><em id="badukTendency">바둑 성향</em></li>
		                                                <li><em id="victoryPattern">승리 패턴</em></li>
		                                                <li><em id="bp">BP</em></li>
		                                                <li><em id="ibm">IBM</em></li>
		                                                <li><em id="target">목표</em></li>
		                                            </ul>
		                                        </div>
		                                    </div>
		                                </div>
		                                <div class="record">
		                                    <h3>기보 분석표</h3>
		                                    <div class="clear">
		                                        <div class="record-item">
		                                            <h4>포석<p><strong id="event_opening"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>starting : <span id="openingStarting"></span></li>
		                                                <li>AI일치율 : <span id="openingAiMatchRate"></span></li>
		                                                <li>AI그래프 : <span id="openingAiGraph"></span></li>
		                                                <li>실착률 : <span id="openingMissRate"></span></li>
		                                            </ul>
		                                        </div>
		                                        <div class="record-item">
		                                            <h4>중반<p><strong id="event_middleGame"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>전투력 : <span id="middleGameCombativePower"></span></li>
		                                                <li>선방율 : <span id="middleGameSaveRate"></span></li>
		                                                <li>실착횟수 : <span id="middleGameMissCnt"></span></li>
		                                                <li>실착율 : <span id="middleGameMissRate"></span></li>
		                                            </ul>
		                                        </div>
		                                        <div class="record-item">
		                                            <h4>끝내기<p><strong id="event_endGame"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>DEFENSE : <span id="endGameDefense"></span></li>
		                                                <li>DEFENSE_FAILURE : <span id="endGameDefenseFailure"></span></li>
		                                                <li>TURN_THE_TABLES : <span id="endGameTurnTheTables"></span></li>
		                                                <li>실착횟수 : <span id="endGameMissCnt"></span></li>
		                                            </ul>
		                                        </div>
		                                    </div>
		                                    <div class="clear">
		                                        <div class="record-item">
		                                            <h4>승부호흡<p><strong id="event_gameTiming"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>흔들기 : <span id="gameTimingWave"></span></li>
			                                            <li>수비 : <span id="gameTimingDefence"></span></li>
		                                            </ul>
		                                        </div>
		                                        <div class="record-item">
		                                            <h4>기술<p><strong id="event_technique"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>가치판단 : <span id="event_techniqueValueJudgment"></span></li>
		                                                <li>행마 : <span id="event_techniqueHaengma"></span></li>
		                                                <li>수읽기 : <span id="event_techniqueReading"></span></li>
		                                            </ul>
		                                        </div>
		                                    </div>
		                                    <div class="chart"></div>
		                                </div>
		                                <div class="inner">
		                                    <h3><span class="span-mm"></span>시험성적</h3>
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
		                                                <td id="examOpeningPositionalJudgment"></td>
		                                                <td id="examHaengmaValueJudgment"></td>
		                                                <td id="examReadingLifeAndDeath"></td>
		                                                <td id="examEndGameCounting"></td>
		                                                <td id="examTotal"></td>
		                                            </tr>
		                                        </tbody>
		                                    </table>
		                                </div>
		                                <div class="inner">
		                                    <h3><span class="span-mm"></span>메모사항</h3>
		                                    <div class="memo" id="etc"></div>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="btn-wrap">
                                    <a href="javascript:void(0)" id="btn-cancle" class="btns normal">목록</a>
                            	</div>
		                    </div>
	                    </div>
	                </div>
	            </section>
	        </section>
		</form>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
	<section class="wrap-layer-popup" id="popAddress">
    <div class="dimmed"></div>
    <div class="pop-layer">
        <div class="head">
            <h1>사용자 검색</h1>
            <button class="btn-close">Close</button>
        </div>
        <div class="contents">
            <div class="search">
                <div style="position:relative; height:40px; padding-right:0px; border:1px solid #ddd;background-color:#fff;">
                    <input type="text" class="dev-number" id="pop-from" title="시작대상년월" placeholder="시작대상년월 202210" style="width: 45%;">~
                    <input type="text" class="dev-number" id="pop-to" title="종료대상년월" placeholder="종료대상년월 202210" style="width: 45%;">
                </div>
                <div>
                    <select id="pop-value">
                    	<option value="age">평균</option>
                    	<option value="max">최대값</option>
                    	<option value="min">최소값</option>
                    </select>
                </div>
                <div>
                    <input type="text" id="searchUser" onkeydown="enterSearch();" placeholder="아이디 또는 닉네임 입력">
                    <button type="button" onClick="getUser();"><span class="blind">검색</span></button>
                </div>
                <p>아이디 또는 닉네임을 입력해주세요.</p>
            </div>
            <!-- 검색 결과값 -->
            <div class="list-wrap">
                <div class="scroll">
                    <ul id="user_list"></ul>
                </div>
            </div>
            <!-- //검색 결과값 -->
        </div>
    </div>
</section>
</body>
<script type="text/javascript">
	// @brief 사용자검색창 - 키보드 Enter키 입력
	function enterSearch() {
		var evt_code = (window.netscape) ? event.which : event.keyCode;
		if (evt_code == 13) {
			event.keyCode = 0;
			getUser();
		}
	}
	// @brief 사용자검색창 - 데이터 조회
	function getUser() {
		// 적용예 (api 호출 전에 검색어 체크)
		let keyword = document.getElementById("searchUser");
		if(!checkSearchedWord(keyword)) {
			return;
		}
		let from = $('#pop-from').val();
		let to = $('#pop-to').val();
		if (isNullOrEmpty(from) || isNullOrEmpty(to)) {
			alert('대상년월을 입력하세요.');
			return;
		}
		let value = $('#pop-value').find('option:selected').val();
		$.ajax({
			type: 'post',
			url: '/admin/analyzeInfo/statisics-search',
			data: {
				keyword: keyword.value,
				from: from,
				to: to,
				value: value
			},
			success: function (data) {
				if (data.result) {
					makeListJson(data.statisicsList);
				} else {
					alert(data.msg);
				}
			}
		});
	}

	// @brief 사용자검색창 - 사용자 선택
	function makeListJson(statisicsList) {
		let htmlStr = '';
		if(statisicsList.length > 0) {
			let text = $('#pop-value').find('option:selected').text();
			$.each(statisicsList, function(i, item) {
				let userNm = item.userNm;
				let userId = item.userId;
				let userNickNm = item.userNickNm;
				htmlStr += '<li>';
				htmlStr += 	   "<a href='javascript:void(0)' onClick='inputTextStatisics("+JSON.stringify(item)+");'>";
				htmlStr +=         '<strong>'+text+'</strong>';
				htmlStr +=         '<p><em>사용자명</em>'+userNm+'</p>';
				htmlStr +=         '<p><em>사용자ID</em>'+userId+'</p>';
				htmlStr +=         '<p><em>닉네임</em>'+userNickNm+'</p>';
				htmlStr +=     '</a>';
				htmlStr += '</li>';
			});
		} else {
			htmlStr += '<li>조회된 데이터가 없습니다.<br/>다시 검색하여 주시기 바랍니다.</li>';
		}
		$("#user_list").html(htmlStr);
	}

	function inputTextStatisics(param) {
		let value = $('#pop-value').find('option:selected').val();
		$('#grade').removeClass();
		$('#grade').addClass(param.userGrade);
		$('#userNm').text(param.userNm);
		$('.after_team').remove();
		if (value != 'age') {
			$('#analyzeInfoyyyymm').after('<p class="after_team">'+param.analyzeInfoId+'</p>');
			$('.span-mm').text(Number(param.analyzeInfoId.substr(4,2))+'월 ');
		} else {
			let from = $('#pop-from').val();
			let to = $('#pop-to').val();
			$('#analyzeInfoyyyymm').after('<p class="after_team">'+from+'<br> ~ '+to+'</p>');
			$('.span-mm').first().text(from+' ~ '+to+' ');
			$('.span-mm').last().text('');
		}
		// after event
		$('#level').after('<p class="after_team">'+fnNull(param.levelNm)+'</p>');
		$('#age').after('<p class="after_team">'+fnNull(param.age)+'</p>');
		$('#team').after('<p class="after_team">'+fnNull(param.team)+'</p>');

		$('#badukTendency').after('<p class="after_team">'+fnNull(param.badukTendency)+'</p>');
		$('#victoryPattern').after('<p class="after_team">'+fnNull(param.victoryPattern)+'</p>');
		$('#bp').after('<p class="after_team">'+fnNull(param.bp)+'</p>');
		$('#ibm').after('<p class="after_team">'+fnNull(param.ibm)+'</p>');
		$('#target').after('<p class="after_team">'+fnNull(param.target)+'</p>');

		// chart_data
		$('#opening').val(param.opening);
		$('#endGame').val(param.endGame);
		$('#middleGame').val(param.middleGame);
		$('#gameTiming').val(param.gameTiming);
		$('#technique').val(param.technique);
		$('#techniqueValueJudgment').val(param.techniqueValueJudgment);
		$('#techniqueHaengma').val(param.techniqueHaengma);
		$('#techniqueReading').val(param.techniqueReading);

		// text
		$('#event_opening').text(param.opening);
		$('#event_endGame').text(param.endGame);
		$('#event_gameTiming').text(param.gameTiming);
		$('#event_middleGame').text(param.middleGame);
		$('#event_technique').text(param.technique);
		$('#event_techniqueValueJudgment').text(param.techniqueValueJudgment);
		$('#event_techniqueHaengma').text(param.techniqueHaengma);
		$('#event_techniqueReading').text(param.techniqueReading);
		$('#openingStarting').text(param.openingStarting);
		$('#openingAiMatchRate').text(param.openingAiMatchRate);
		$('#openingAiGraph').text(param.openingAiGraph);
		$('#openingMissRate').text(param.openingMissRate);
		$('#middleGameCombativePower').text(param.middleGameCombativePower);
		$('#middleGameSaveRate').text(param.middleGameSaveRate);
		$('#middleGameMissCnt').text(param.middleGameMissCnt);
		$('#middleGameMissRate').text(param.middleGameMissRate);
		$('#endGameDefense').text(param.endGameDefense);
		$('#endGameDefenseFailure').text(param.endGameDefenseFailure);
		$('#endGameTurnTheTables').text(param.endGameTurnTheTables);
		$('#endGameMissCnt').text(param.endGameMissCnt);
		$('#gameTimingWave').text(param.gameTimingWave);
		$('#gameTimingDefence').text(param.gameTimingDefence);
		$('#examOpeningPositionalJudgment').text(param.examOpeningPositionalJudgment);
		$('#examHaengmaValueJudgment').text(param.examHaengmaValueJudgment);
		$('#examReadingLifeAndDeath').text(param.examReadingLifeAndDeath);
		$('#examEndGameCounting').text(param.examEndGameCounting);
		$('#examTotal').text(param.examTotal);
		$('#etc').text(param.etc);
		analyzeInfo.initChart();
		analyzeInfo.changeAllTotal();
		$('.btn-close').trigger('click');
	}

	// @brief 사용자검색창 - 특수문자 제거
	function checkSearchedWord(obj) {
		if(obj.value.length == 0) {
			alert('검색어가 입력되지 않았습니다.');
			return;
		}
		if(obj.value.length > 0) {
			// 특정문자열(sql예약어의 앞뒤공백포함) 제거
			var sqlArray = new Array(
				  "OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE"
				  , "DROP", "EXEC", "UNION",  "FETCH", "DECLARE", "TRUNCATE"
			);
			// sql 예약어
			var regex = "";
			for(var num = 0; num < sqlArray.length; num++) {
				regex = new RegExp(sqlArray[num], "gi") ;
				if(regex.test(obj.value)) {
					alert("\"" + sqlArray[num]+"\"와(과) 같은 특정문자로 검색할 수 없습니다.");
					obj.value = obj.value.replace(regex, "");
					return false;
				}
			}
		}
		return true;
	}
</script>
</html>