<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>AI 바둑연구소</title>
</head>
<script type="text/javascript">
$(function() {
	"use strict"
	$('#btn-signUp').click(function() {
		if (confirm('회원가입을 진행하시겠습니까?')) {
			let userYear = $('#userYear').val();
			let userMonth = $('#userMonth').val();
			let userDay = $('#userDay').val();
			let birth = "{0}{1}{2}".format(userYear, userMonth, userDay);
			$('#birth').val('19860701');
			let emailId = $('#emailId').val();
			let emailDomain = $('#emailDomain').val();
			let email = "{0}{1}{2}".format(emailId, '@', emailDomain);
			$('#email').val(email);

			console.log($('#birth').val());
			console.log($('#email').val());

			$("form").submit();
		}
		return false;
	});
});
</script>
<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
		<form id="form" method="post" action="/signUp">
			<input type="hidden" id="birth" name="birth">
			<input type="hidden" id="email" name="email">
			<section class="container">
		        <div class="keyvi"></div>
		        <section class="content brd">
		            <div class="inner">
		                <div class="tab-wrap ea5">
		                    <ul class="tab-menu">
		                        <li><a href="/admin/code/main">공통코드</a></li>
		                        <li><a href="javascript:void(0)">메뉴관리</a></li>
		                        <li><a href="javascript:void(0)">사용자관리</a></li>
		                        <li><a href="javascript:void(0)">분석정보</a></li>
		                        <li class="on"><a href="/admin/signUp">회원가입</a></li>
		                    </ul>
		                    <div class="container">
						        <div class="form-group">
						            <label for="userId">아이디</label>
						            <input type="text" class="form-control" id="userId" name="userId" placeholder="사용자 아이디">
						        </div>
						        <div class="form-group">
						            <label for="inputAddress">이름</label>
						            <input type="text" class="form-control" id="userNm" name="userNm" placeholder="사용자 이름">
						        </div>
						        <div class="form-group">
									<label>성별</label>
                                   	<c:forEach items="${codeCU001 }" var="item">
										<span class="form-check form-check-inline">
										  <input class="form-check-input" style="width: 80px;" type="radio" name="userSex" id="userSex${item.codeId }" value="${item.codeId }">
										  <label class="form-check-label" style="width: 80px;" for="userSex${item.codeId }">${item.codeNm }</label>
										</span>
                                   	</c:forEach>
						        </div>
						        <div class="form-group">
						            <label>권한</label>
                                   	<c:forEach items="${codeCU004 }" var="item">
										<span class="form-check form-check-inline">
										  <input class="form-check-input" style="width: 80px;" type="radio" name="userAuth" id="userAuth${item.codeId }" value="${item.codeId }">
										  <label class="form-check-label" style="width: 80px;" for="userAuth${item.codeId }">${item.codeNm }</label>
										</span>
                                   	</c:forEach>
						        </div>
						        <div class="form-group">
						            <label for="userPw">비밀번호</label>
						            <input type="password" class="form-control" id="userPw" name="userPw" placeholder="사용자 비밀번호">
						        </div>
						        <div class="form-group">
						            <label for="userGrade">회원등급</label>
						            <c:forEach items="${codeCU002 }" var="item">
										<span class="form-check form-check-inline">
										  <input class="form-check-input" style="width: 80px;" type="checkbox" name="userGrade" id="userGrade${item.codeId }" value="${item.codeId }">
										  <label class="form-check-label" style="width: 80px;" for="userGrade${item.codeId }">${item.codeNm }</label>
										</span>
                                   	</c:forEach>
						        </div>
						        <div class="form-group">
						            <label for="">연락가능번호</label>
						            <input type="text" class="form-control" id="phoneNum1" name="phoneNum1" placeholder="010" style="width: 100px; display: inline;">-
						            <input type="text" class="form-control" id="phoneNum2" name="phoneNum2" placeholder="xxxx" style="width: 100px; display: inline;">-
						            <input type="text" class="form-control" id="phoneNum3" name="phoneNum3" placeholder="xxxx" style="width: 100px; display: inline;">
						        </div>
						        <div class="form-group">
						            <label for="">주소</label>
						            <input type="text" class="form-control" id="address" name="address" placeholder="주소">
						        </div>
						        <div class="form-group">
						            <label for="">생년월일</label>
						            <select class="form-control" id="userYear"  style="width: 100px; display: inline;"></select>
						            <select class="form-control" id="userMonth" style="width: 100px; display: inline;"></select>
						            <select class="form-control" id="userDay" style="width: 100px; display: inline;"></select>
						        </div>
						        <div class="form-group">
						            <label for="">이메일</label>
						            <input type="text" class="form-control" id="emailId" style="width: 100px; display: inline;">@
						            <input type="text" class="form-control" id="emailDomain" style="width: 100px; display: inline;">
						            <select class="form-control" style="width: 100px; display: inline;" onclick="setEmailDomain(this.value);return false;">
										<option value="">-선택-</option>
									    <option value="naver.com">naver.com</option>
									    <option value="gmail.com">gmail.com</option>
									    <option value="hanmail.net">hanmail.net</option>
									    <option value="hotmail.com">hotmail.com</option>
									    <option value="korea.com">korea.com</option>
									    <option value="nate.com">nate.com</option>
									    <option value="yahoo.com">yahoo.com</option>
						            </select>
						        </div>
						        <div class="form-group">
						            <label for="">직업</label>
						            <input type="text" class="form-control" id="job" name="job">
						        </div>
						        <div class="form-group">
						            <label for="">소속</label>
						            <input type="text" class="form-control" id="team" name="team">
						        </div>
						        <div class="form-group">
						            <label for="">기력</label>
						            <select class="form-control" id="level" name="level">
							            <c:forEach items="${codeCU003 }" var="item">
											<option value="${item.codeId }">${item.codeNm }</option>
	                                   	</c:forEach>
						            </select>
						        </div>
						        <button class="btn btn-primary" id="btn-signUp">가입 완료</button>
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