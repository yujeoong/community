<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/myPage.css">
<style>

</style>
</head>
<body>
<%@ include file="header.jsp" %>
<h1 style="padding:10px 30px;"><span class= m1 style="margin-left: 10px 0px;">MY PAGE</span></h1>
<hr size="4" color="black">
<div class=menu1>
	<div class=menu style="margin-top: 20px;"><span><a href="myPage">내 회원 정보</a></span></div><br>
	<div class=menu><span class=a><a href="myPost">내가 쓴 글</a></span></div><br>
	<div class=menu><span class=b><a href="myAuction">내가 낙찰한 경매</a></span></div><br>
	<div class=menu><span class=c><a href="myPoint">포인트 기록</a></span></div><br>
	<div class=menu><span class=d><a href="quitChk">회원 탈퇴</a></span></div><br>
</div>

<form action="myPageUF" method="post">
	<div class=quit>
		<br>
		<p>비밀번호를 한번 더 입력하세요.</p>
		<br>
		<input type="password" name="userpass">
		<input type="submit" value="확인">
	</div>
</form>

</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}
</script>
</html>