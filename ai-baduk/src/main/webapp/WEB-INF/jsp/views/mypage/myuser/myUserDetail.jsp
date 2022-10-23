<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>회원정보 수정</title>
</head>
<script type="text/javascript">
	$(function() {
		"use strict"
		$('#btn-update').click(function() {
			user.update();
		});

		$('#btn-update-password').click(function() {
			user.changePasswoad();
		});
	});
	var user = {
		update: function() {
			if (!ai.isValidate($('#form'))) {
				return;
			}
			if (confirm('회원정보를 수정하시겠습니까?')) {
				$.ajax({
					type: 'post',
					url: '/mypage/user/update',
					data: $('#form').serialize(),
					success: function (data) {
						if (data.result) {
							alert('회원정보가 수정되었습니다.');
							window.location.href='/mypage/user/detail';
						} else {
							alert(data.msg);
						}
					}
				});
			}
		},
		changePasswoad: function() {
			if (!ai.isValidate($('#password-form'))) {
				return;
			}
			if (confirm('비밀번호를 변경하시겠습니까?')) {
				$.ajax({
					type: 'post',
					url: '/mypage/user/update-password',
					data: $('#password-form').serialize(),
					success: function (data) {
						if (data.result) {
							alert('비밀번호가 변경되었습니다.');
							window.location.href='/mypage/user/detail';
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
	                    <div class="tab-wrap ea2">
		                    <ul class="tab-menu">
		                        <li class="on"><a href="/mypage/user/detail">회원정보수정</a></li>
		                        <li><a href="/mypage/analyzeInfo/detail">개인 분석정보</a></li>
		                    </ul>
		                    <div class="inner-depth">
	                            <div class="tab-inner">
	                                <h2>회원정보수정</h2>
	                                <ul>
	                                    <li>
	                                    	<strong>아이디</strong>${userDetailInfo.userId }
	                                    	<input type="hidden" id="userId" name="userId" value="${userDetailInfo.userId }"/>
	                                    </li>
	                                    <li>
	                                    	<strong>비밀번호 수정</strong><button type="button" onclick="baduk.layerOpen($(this), 'popPW')">비밀번호 변경</button>
	                                    </li>
	                                    <li>
	                                    	<strong>이름</strong>
	                                    	<div class="fm-group"><input type="text" id="userNm" name="userNm" title="이름" value="${userDetailInfo.userNm }" required></div>
	                                    </li>
	                                    <li>
	                                    	<strong>닉네임</strong>
	                                    	<div class="fm-group"><input type="text" id="userNickNm" name="userNickNm" title="닉네임" value="${userDetailInfo.userNickNm }" required></div>
	                                    </li>
	                                    <li>
	                                    	<strong>성별</strong>${userDetailInfo.userSexNm }
		                                </li>
	                                    <li>
	                                    	<strong>고객등급</strong>${userDetailInfo.userGradeNm }
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
	                                    <li><strong>생년월일</strong>${userDetailInfo.birth }</li>
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
	                                    	<strong>기력</strong>${userDetailInfo.levelNm }
	                                    </li>
	                                </ul>
	                            </div>
	                            <div class="btn-wrap">
                                    <a href="javascript:void(0)" id="btn-update" class="btns point">수정</a>
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
	                <span class="form-ele"><label for="oldPW">기존 비밀번호</label><input type="password" id="oldPW" name="oldPW" title="기존 비밀번호" required></span>
	                <!-- <p>* 새 비밀번호는 영문,숫자를 이용해서 8자~16자 이내로 생성해주세요.</p> -->
	                <p>* 비밀번호 규칙에 제한이 없습니다.</p>
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