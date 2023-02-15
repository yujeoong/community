<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link rel="stylesheet" href="resources/css/login.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">


<style>
	table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	}
</style>
</head>
<body>
<%@ include file="header.jsp" %>

<br><br>
<h1 id="lt">로그인</h1>
<br>
<h5 id="ltt">Welcome! WITH KBO에 오신 것을 환영합니다.</h5>
<br>
<div id="logInfo">
	<form action="login" method="post">
	
		<ul id="logUl">
			<li>
				<label for="logid">아이디</label>
				<input type="text" name="id">
			</li>
			
			<li>
				<label for="logpw">비밀번호</label>
				<input type="password" name="pw">
			</li>
			
			<li id="logBtnLi">
				<input id="logBtn" type="submit" value="로그인">
			</li>
			<li id="lastLi">
				<input type="button" value="회원가입" onclick="location.href='joinForm'"/>
				<input type="button" value="계정찾기" onclick="location.href='idfindForm'">
			</li>		
		
		</ul>
	</form>
</div>
	
<!-- 	<table id="logInfo"> -->
<!-- 		<tr> -->
<!-- 			<th>ID</th> -->
<!-- 			<td><input type="text" name="id" /></td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<th>PW</th> -->
<!-- 			<td><input type="password" name="pw" /></td> -->
<!-- 		</tr> -->
<!-- 		<tr> -->
<!-- 			<th colspan="2"> -->
<!-- 				<input type="submit" value="LOGIN"/> -->
				
<!-- 			</th> -->
<!-- 		<tr>	 -->
<!-- 			<th colspan="2"> -->
<!-- 				<input type="button" value="회원가입" onclick="location.href='joinForm'"/> -->
<!-- 				<input type="button" value="계정 찾기" onclick="location.href='idfindForm'"> -->
<!-- 			</th> -->
<!-- 		</tr> -->
<!-- 	</table>	 -->



	
</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}
</script>
</html>