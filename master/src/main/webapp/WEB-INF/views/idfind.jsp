<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 페이지</title>
<link rel="stylesheet" href="resources/css/idfind.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style></style>
</head>
<body>
<%@ include file="header.jsp" %>
<br><br>


<div id="idFind">
	<form action = "idRemember">
		<h3>아이디 찾기 검색결과</h3>
		<br>
			<ul>
			
				<li>
					<label>이메일 </label>
					<input type="text" id="email" name="email" value="${email}" readonly>  
					
				</li>
				<li>					
					<label>아이디 </label> 
					<input type="text"id="userId" name="userId" value="${sessionScope.emails}" readonly> 
				</li>
				<br><br>
				<li>
					<input type="button" id=loginBtn	 onclick="location.href='loginForm'" value="로그인">
					<input type="submit" value="비밀번호 설정">
					<input type="button" onclick="history.go(-1);" value="뒤로가기">
				</li>
			</ul>
	</form>
</div>
</body>
<script>


</script>
</html>