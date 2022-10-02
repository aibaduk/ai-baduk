<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>AI 바둑연구소</title>
</head>

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
				currentPage : document.getElementById("currentPage").value, // 기본값 1
				countPerPage : document.getElementById("countPerPage").value, // 기본값 10 최대 100
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
		let htmlStr = "<thead><tr><th style='width:70px;'>우편번호</th><th>주소</th></tr></thead><tbody>";
		if(jsonStr.results.common.totalCount > 0) {
			$("#totoalOutcome").css("display", "block");
			$("#totalCnt").html(jsonStr.results.common.totalCount);
			$(jsonStr.results.juso).each(function() {
				let zipNo = this.zipNo;                  // 우편번호
				let roadAddr = this.roadAddr;        // 도로명 주소
				let jibunAddr = this.jibunAddr;       // 지번 주소
				htmlStr += "<tr>";
				htmlStr += "<td>";
				htmlStr += "<a href='javascript:;' onClick='inputTextAddress(\""+zipNo+"\", \""+roadAddr+"\");'>";
				htmlStr += zipNo;
				htmlStr += "</a>";
				htmlStr += "</td>";
				htmlStr += "<td>";
				htmlStr += "<a href='javascript:;' onClick='inputTextAddress(\""+zipNo+"\", \""+roadAddr+"\");'>";
				htmlStr += "도로명 : " + roadAddr;
				htmlStr += "</a>";
				htmlStr += "<br/>";
				htmlStr += "<a href='javascript:;' onClick='inputTextAddress(\""+zipNo+"\", \""+jibunAddr+"\");'>";
				htmlStr += "지번 : " + jibunAddr;
				htmlStr += "</a>";
				htmlStr += "</td>";
				htmlStr += "</tr>";
			});
			pageMake(jsonStr);
		} else {
			htmlStr += "<tr><td colspan='2'>조회된 데이터가 않습니다.<br/>다시 검색하여 주시기 바랍니다.</td></tr>";
		}
		htmlStr += "</tbody>";
		$("#list").html(htmlStr);
	}

	// @brief 주소검색창 - 주소지 삽입
	function inputTextAddress(zipcode, address) {
		document.getElementById("zipCode").value = zipCode;
		document.getElementById("address").value = address;
	}

	// @brief 주소검색창 - 열기
	function addressWindowOpen() {
		$("#wrap").slideDown();
		$("#searchAddr").focus();
	}

	// @brief 주소검색창 - 닫기
	function addressWindowClose() {
		$("#wrap").slideUp();
		$("#searchAddr").val("");
		$("#totoalOutcome").css("display", "none");
		$("#list").empty();
		$("#pagingList").empty();
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
<body>
	<div class="wrapper">
		<input type="hidden" id="currentPage" value="1"/>
		<input type="hidden" id="countPerPage" value="100"/>
		<h1>■ 행정안정부 - 주소 검색 API</h1>
		<input type="text" id="zipCode" value="" onClick="addressWindowOpen();" placeholder="00000" readonly/>
		<input type="button" onClick="addressWindowOpen();" value="우편번호 찾기"/>
		<div id="wrap">
			<img id="closeBtn" src="./close_box_red.png" onClick="addressWindowClose();"/>
			<div>
				<input type="text" id="searchAddr" value="" onkeydown="enterSearch();" placeholder="도로명주소, 건물명 또는 지번 입력"/>
				<input type="button" onClick="getAddr();" value="주소검색"/>
			</div>
			<div>
				<div id="totoalOutcome">
					검색결과 : <span id="totalCnt">0</span>
				</div>
				<table id="list"></table>
			</div>
			<div id="pagingList" style='text-align:center;'></div>
		</div>
		<div style="height:5px;"></div>
		<input type="text" id="address" value="" placeholder="도로명 주소, 지번 주소" readonly/>
		<div style="height:5px;"></div>
		<input type="text" id="detail" value="" placeholder="상세 주소지 입력"/>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
</html>