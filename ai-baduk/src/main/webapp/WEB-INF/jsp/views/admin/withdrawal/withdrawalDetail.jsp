<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>탈퇴회원관리 상세</title>
</head>
<script type="text/javascript">
	$(function() {
		"use strict"
		$('#btn-update').click(function() {
			withdrawal.update();
		});

		$('#btn-cancle').click(function() {
			window.location.href="/admin/withdrawal/main";
		});
	});
	var withdrawal = {
		update: function() {
			if (confirm('탈퇴회원을 회원으로 변경하시겠습니까?')) {
				$.ajax({
					type: 'post',
					url: '/admin/withdrawal/update',
					data: $('#form').serialize(),
					success: function (data) {
						if (data.result) {
							alert('회원으로 변경되었습니다.');
							window.location.href='/admin/user/main';
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
		                        <li><a href="/admin/user/main">사용자관리</a></li>
		                        <li class="on"><a href="/admin/withdrawal/main">회원가입</a></li>
		                    </ul>
	                        <div class="inner-depth">
	                            <div class="tab-inner">
	                                <h2>탈퇴회원상세</h2>
	                                <ul>
	                                    <li>
	                                    	<strong>아이디</strong>${withdrawalDetailInfo.userId }
	                                    	<input type="hidden" id="userId" name="userId" value="${withdrawalDetailInfo.userId }"/>
	                                    </li>
	                                    <li>
	                                    	<strong>권한</strong>${withdrawalDetailInfo.userAuthNm }
				                        </li>
	                                    <li>
	                                    	<strong>이름</strong>${withdrawalDetailInfo.userNm }
	                                    </li>
	                                    <li>
	                                    	<strong>닉네임</strong>${withdrawalDetailInfo.userNickNm }
	                                    </li>
	                                    <li>
	                                    	<strong>성별</strong>${withdrawalDetailInfo.userSexNm }
		                                </li>
	                                    <li>
	                                    	<strong>고객등급</strong>${withdrawalDetailInfo.userGradeNm }
	                                    </li>
	                                    <li>
	                                    	<strong>연락가능번호</strong>${withdrawalDetailInfo.phoneNum1 } - ${withdrawalDetailInfo.phoneNum2 } - ${withdrawalDetailInfo.phoneNum3 }
	                                    </li>
	                                    <li>
	                                    	<strong>주소</strong>${withdrawalDetailInfo.address }
	                                    </li>
	                                    <li>
	                                    	<strong>생년월일</strong>${withdrawalDetailInfo.birth }
	                                    </li>
	                                    <li>
		                                    <strong>이메일</strong>${withdrawalDetailInfo.email }
	                                    </li>
	                                    <li>
		                                    <strong>직업</strong>${withdrawalDetailInfo.job }
	                                    </li>
	                                    <li>
		                                    <strong>소속</strong>${withdrawalDetailInfo.team }
	                                    </li>
	                                    <li>
	                                    	<strong>기력</strong>${withdrawalDetailInfo.levelNm }
	                                    </li>
	                                </ul>
	                            </div>
	                            <div class="btn-wrap">
                                    <a href="javascript:void(0)" id="btn-update" class="btns point">원복</a>
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
</body>
</html>