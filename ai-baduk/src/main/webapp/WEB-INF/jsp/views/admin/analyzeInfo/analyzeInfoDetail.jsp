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
			window.location.href="/admin/analyzeInfo/main";
		});
		$('#btn-save').click(function() {
			analyzeInfo.save();
			return;
		});
		$('#btn-delete').click(function() {
			analyzeInfo.fndelete();
			return;
		});
		$('.event-chart').on("propertychange change paste input", function() {
			analyzeInfo.regExp($(this));
			analyzeInfo.changeChart($(this));
			analyzeInfo.changeAllTotal($(this));
			return;
		});
		$('.event-exam').on("propertychange change paste input", function() {
			analyzeInfo.regExp($(this));
			analyzeInfo.changeExamTotal($(this));
			return;
		});
		analyzeInfo.initChart();
	});
	var analyzeInfo = {
		save: function() {
			if (!analyzeInfo.validate()) {
				return;
			}
			if (confirm('분석정보를 저장하시겠습니까?')) {
				$.ajax({
					type: 'post',
					url: '/admin/analyzeInfo/save',
					data: $('#form').serialize(),
					success: function (data) {
						if (data.result) {
							alert('분석정보가 저장되었습니다.');
							window.location.href="/admin/analyzeInfo/detail?userId="+data.analyzeInfo.userId+"&analyzeInfoId="+data.analyzeInfo.analyzeInfoId;
						} else {
							alert(data.msg);
						}
					}
				});
			}
		},
		validate: function() {
			let userId = $('#userId').val();
			let analyzeInfoId = $('#analyzeInfoId').val();
			let chkValue = "{0}{1}".format(userId, analyzeInfoId);
			if (isNullOrEmpty(chkValue)) {
				alert('사용자를 선택하세요.');
				$('#badukTendency').focus();
				return false;
			}
			return true;
		},
		fndelete: function() {
			if (confirm('분석정보를 삭제하시겠습니까?')) {
				$.ajax({
					type: 'post',
					url: '/admin/analyzeInfo/delete',
					contentType: 'application/json',
					data: JSON.stringify(analyzeInfo.setData()),
					success: function (data) {
						if (data.result) {
							alert('분석정보가 삭제되었습니다.');
							window.location.href="/admin/analyzeInfo/main";
						} else {
							alert(data.msg);
						}
					}
				});
			}
		},
		setData: function() {
			let data = new Array();
			let param = {};
			param.userId = $('#userId').val();
			param.analyzeInfoId = $('#analyzeInfoId').val();
			data.push(param);
			return data;
		},
		regExp:function(obj) {
			let regExp = /[^0-9]/g;
			let objValue = obj.val();
			if (regExp.test(objValue)) {
				objValue = objValue.replace(regExp, '');
			}
			obj.val(objValue);
		},
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
	                    <div class="tab-wrap ea5">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/withdrawal/main">탈퇴회원관리</a></li>
		                        <li class="on"><a href="/admin/analyzeInfo/main">분석정보</a></li>
		                    </ul>
	                        <div class="inner-depth">
	                        	<c:set var="isDetail" value="${not empty analyzeInfoDetailInfo }"></c:set>
	                        	<c:set var="isInsert" value="${empty analyzeInfoDetailInfo }"></c:set>
		                        <div class="tab-inner">
		                            <h2>분석정보 상세</h2>
		                            <div class="myinfo">
		                                <div class="div-search">
		                                    <em class="<c:if test="${isInsert }">gold</c:if>${analyzeInfoDetailInfo.userGrade }" id="grade"></em>
		                                    <strong id="userNm"><c:if test="${isInsert }">홍길동</c:if>${analyzeInfoDetailInfo.userNm }</strong>
		                                    <c:if test="${isInsert }">
			                                    <a class="btn-search" onclick="baduk.layerOpen($(this), 'popAddress')"></a>
		                                    </c:if>
		                                    <input type="hidden" id="userId" name="userId" value="${analyzeInfoDetailInfo.userId }">
		                                    <input type="hidden" id="analyzeInfoId" name="analyzeInfoId" value="${analyzeInfoDetailInfo.analyzeInfoId }">
		                                </div>
		                                <div><span id="analyzeInfoyyyymm">대상년월</span>${analyzeInfoDetailInfo.analyzeInfoId }</div>
		                                <div><span id="level">기력</span>${analyzeInfoDetailInfo.levelNm }</div>
		                                <div><span id="age">나이</span>${analyzeInfoDetailInfo.age }</div>
		                                <div><span id="team">소속</span>${analyzeInfoDetailInfo.team }</div>
		                            </div>
		                            <div class="analysis">
		                                <div class="mychart-wrap">
		                                    <h3 id="allTotal">개인 분석표 (<c:if test="${isInsert }">0</c:if>${analyzeInfoDetailInfo.allTotal })</h3>
		                                    <div>
		                                        <div class="chart"></div>
		                                        <div class="chart-text">
		                                            <ul>
		                                                <li><em>바둑 성향</em><input type="text" class="analyzeInfo-input" id="badukTendency" name="badukTendency" value="${analyzeInfoDetailInfo.badukTendency }"></li>
		                                                <li><em>승리 패턴</em><input type="text" class="analyzeInfo-input" id="victoryPattern" name="victoryPattern" value="${analyzeInfoDetailInfo.victoryPattern }"></li>
		                                                <li><em>BP</em><input type="text" class="analyzeInfo-input" id="bp" name="bp" value="${analyzeInfoDetailInfo.bp }"></li>
		                                                <li><em>IBM</em><input type="text" class="analyzeInfo-input" id="ibm" name="ibm" value="${analyzeInfoDetailInfo.ibm }"></li>
		                                                <li><em>목표</em><input type="text" class="analyzeInfo-input" id="target" name="target" value="${analyzeInfoDetailInfo.target }"></li>
		                                            </ul>
		                                        </div>
		                                    </div>
		                                </div>
		                                <div class="record">
		                                    <h3>기보 분석표</h3>
		                                    <div class="clear">
		                                        <div class="record-item">
		                                            <h4>포석<p><strong><input type="text" class="analyzeInfo-input2 dev-number event-chart event-mychart" id="opening" name="opening" value="${analyzeInfoDetailInfo.opening }" maxlength="3"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>포석 starting : <span><input type="text" class="analyzeInfo-input3" id="openingStarting" name="openingStarting" maxlength="50" value="${analyzeInfoDetailInfo.openingStarting }"></span></li>
		                                                <li>포석 AI일치율 : <span><input type="text" class="analyzeInfo-input3" id="openingAiMatchRate" name="openingAiMatchRate" maxlength="50" value="${analyzeInfoDetailInfo.openingAiMatchRate }"></span></li>
		                                                <li>포석 AI그래프 : <span><input type="text" class="analyzeInfo-input3" id="openingAiGraph" name="openingAiGraph" maxlength="50" value="${analyzeInfoDetailInfo.openingAiGraph }"></span></li>
		                                                <li>포석 실착률 : <span><input type="text" class="analyzeInfo-input3" id="openingMissRate" name="openingMissRate" maxlength="50" value="${analyzeInfoDetailInfo.openingMissRate }"></span></li>
		                                            </ul>
		                                        </div>
		                                        <div class="record-item">
		                                            <h4>중반<p><strong><input type="text" class="analyzeInfo-input2 dev-number event-chart event-mychart" id="middleGame" name="middleGame" value="${analyzeInfoDetailInfo.middleGame }" maxlength="3"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>중반 전투력 : <span><input type="text" class="analyzeInfo-input3" id="middleGameCombativePower" name="middleGameCombativePower" maxlength="50" value="${analyzeInfoDetailInfo.middleGameCombativePower }"></span></li>
		                                                <li>중반 선방율 : <span><input type="text" class="analyzeInfo-input3" id="middleGameSaveRate" name="middleGameSaveRate" maxlength="50" value="${analyzeInfoDetailInfo.middleGameSaveRate }"></span></li>
		                                                <li>중반 실착횟수 : <span><input type="text" class="analyzeInfo-input3" id="middleGameMissCnt" name="middleGameMissCnt" maxlength="50" value="${analyzeInfoDetailInfo.middleGameMissCnt }"></span></li>
		                                                <li>중반 실착율 : <span><input type="text" class="analyzeInfo-input3" id="middleGameMissRate" name="middleGameMissRate" maxlength="50" value="${analyzeInfoDetailInfo.middleGameMissRate }"></span></li>
		                                            </ul>
		                                        </div>
		                                        <div class="record-item">
		                                            <h4>끝내기<p><strong><input type="text" class="analyzeInfo-input2 dev-number event-chart event-mychart" id="endGame" name="endGame" value="${analyzeInfoDetailInfo.endGame }" maxlength="3"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>끝내기 DEFENSE : <span><input type="text" class="analyzeInfo-input3" id="endGameDefense" name="endGameDefense" maxlength="50" value="${analyzeInfoDetailInfo.endGameDefense }"></span></li>
		                                                <li>끝내기 DEFENSE_FAILURE : <span><input type="text" class="analyzeInfo-input3 event-chart" id="endGameDefenseFailure" name="endGameDefenseFailure" maxlength="50" value="${analyzeInfoDetailInfo.endGameDefenseFailure }"></span></li>
		                                                <li>끝내기 TURN_THE_TABLES : <span><input type="text" class="analyzeInfo-input3 event-chart" id="endGameTurnTheTables" name="endGameTurnTheTables" maxlength="50" value="${analyzeInfoDetailInfo.endGameTurnTheTables }"></span></li>
		                                                <li>끝내기 실착횟수 : <span><input type="text" class="analyzeInfo-input3" id="endGameMissCnt" name="endGameMissCnt" maxlength="50" value="${analyzeInfoDetailInfo.endGameMissCnt }"></span></li>
		                                            </ul>
		                                        </div>
		                                    </div>
		                                    <div class="clear">
		                                        <div class="record-item">
		                                            <h4>승부호흡<p><strong><input type="text" class="analyzeInfo-input2 dev-number event-chart event-mychart" id="gameTiming" name="gameTiming" value="${analyzeInfoDetailInfo.gameTiming }" maxlength="3"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>승부호흡 흔들기 : <span><input type="text" class="analyzeInfo-input3" id="gameTimingWave" name="gameTimingWave" maxlength="50" value="${analyzeInfoDetailInfo.gameTimingWave }"></span></li>
		                                                <li>승부호흡 수비 : <span><input type="text" class="analyzeInfo-input3" id="gameTimingDefence" name="gameTimingDefence" maxlength="50" value="${analyzeInfoDetailInfo.gameTimingDefence }"></span></li>
		                                            </ul>
		                                        </div>
		                                        <div class="record-item">
		                                            <h4>기술<p><strong><input type="text" class="analyzeInfo-input2 dev-number event-chart event-mychart" id="technique" name="technique" value="${analyzeInfoDetailInfo.technique }" maxlength="3"></strong>/100</p></h4>
		                                            <ul>
		                                                <li>기술 가치판단 : <span><input type="text" class="analyzeInfo-input3" id="techniqueValueJudgment" name="techniqueValueJudgment" maxlength="50" value="${analyzeInfoDetailInfo.techniqueValueJudgment }"></span></li>
		                                                <li>기술 행마 : <span><input type="text" class="analyzeInfo-input3" id="techniqueHaengma" name="techniqueHaengma" maxlength="50" value="${analyzeInfoDetailInfo.techniqueHaengma }"></span></li>
		                                                <li>기술 수읽기 : <span><input type="text" class="analyzeInfo-input3" id="techniqueReading" name="techniqueReading" maxlength="50" value="${analyzeInfoDetailInfo.techniqueReading }"></span></li>
		                                            </ul>
		                                        </div>
		                                    </div>
		                                    <div class="chart"></div>
		                                </div>
		                                <div class="inner">
		                                    <c:set var="iszero" value="${(fn:substring(analyzeInfoDetailInfo.analyzeInfoId, 4, 5) ne '0') ? 4 : 5 }"></c:set>
		                                    <h3><span class="span-mm">${fn:substring(analyzeInfoDetailInfo.analyzeInfoId, iszero, 6) }</span>월 시험성적</h3>
		                                    <table>
		                                        <colgroup>
		                                            <col width="20%"><col width="20%"><col width="20%"><col width="20%"><col width="20%">
		                                        </colgroup>
		                                        <thead>
		                                            <tr>
		                                                <th>포석/형세판단</th>
		                                                <th>행마/가치판단</th>
		                                                <th>수읽기/사활</th>
		                                                <th>끝내기/계가</th>
		                                                <th>총점</th>
		                                            </tr>
		                                        </thead>
		                                        <tbody>
		                                            <tr>
		                                                <td><input type="text" class="analyzeInfo-input4 dev-number event-exam" id="examOpeningPositionalJudgment" name="examOpeningPositionalJudgment" maxlength="50" value="${analyzeInfoDetailInfo.examOpeningPositionalJudgment }"></td>
		                                                <td><input type="text" class="analyzeInfo-input4 dev-number event-exam" id="examHaengmaValueJudgment" name="examHaengmaValueJudgment" maxlength="50" value="${analyzeInfoDetailInfo.examHaengmaValueJudgment }"></td>
		                                                <td><input type="text" class="analyzeInfo-input4 dev-number event-exam" id="examReadingLifeAndDeath" name="examReadingLifeAndDeath" maxlength="50" value="${analyzeInfoDetailInfo.examReadingLifeAndDeath }"></td>
		                                                <td><input type="text" class="analyzeInfo-input4 dev-number event-exam" id="examEndGameCounting" name="examEndGameCounting" maxlength="50" value="${analyzeInfoDetailInfo.examEndGameCounting }"></td>
		                                                <td id="examTotal">${analyzeInfoDetailInfo.examTotal }</td>
		                                            </tr>
		                                        </tbody>
		                                    </table>
		                                </div>
		                                <div class="inner">
		                                    <h3><span class="span-mm">${fn:substring(analyzeInfoDetailInfo.analyzeInfoId, iszero, 6) }</span>월 메모사항</h3>
		                                    <div class="memo" style="padding: 0px;">
		                                    	<textarea rows="" cols="" style="border: 0px solid #ddd; width: 100%; height: 100%" id="etc" name="etc">${analyzeInfoDetailInfo.etc }</textarea>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="btn-wrap">
                                    <a href="javascript:void(0)" id="btn-save" class="btns point">저장</a>
                                    <c:if test="${isDetail }"><a href="javascript:void(0)" id="btn-delete" class="btns gray">삭제</a></c:if>
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
                <div>
                    <input type="text" class="dev-number" id="pop-analyzeInfoyyyymm" title="대상년월" placeholder="대상년월 202210 형식 입력" required>
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
		$.ajax({
			type: 'post',
			url: '/admin/analyzeInfo/user-search',
			data: {
				keyword : keyword.value
			},
			success: function (data) {
				$("#list").html("");
				if (data.result) {
					makeListJson(data.userList);
				} else {
					alert(data.msg);
				}
			}
		});
	}

	// @brief 사용자검색창 - 주소지 선택
	//
	function makeListJson(userList) {
		let htmlStr = '';
		if(userList.length > 0) {
			$.each(userList, function(i, item) {
				let userNm = item.userNm;
				let userId = item.userId;
				let userNickNm = item.userNickNm;
				let param = {};
				param.userId = userId;
				param.userNm = userNm;
				param.userGrade = item.userGrade;
				param.levelNm = item.levelNm;
				param.age = item.age;
				param.team = item.team;
				htmlStr += '<li>';
				htmlStr += 	   "<a href='javascript:void(0)' onClick='inputTextUser("+JSON.stringify(param)+");'>";
				htmlStr +=         '<strong>'+userNm+'</strong>';
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

	// @brief 사용자검색창 - 사용자 삽입
	function inputTextUser(param) {
		let analyzeInfoId = $('#pop-analyzeInfoyyyymm').val();
		if (isNullOrEmpty(analyzeInfoId)) {
			alert('대상년월을 입력하세요.');
			return false;
		}
		$('#grade').removeClass();
		$('#grade').addClass(param.userGrade);
		$('#userNm').text(param.userNm);
		$('#userId').val(param.userId);
		$('#analyzeInfoId').val(analyzeInfoId);
		$('.temps').empty();
		$('#analyzeInfoyyyymm').after('<p class="temps">'+analyzeInfoId+'</p>');
		$('.span-mm').text(Number(analyzeInfoId.substr(4,2)));
		$('#level').after('<p class="temps">'+param.levelNm+'</p>');
		$('#age').after('<p class="temps">'+param.age+'</p>');
		$('#team').after('<p class="temps">'+param.team+'</p>');
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