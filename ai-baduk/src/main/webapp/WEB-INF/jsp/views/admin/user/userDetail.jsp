<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>사용자관리 상세</title>
</head>
<script type="text/javascript">
	$(function() {
		"use strict"
		$('#btn-update').click(function() {
			user.update();
		});

		$('#btn-cancle').click(function() {
			window.location.href="/admin/user/main";
		});

		$('#btn-update-password').click(function() {
			user.changePasswoad();
		});
		for(let i=1920; i<=2020; i++) {
			user.createOptionForElements('userYear', i);
		}
		var userYear = '${fn:substring(userDetailInfo.birth, 0, 4) }';
		$('#userYear').val(userYear).prop('selected');

		for(let i=1; i<=12; i++) {
			i = (i < 10) ? "{0}{1}".format('0', i) : i;
			user.createOptionForElements('userMonth', i);
		}
		var userMonth = '${fn:substring(userDetailInfo.birth, 4, 6) }';
		$('#userMonth').val(userMonth).prop('selected');

		for(let i=1; i<=31; i++) {
			i = (i < 10) ? "{0}{1}".format('0', i) : i;
			user.createOptionForElements('userDay', i);
		}
		var userDay = '${fn:substring(userDetailInfo.birth, 6, 8) }';
		$('#userDay').val(userDay).prop('selected');

		$('#userYear, #userMonth').change(function() {
			user.changeTheDay();
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
		}
	}
</script>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="form" name="form">
			<section class="container">
	            <div class="keyvi"></div>
	            <section class="content personal">
	                <div class="inner">
	                    <div class="tab-wrap ea4">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li class="on"><a href="/admin/user/main">사용자관리</a></li>
		                        <li><a href="/admin/signUp">회원가입</a></li>
		                    </ul>
	                        <div class="inner-depth">
	                            <div class="tab-inner">
	                                <h2>회원정보수정</h2>
	                                <ul>
	                                    <li><strong>아이디</strong>${userDetailInfo.userId }<input type="hidden" id="userId" name="userId" value="${userDetailInfo.userId }"/></li>
	                                    <li>
	                                    	<strong>권한</strong>
	                                    	<div class="fm-group">
			                                   	<c:forEach items="${codeCU004 }" var="item" varStatus="status">
													<div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" name="userAuth" id="userAuth${item.codeId }" value="${item.codeId }"
					                                    	<c:if test="${item.codeId eq userDetailInfo.userAuth}">checked</c:if>
					                                    >
					                                    <label class="fm-check-label" for="userAuth${item.codeId }">${item.codeNm }</label>
					                                </div>
			                                   	</c:forEach>
				                            </div>
				                        </li>
	                                    <li><strong>비밀번호 수정</strong><button type="button" onclick="baduk.layerOpen($(this), 'popPW')">비밀번호 변경</button></li>
	                                    <li>
	                                    	<strong>이름</strong>
	                                    	<div class="fm-group"><input type="text" id="userNm" name="userNm" title="이름" value="${userDetailInfo.userNm }" required></div>
	                                    </li>
	                                    <li>
	                                    	<strong>성별</strong>
	                                    	<div class="fm-group">
			                                   	<c:forEach items="${codeCU001 }" var="item" varStatus="status">
													<div class="fm-check fm-inline">
					                                    <input class="fm-check-input" type="radio" id="userSex${item.codeId }" value="${item.codeId }"
					                                    	<c:if test="${item.codeId eq userDetailInfo.userSex}">checked</c:if> disabled="disabled"
					                                    >
					                                    <label class="fm-check-label" for="userSex${item.codeId }">${item.codeNm }</label>
					                                </div>
			                                   	</c:forEach>
				                            </div>
		                                </li>
	                                    <li>
	                                    	<strong>고객등급</strong>
	                                    	<div class="fm-group" style="width: 500px;">
			                                   	<c:forEach items="${codeCU002 }" var="item" varStatus="status">
													<div class="fm-check fm-inline <c:if test="${status.index ne 0 and status.index % 2 == 0}">custem-fm-radio</c:if>">
					                                    <input class="fm-check-input" type="radio" name="userGrade" id="userGrade${item.codeId }" value="${item.codeId }"
					                                    	<c:if test="${item.codeId eq userDetailInfo.userGrade}">checked</c:if>
					                                    >
					                                    <label class="fm-check-label" for="userGrade${item.codeId }">${item.codeNm }</label>
					                                </div>
			                                   	</c:forEach>
				                            </div>
	                                    </li>
	                                    <li>
	                                    	<strong>연락가능번호</strong>
	                                    	<div class="fm-group phone">
		                                    	<span><input type="text" id="phoneNum1" name="phoneNum1" title="연락가능번호" value="${userDetailInfo.phoneNum1 }" maxlength="3" required></span>
		                                    	<span><input type="text" id="phoneNum2" name="phoneNum2" title="연락가능번호" value="${userDetailInfo.phoneNum2 }" maxlength="4" required></span>
		                                    	<span><input type="text" id="phoneNum3" name="phoneNum3" title="연락가능번호" value="${userDetailInfo.phoneNum3 }" maxlength="4" required></span>
	                                    	</div>
	                                    </li>
	                                    <li>
	                                    	<strong>주소</strong>
	                                    	<div class="fm-group address">
                                            	<span><input type="text" id="address" name="address" title="주소" value="${userDetailInfo.address }"></span>
                                        	</div>
	                                    </li>
	                                    <li><strong>생년월일</strong>
	                                    	<div class="fm-group birthday">
				                                <span>
				                                    <select id="userYear" name="userYear" class="" title="">
				                                        <option value="" disabled="disabled" selected="selected">연</option>
				                                    </select>
				                                </span>
				                                <span>
				                                    <select id="userMonth" name="userMonth" class="" title="">
				                                        <option value="" disabled="disabled" selected="selected">월</option>
				                                    </select>
				                                </span>
				                                <span>
				                                    <select id="userDay" name="userDay" class="" title="">
				                                        <option value="" disabled="disabled" selected="selected">일</option>
				                                    </select>
				                                </span>
	                            				<input type="hidden" id="birth" name="birth"/>
				                            </div>
	                                    </li>
	                                    <li>
		                                    <strong>이메일</strong>
		                                    <div class="fm-group"><input type="text" id="email" name="email" value="${userDetailInfo.email }"></div>
	                                    </li>
	                                    <li>
		                                    <strong>직업</strong>
		                                    <div class="fm-group"><input type="text" id="job" name="job" value="${userDetailInfo.job }"></div>
	                                    </li>
	                                    <li>
		                                    <strong>소속</strong>
		                                    <div class="fm-group"><input type="text" id="team" name="team" value="${userDetailInfo.team }"></div>
	                                    </li>
	                                    <li>
	                                    	<strong>기력</strong>
								            <div class="fm-group">
		                                    	<select id="level" name="level">
										            <c:forEach items="${codeCU003 }" var="item">
														<option value="${item.codeId }" <c:if test="${userDetailInfo.level eq item.codeId }">selected</c:if>>${item.codeNm }</option>
				                                   	</c:forEach>
									            </select>
	                                        </div>
	                                    </li>
	                                </ul>
	                                <p>※ 개인정보 수정은 전화(000-0000)나 1:1 문의를 이용해주시기 바랍니다.</p>
	                            </div>
	                            <div class="btn-wrap">
                                    <a href="javascript:void(0)" id="btn-update" class="btns point">수정</a>
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
	<!-- 비밀번호 수정 -->
	<section class="wrap-layer-popup" id="popPW">
	    <div class="dimmed"></div>
	    <div class="pop-layer">
	        <div class="head">
	            <h1>비밀번호를 변경해주세요</h1>
	            <button class="btn-close">Close</button>
	        </div>
	        <div class="contents">
				<form id="password-form" name="password-form">
	                <input type="hidden" id="userId2" name="userId" value="${userDetailInfo.userId }"/>
	                <%-- <span class="form-ele"><label for="oldPW">기존 비밀번호</label><input type="password" id="oldPW" name="oldPW" title="기존 비밀번호" required></span>
	                <p>* 비밀번호 규칙에 제한이 없습니다.</p> --%>
	                <span class="form-ele"><label for="newPW">새 비밀번호</label><input type="password" id="newPW" name="newPW" title="새 비밀번호" required></span>
	                <span class="form-ele"><label for="newPWcheck">새 비밀번호 확인</label><input type="password" id="newPWcheck" title="새 비밀번호 확인" name="newPWcheck" required></span>
	                <div>
	                    <button type="button" id="btn-update-password">확인</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</section>
</body>
</html>