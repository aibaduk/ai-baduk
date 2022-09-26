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

	$('#btn-insert').click(function() {
		user.Update();
	});

	$('#btn-cancle').click(function() {
		//window.location.href="/admin/code/main";
	});

});

/**
 * 사용자관리 수정
 */
var user = {
	update: function() {
		console.log('update');
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
	                                    <li><strong>아이디</strong>${userDetailInfo.userId }</li>
	                                    <li><strong>비밀번호 수정</strong><button type="button" onclick="baduk.layerOpen($(this), 'popPW')">비밀번호 변경</button></li>
	                                    <li><strong>이름</strong><input type="text" id="userNm" name="userNm" title="이름" value="${userDetailInfo.userNm }"></li>
	                                    <li><strong>전화번호</strong>
	                                    	<input type="text" id="phoneNum1" name="phoneNum1" title="연락 가능 번호1" value="${userDetailInfo.phoneNum1 }" maxlength="3">
	                                    	<input type="text" id="phoneNum2" name="phoneNum2" title="연락 가능 번호2" value="${userDetailInfo.phoneNum2 }" maxlength="4">
	                                    	<input type="text" id="phoneNum3" name="phoneNum3" title="연락 가능 번호3" value="${userDetailInfo.phoneNum3 }" maxlength="4">
	                                    </li>
	                                    <li><strong>주소</strong><input type="text" id="address" name="address" title="주소" value="${userDetailInfo.address }"></li>
	                                    <li><strong>생년월일</strong>
		                                    <select id="userYear" name="userYear" class="" title="">
		                                        <option value="" disabled="disabled" selected="selected">연</option>
		                                    </select>
		                                    <select id="userMonth" name="userMonth" class="" title="">
		                                        <option value="" disabled="disabled" selected="selected">월</option>
		                                    </select>
		                                    <select id="userDay" name="userDay" class="" title="">
		                                        <option value="" disabled="disabled" selected="selected">일</option>
		                                    </select>
	                                    </li>
	                                    <li><strong>직업</strong><input type="text" id="job" name="job" value="${userDetailInfo.job }"></li>
	                                    <li><strong>기력</strong>
	                                    	<select id="level" name="level">
									            <c:forEach items="${codeCU003 }" var="item">
													<option value="${item.codeId }" <c:if test="${userDetailInfo.level eq item.codeId }">selected</c:if>>${item.codeNm }</option>
			                                   	</c:forEach>
								            </select>
	                                    </li>
	                                </ul>
	                                <p>※ 개인정보 수정은 전화(000-0000)나 1:1 문의를 이용해주시기 바랍니다.</p>
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
	            <form>
	                <span class="form-ele"><label for="oldPW">기존 비밀번호</label><input type="password" id="oldPW" name="oldPW"></span>
	                <!-- <p>* 새 비밀번호는 영문,숫자를 이용해서 8자~16자 이내로 생성해주세요.</p> -->
	                <p>* 비밀번호 규칙에 제한이 없습니다.</p>
	                <span class="form-ele"><label for="newPW">새 비밀번호</label><input type="password" id="newPW" name="newPW"></span>
	                <span class="form-ele"><label for="newPWcheck">새 비밀번호 확인</label><input type="password" id="newPWcheck" name="newPWcheck"></span>
	                <div>
	                    <button type="button" id="btn-update-password">확인</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</section>
	<script type="text/javascript">
		$(function() {
			"use strict"
			$('#btn-update-password').click(function() {
				user.changePasswoad();
			});
		});
		var user = {
			changePasswoad: function() {
				/*
					* 체크포인트
					1. 새 비밀번호 / 새 비밀번호 확인 일치 체크
					2. 기존 비밀번호를 정확하게 입력했는지 여부
				*/
				if (!user.comparePassword()) {
					alert("새 비밀번호가 일치하지 않습니다.");
					$('#newPWcheck').val('');
					$('#newPWcheck').focus();
					return;
				}
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
			},
			comparePassword: function() {
				let newPW = $('#newPW').val();
				let newPWcheck = $('#newPWcheck').val();
				return newPW == newPWcheck;
			},
			setData: function() {

			}
		}
	</script>
</body>
</html>