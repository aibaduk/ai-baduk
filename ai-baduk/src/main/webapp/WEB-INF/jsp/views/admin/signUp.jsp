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
//		if (!singUp.validate()) {
		if (!ai.isValidate($('#form'))) {
			return;
		}
		if (confirm('회원가입을 진행하시겠습니까?')) {
			singUp.goAjaxJoin();
		}
		return false;
	});

	for(let i=1920; i<=2020; i++) {
		singUp.createOptionForElements('userYear', i);
	}

	for(let i=1; i<=12; i++) {
		i = (i < 10) ? "{0}{1}".format('0', i) : i;
		singUp.createOptionForElements('userMonth', i);
	}

	for(let i=1; i<=31; i++) {
		i = (i < 10) ? "{0}{1}".format('0', i) : i;
		singUp.createOptionForElements('userDay', i);
	}

	$('#userYear, #userMonth').change(function() {
		singUp.changeTheDay();
	});

});

var singUp = {
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
			singUp.createOptionForElements('userDay', i);
		}
		$('#userDay').val(tmpDayVal).prop('selected', true);
	},
	/* validate: function() {
		let userId = $('#userId').val();
		if (isNullOrEmpty(userId)) {
			alert('아이디를 입력하세요');
			$('#userId').focus();
			return false;
		}
		let userNm = $('#userNm').val();
		if (isNullOrEmpty(userNm)) {
			alert('이름을 입력하세요');
			$('#userNm').focus();
			return false;
		}
		let userPw = $('#userPw').val(); // 자바스크립트 정규식 https://tjddnjs625.tistory.com/28
		if (isNullOrEmpty(userPw)) {
			alert('비밀번호를 입력하세요');
			$('#userPw').focus();
			return false;
		}
		let phoneNum1 = $('#phoneNum1').val();
		let phoneNum2 = $('#phoneNum2').val();
		let phoneNum3 = $('#phoneNum3').val();
		if (isNullOrEmpty(phoneNum1) || isNullOrEmpty(phoneNum2) || isNullOrEmpty(phoneNum3)) {
			alert('연락가능번호를 입력하세요');
			let id = isNullOrEmpty(phoneNum1) ? 'phoneNum1' : isNullOrEmpty(phoneNum2) ? 'phoneNum2' : 'phoneNum3';
			$('#'+id).focus();
			return false;
		}
		return true;
	}, */
	setData: function() {
		let userYear = fnNull($('#userYear').val());
		let userMonth = fnNull($('#userMonth').val());
		let userDay = fnNull($('#userDay').val());
		let birth = "{0}{1}{2}".format(userYear, userMonth, userDay);
		$('#birth').val(birth);
		let emailId = $('#emailId').val();
		let emailDomain = $('#emailDomain').val();
		let email = "{0}@{1}".format(emailId, emailDomain);
		$('#email').val(email);
	},
	goAjaxJoin: function() {
		singUp.setData();
		$.ajax({
			type: 'post',
			url: '/signUp',
			data: $('#form').serialize(),
			success: function (data) {
				if (data.result) {
					alert('회원가입이 되었습니다.');
					window.location.href='/'; // main, singUp, 사용자 관리 선택
				} else {
					alert(data.msg);
				}
			}
		});
	}
}

</script>
<body>
	<div class="wrapper">
		<form id="form" method="post" action="/signUp">
			<!-- container(s) -->
	        <div class="container join">
	            <section>
	                <div class="inner">
	                    <a href="/"><h1>한국바둑AI연구소</h1></a>
	                    <ul>
	                        <li>
	                            <label for="" class="fm-label">아이디 <span class="essential">*</span></label>
	                            <div class="fm-group"><input type="text" id="userId" name="userId" title="아이디" placeholder="" required></div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">이름 <span class="essential">*</span></label>
	                            <div class="fm-group"><input type="text" id="userNm" name="userNm" title="이름" required></div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">성별 <span class="essential">*</span></label>
	                            <div class="fm-group">
	                                <c:forEach items="${codeCU001 }" var="item" varStatus="status">
										<div class="fm-check fm-inline">
		                                    <input class="fm-check-input" title="성별" type="radio" name="userSex" id="userSex${item.codeId }" required value="${item.codeId }" <c:if test="${status.index== 0}">checked="checked"</c:if>>
		                                    <label class="fm-check-label" for="userSex${item.codeId }">${item.codeNm }</label>
		                                </div>
                                   	</c:forEach>
	                            </div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">권한 <span class="essential">*</span></label>
	                            <div class="fm-group">
	                            	<c:forEach items="${codeCU004 }" var="item" varStatus="status">
										<div class="fm-check fm-inline">
		                                    <input class="fm-check-input" type="radio" name="userAuth" id="userAuth${item.codeId }" required value="${item.codeId }" <c:if test="${status.index== 0}">checked="checked"</c:if>>
		                                    <label class="fm-check-label" for="userAuth${item.codeId }">${item.codeNm }</label>
		                                </div>
                                   	</c:forEach>
	                            </div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">비밀번호 <span class="essential">*</span></label>
	                            <div class="fm-group"><input type="password" id="userPw" name="userPw" placeholder=""></div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">고객등급</label>
	                            <div class="fm-group">
                                   	<c:forEach items="${codeCU002 }" var="item" varStatus="status">
										<div class="fm-check fm-inline" <c:if test="${status.index % 2 == 0}">style="margin-left:0"</c:if>>
		                                    <input class="fm-check-input" type="radio" name="userGrade" id="userGrade${item.codeId }" value="${item.codeId }">
		                                    <label class="fm-check-label" for="userGrade${item.codeId }">${item.codeNm }</label>
		                                </div>
                                   	</c:forEach>
	                            </div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">연락 가능 번호 <span class="essential">*</span></label>
	                            <div class="fm-group phone">
	                                <span><input type="text" id="phoneNum1" name="phoneNum1" title="연락 가능 번호1" placeholder="" required></span>
	                                <span><input type="text" id="phoneNum2" name="phoneNum2" title="연락 가능 번호2" placeholder="" required></span>
	                                <span><input type="text" id="phoneNum3" name="phoneNum3" title="연락 가능 번호3" placeholder="" required></span>
	                            </div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">주소</label>
	                            <div class="fm-group address">
	                                <div>
	                                    <input type="text" id="zipcode" placeholder="">
	                                    <button type="button" onclick="execDaumPostcode()">찾아보기</button>
	                                </div>
	                                <span><input type="text" id="addr" placeholder=""></span>
	                                <span><input type="text" id="detailAddr" placeholder=""></span>
	                            </div>
	                            <input type="hidden" id="address" name="address"/>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">생년월일</label>
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
	                            </div>
	                            <input type="hidden" id="birth" name="birth"/>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">이메일</label>
	                            <div class="fm-group mail">
	                                <span><input type="text" id="emailId" placeholder=""></span>
	                                <span><input type="text" id="emailDomain" placeholder=""></span>
	                            </div>
	                            <input type="hidden" id="email" name="email"/>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">직업</label>
	                            <div class="fm-group"><input type="text" id="job" name="job" placeholder=""></div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">소속</label>
	                            <div class="fm-group"><input type="text" id="team" name="team" placeholder=""></div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">기력</label>
	                            <div class="fm-group">
	                            	<select id="level" name="level">
							            <c:forEach items="${codeCU003 }" var="item">
											<option value="${item.codeId }">${item.codeNm }</option>
	                                   	</c:forEach>
						            </select>
	                            </div>
	                        </li>
	                    </ul>
	                    <div class="btn-wrap">
	                        <button type="button" class="btns" id="btn-signUp">가입하기</button>
	                    </div>
	                </div>
	            </section>
	        </div>
	        <!-- container(e) -->
	    </form>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
<!-- <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#zipcode').val(data.zonecode);
                $('#addr').val("{0}{1}".format(addr, extraAddr));
                // 커서를 상세주소 필드로 이동한다.
                $('#detailAddr').focus();
            }
        }).open();
    }
</script> -->
</html>