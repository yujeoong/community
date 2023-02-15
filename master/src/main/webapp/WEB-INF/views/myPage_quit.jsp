<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/myPage.css">
<style>

</style>
<%@ include file="header.jsp" %>
</head>
<body>
<h1 style="padding:10px 10px;"><span class= m1 style="margin-left: 10px 0px;">MY PAGE</span></h1>
<hr size="4" color="black">
<div class=menu1>
	<div class=menu style="margin-top: 20px;"><span><a href="myPage">내 회원 정보</a></span></div><br>
	<div class=menu><span class=a><a href="myPost">내가 쓴 글</a></span></div><br>
	<div class=menu><span class=b><a href="myAuction">내가 낙찰한 경매</a></span></div><br>
	<div class=menu><span class=c><a href="myPoint">포인트 기록</a></span></div><br>
	<div class=menu><span class=d><a href="quitChk">회원 탈퇴</a></span></div><br>
</div>
	
<div>
	<table class=table1> <!-- 해당 정보들 가져오기  -->
		<tr>
			<td>아이디</td>
			<td>${list.userId}</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>********</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>${list.nickname}</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${list.email}</td>
		</tr>
		<tr>
			<td>보유포인트</td>
			<td>${list.point}</td>
		</tr>
	</table>
</div>

	<button id="quitFin">탈퇴하기</button>

</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

$("#quitFin").on("click",function(){
	if(confirm('정말 탈퇴하시겠습니까?')){
	}	
	
	$.ajax({
		type:'POST',
		url:'quitFin',
		data:{},
		dataType:'json',
		success:function(data){
			if(data.msg1){
				alert(data.msg1);
				location.href="./";
			}else if(data.msg2){
				alert(data.msg2)
			}else{
				console.log("탈퇴완료");
			}
		},
		error:function(e){
			console.log(e);
		}
	});
}); 

	

</script>
</html>