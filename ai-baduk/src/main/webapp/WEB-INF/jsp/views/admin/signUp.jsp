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
	$('#signUp-tit').click(function() {
		window.location.href='/';
	});
	$('#btn-signUp').click(function() {
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
	setData: function() {
		let userYear = fnNull($('#userYear').val());
		let userMonth = fnNull($('#userMonth').val());
		let userDay = fnNull($('#userDay').val());
		let birth = "{0}{1}{2}".format(userYear, userMonth, userDay);
		$('#birth').val(birth);
		let emailId = $('#emailId').val();
		let emailDomain = $('#emailDomain').val();
		let email = "{0}@{1}".format(emailId, emailDomain);
		email = (email == '@') ? '' : email;
		$('#email').val(email);
		let addr = fnNull($('#addr').val());
		let detailAddr = fnNull($('#detailAddr').val());
		let address = "{0}{1}".format(addr, detailAddr);
		$('#address').val(address);
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
					window.location.href='/admin/user/main';
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
	        <div class="container join">
	            <section>
	                <div class="inner">
	                    <h1 id="signUp-tit">한국바둑AI연구소</h1>
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
	                            <div class="fm-group"><input type="password" id="userPw" name="userPw" title="비밀번호" required></div>
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
	                            <label for="" class="fm-label">연락가능번호 <span class="essential">*</span></label>
	                            <div class="fm-group phone">
	                                <span><input type="text" id="phoneNum1" name="phoneNum1" title="연락가능번호" placeholder="" required maxlength="3"></span>
	                                <span><input type="text" id="phoneNum2" name="phoneNum2" title="연락가능번호" placeholder="" required maxlength="4"></span>
	                                <span><input type="text" id="phoneNum3" name="phoneNum3" title="연락가능번호" placeholder="" required maxlength="4"></span>
	                            </div>
	                        </li>
	                        <li>
	                            <label for="" class="fm-label">주소</label>
	                            <div class="fm-group address">
	                                <div>
	                                    <input type="text" id="zipcode" placeholder="">
	                                    <!-- <button type="button" onclick="execDaumPostcode()">찾아보기</button> 다음 API 호출 -->
	                                    <button type="button" onclick="baduk.layerOpen($(this), 'popAddress')">찾아보기</button>
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
	    </form>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
<!-- 상세주소 팝업 -->
<section class="wrap-layer-popup" id="popAddress">
	<input type="hidden" id="currentPage" value="1"/>
	<input type="hidden" id="countPerPage" value="100"/>
    <div class="dimmed"></div>
    <div class="pop-layer">
        <div class="head">
            <h1>주소 검색</h1>
            <button class="btn-close">Close</button>
        </div>
        <div class="contents">
            <div class="search">
                <div>
                    <input type="text" id="searchAddr" onkeydown="enterSearch();" placeholder="도로명주소, 건물명 또는 지번 입력">
                    <button type="button" onClick="getAddr();"><span class="blind">검색</span></button>
                </div>
                <p>도로명/지번 주소를 입력해주세요.</p>
            </div>
            <!-- 검색 결과값 -->
            <div class="list-wrap">
                <div class="scroll">
                    <ul id="addr_list"></ul>
                </div>
            </div>
            <!-- //검색 결과값 -->
        </div>
    </div>
</section>
<script type="text/javascript">
	// @brief 주소검색창 - 키보드 Enter키 입력
	function enterSearch() {
		var evt_code = (window.netscape) ? event.which : event.keyCode;
		if (evt_code == 13) {
			event.keyCode = 0;
			getAddr();
		}
	}
	// @brief 주소검색창 - 데이터 조회
	function getAddr() {
		// 적용예 (api 호출 전에 검색어 체크)
		let keyword = document.getElementById("searchAddr");
		if(!checkSearchedWord(keyword)) {
			return;
		}
		$.ajax({
			url: "http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do",
			type: "post",
			data: {
				confmKey : "U01TX0FVVEgyMDIyMTAwMjE2NTAzNzExMzAxODQ=",
				currentPage : document.getElementById("currentPage").value,
				countPerPage : document.getElementById("countPerPage").value,
				keyword : keyword.value,
				resultType : "json"
			},
			dataType : "jsonp",
			crossDomain : true,
			success : function(jsonStr) {
				$("#list").html("");
				let errCode = jsonStr.results.common.errorCode;
				let errDesc = jsonStr.results.common.errorMessage;
				if(errCode == "0") {
					if(jsonStr != null) {
						makeListJson(jsonStr);
					}
				} else {
					alert(errDesc);
				}
			},
			error : function(xhr, status, error) {
				alert("주소검색 시 에러가 발생했습니다.");
			}
		});
	}

	// @brief 주소검색창 - 주소지 선택
	function makeListJson(jsonStr) {
		let htmlStr = '';
		if(jsonStr.results.common.totalCount > 0) {
			/* $("#totalCnt").html(jsonStr.results.common.totalCount); */
			$(jsonStr.results.juso).each(function() {
				let zipNo = this.zipNo;
				let bdNm = this.bdNm;
				let roadAddr = this.roadAddr;
				let jibunAddr = this.jibunAddr;
				htmlStr += '<li>';
				htmlStr += 	   "<a href='javascript:void(0)' onClick='inputTextAddress(\""+zipNo+"\", \""+roadAddr+"\");'>";
				htmlStr +=         '<strong>'+bdNm+'</strong>';
				htmlStr +=         '<p><em>지번</em>'+jibunAddr+'</p>';
				htmlStr +=         '<p><em>도로명</em>'+roadAddr+'</p>';
				htmlStr +=     '</a>';
				htmlStr += '</li>';
			});
			/* pageMake(jsonStr); */
		} else {
			htmlStr += '<li>조회된 데이터가 없습니다.<br/>다시 검색하여 주시기 바랍니다.</li>';
		}
		$("#addr_list").html(htmlStr);
	}

	// @brief 주소검색창 - 주소지 삽입
	function inputTextAddress(zipcode, address) {
		document.getElementById("zipcode").value = zipcode;
		document.getElementById("addr").value = address;
        $('.btn-close').trigger('click');
	}

	// @brief 주소검색창 - 닫기
	function addressWindowClose() {
		$("#searchAddr").val("");
		$("#addr_list").empty();
		/* $("#pagingList").empty(); */
		$("#currentPage").val("1");
	}

	// @brief 주소검색창 - 특수문자 제거
	function checkSearchedWord(obj) {
		if(obj.value.length > 0) {
			// 특수문자 제거
			var expText = /[%=><]/;
			if(expText.test(obj.value) == true) {
				alert("특수문자를 입력 할수 없습니다.") ;
				obj.value = obj.value.split(expText).join("");
				return false;
			}

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
		return true ;
	}

	// @brief 주소검색창 - 페이징 생성
	function pageMake(jsonStr) {
		var total = jsonStr.results.common.totalCount;				// 총건수
		var pageNum = document.getElementById("currentPage").value;	// 현재페이지
        var pageBlock = Number(document.getElementById("countPerPage").value);	// 페이지당 출력 개수
		var paggingStr = "";

		// 검색 갯수가 페이지당 출력갯수보다 작으면 페이징을 나타내지 않는다.
		if(total > pageBlock) {
			var totalPages = Math.floor((total - 1) / pageNum) + 1;
			var firstPage = Math.floor((pageNum - 1) / pageBlock) * pageBlock + 1;
			if(firstPage <= 0) { firstPage = 1; };
			var lastPage = (firstPage - 1) + pageBlock;
			if(lastPage > totalPages) { lastPage = totalPages; };
			var nextPage = lastPage + 1;
			var prePage = firstPage - pageBlock;
			if(firstPage > pageBlock) {
				paggingStr += "<a href='javascript:;' onClick='goPage(" + prePage + ");'>◀</a>";
				paggingStr += "&nbsp;";
			}
			for(let num = firstPage; lastPage >= num; num++) {
				if(pageNum == num) {
					paggingStr += "<a style='font-weight:bold;color:#0000FF;' href='javascript:;'>" + num + "</a>";
					paggingStr += "&nbsp;";
				} else {
					paggingStr += "<a href='javascript:;' onClick='goPage(" + num + ");'>" + num + "</a>";
					paggingStr += "&nbsp;";
				}
			}
			if(lastPage < totalPages) {
				paggingStr += "<a href='javascript:;' onClick='goPage(" + nextPage + ");'>▶</a>";
			}
		}
        $("#pagingList").html(paggingStr);
	}

	// @brief 페이징 이동
	function goPage(pageNum) {
		document.getElementById("currentPage").value = pageNum;
		getAddr();
	}
</script>
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