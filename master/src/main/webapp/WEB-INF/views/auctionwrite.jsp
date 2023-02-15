<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송 정보 저장 페이지</title>
<link rel="stylesheet" href="resources/css/auctionwrite.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
<br><br>

<form action="addr" method = "post">
		
	<h3 id="AuSub">배송 정보 저장 페이지</h3>
	<br>
<div id="AuWr">		
	<ul id="AuUl">
	
		
	
		<li>
			<label for="userName">이름</label>
			<input type ="text" id="name" name="name" maxlength="50" placeholder="50자 이내로 입력하세요">
		</li>
		
		<li>
			<label for="userPNum">전화번호</label>
			<input type ="text" id="phone" name="phone" placeholder="숫자만 입력해 주세요">
		</li>
		
		<li>
			<label for="userAddr">주소</label>
			<input type ="text" id="postcode"  name="postcode" placeholder="우편번호">
			<input type="button" onclick="sample6_execDaumPostcode()" id="addrFindBtn" value="주소 찾기">
		</li>
		
		<li>
			<label>&nbsp;</label>
			<input type ="text" id="roadAddr"  name="roadAddr" placeholder="도로명 주소를 입력해 주세요">
		</li>
		
		<li>
			<label>&nbsp;</label>
			<input type ="text" id="detailAddr" name="detailAddr" placeholder="상세 주소를 입력해 주세요">
		</li>
		
		<li>
			<label>&nbsp;</label>
			<input type ="text" id="sample6_extraAddress" name="detailAddrinfo" placeholder="상세 주소를 입력해 주세요">			
		</li>
		
		<li>
			<label for="userMemo">배송메모</label>
			<input type ="text" id="memo" name="memo" placeholder="메모를 입력해 주세요.">
		</li>
		
		<li>			
			<input id="poTe" type='hidden' readonly value="${postId}" id="postId" name="postId" > 
		</li>
		
		<li>
			<input id="saveBtn" type="submit" value="저장하기">
		</li>
	
	</ul>
</div>
</form>
<br><br>

</body>
<script type="text/javascript">
var addrChk = false;


$name = $("#name");
$phone = $("#phone");
$postcode = $("#postcode");
$roadAddr = $("#roadAddr");
$detailAddr = $("#detailAddr");
$memo = $("#memo");
$postId = $("#postId");

$("#saveBtn").click(function(){
		
	
	if($name.val() == ''){
		alert("이름을 입력해 주세요");
		$name.focus();
	}else if($phone.val() == ''){
		alert("전화번호를 입력해 주세요");
		$phone.focus();
	}else if($postcode.val() == ''){
		alert("우편번호를 입력해 주세요");
		$postcode.focus();
	}else if($roadAddr.val() == ''){
		alert("도로명 주소를 입력해 주세요");
			$roadAddr.focus();		
	}else if($detailAddr.val() == ''){
		alert("상세 주소를 입력해 주세요");
		$$detailAddr.focus();
	}
	
// 	else{
// 		console.log('서버로 전송');
// 		var param = {};
// 		param.name = $name.val();
// 		param.phone = $phone.val();
// 		param.postcode = $postcode.val();
// 		param.roadAddr = $roadAddr.val();
// 		param.detailAddr = $detailAddr.val();
// 		param.memo = $memo.val();
// 		param.postId = $postId.val();
// 		console.log(param);
		
// 		$.ajax({
// 			type:'POST',
// 			url:'ajaxAddr',
// 			data: param,
// 			dataType:'JSON',
// 			success:function(data){
// 				console.log(data);
// 				if(data.success>0){
// 					alert("배송 정보 저장 성공했습니다.");
// 					location.href="./";
// 				}else{
// 					alert("배송 정보 저장 실패했습니다.");
// 				}
// 			},
// 			error:function(e){				
// 				console.log(e);
// 				console.log("여기");
// 			}
// 		});
		
});

var msg = "${msg}";
if(msg != ""){
	alert(msg);
}


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