<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="addrUpdateForm">
	
	
	<h3 id="AuSub">배송정보 수정 페이지</h3>
	<br>
<div>	
	
	<ul>	
		<li>
			<label for="userName">이름</label>
			<input type = "text" value="${shipping.name}" name="name" >
			<p>${shipping.name}</p>
		</li>
		
		<li>
			<label for="userPNum">전화번호</label>
			<input type ="text" value="${shipping.phone}" name="phone" >
			<p>${shipping.phone}</p>
		</li>
		
		<li>
			<label for="userAddr">주소</label>
			<input type="text" value="${shipping.postcode}" name="postcode" >
			<input type="text" value="${shipping.roadAddr}" name="roadAddr" >
			<input type="text" value="${shipping.detailAddr}" name="detailAddr" >
		</li>
		
		<li>
			<label for="userMemo">배송메모</label>
			<input type="text" value="${shipping.memo}" name="memo" >
		</li>
		
		<li>
			<input type='hidden' value="${shipping.postId}" readonly name="postId">
		
		</li>
		
		<li>
			<input id="saveBtn" type="submit" value="수정하기">
		</li>
	
	</ul>
</div>	
</form>	

</body>
</html>