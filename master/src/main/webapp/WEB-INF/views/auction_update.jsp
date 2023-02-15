<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송 정보 수정 페이지</title>
<link rel="stylesheet" href="resources/css/auctionwrite.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
<br><br>

<form action="addrUpdate" method = "post">
	<h3 id="AuSub">배송 정보 수정 페이지</h3>
	<br>
<div id="AuWr">	

	<ul id="AuUl">
	
	
		<li>
			<label for="userName">이름</label>
			<input type="text" name="name" value="${shipping.name}">
		</li>
		
		<li>
			<label for="userPNum">전화번호</label>
			<input type="text" name="phone" value="${shipping.phone}" >
		</li>
		
		<li>
			<label for="userAddr">주소</label>
			<input type="text" id="postcode" name="postcode" value="${shipping.postcode}">
			<input type="button" onclick="sample6_execDaumPostcode()" id="addrFindBtn" value="주소 찾기"><br>
		</li>
		
		<li>
			<label>&nbsp;</label>
			<input type="text" id="roadAddr" name="roadAddr" value="${shipping.roadAddr}">		
		</li>
		
		<li>
			<label>&nbsp;</label>
			<input type="text" id="detailAddr" name="detailAddr" value="${shipping.detailAddr}">
		</li>
		
		<li>
			<label>&nbsp;</label>
			<input type ="text" id="sample6_extraAddress" name="detailAddrinfo" placeholder="상세 주소를 입력해 주세요"> 
		</li>
		
		<li>
			<label for="userMemo">배송메모</label>
			<input type="text" name="memo" value="${shipping.memo}">
		</li>
		
		<li>
			<input type="hidden" name="postId" value="${shipping.postId}" readonly>
		</li>
		
		<li>
			<input id="saveBtn" type="submit" value="수정하기">
		</li>
	
	</ul>
</div>	
</form>	

</body>
<script type="text/javascript">
function sample6_execDaumPostcode() {
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
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("roadAddr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddr").focus();
        }
    }).open();
}


</script>
</html>