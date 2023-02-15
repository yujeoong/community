<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정찾기 페이지</title>
<link rel="stylesheet" href="resources/css/find.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style></style>
</head>

<%@ include file="header.jsp" %>

<body>
<br><br> 	
	
	
	<br>	
		<div id="Find">
		<div id="idFind">
			<form action="idfind" method="post">
				<h3>아이디 찾기</h3>
				<br>
				<ul>
					<li>
						<label for="emailForId">이메일</label>
						<input type="text" id="email" name="email" required>					
					</li>
					
					<li>
						<input type="submit" id="idFindBtn" value="아이디 찾기">
						<input type="button" onclick="history.go(-1);" id="backBtn" value="뒤로가기">
					</li>				
				</ul>			
			</form>
		</div>
		
		<br><br>
		
	<h3>비밀번호 재설정</h3>
	<br>
		
		<div id="ResetPw">
			<form action="ResetPw" method="post">
				<ul>
					
					<li>
						<label>이메일 </label>
						<input type="text" id= "email" name="email" value="${email}">					
					</li>
					
					<li>
						<label>아이디 </label>
						<input type="text" id="userId" name="userId" value="${userId}">
					</li>
					
					<li>
						<input type="submit" id="resetBtn" value="재설정">
						<input type="button" onclick="history.go(-1);" id="backBtn" value="뒤로가기">
					</li>	
				
				</ul>			

			</form>
		</div>
	</div>


</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}
</script>
</html>