<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie-edge">
<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="resources/css/header.css">

<style></style>
</head>

<body>

<header>
		<div>
			<h1><a href="./"><img alt="main" src="resources/img/head_logo.png"></a></h1>	
			<h2 class="hide">대메뉴</h2>
			<div id="nav">
					<ul>
	
						<li><a href="matchList">승부예측</a></li>
						<li><a href="newsList">뉴스반응</a></li>
						<li><a href="genPollList">일반투표</a></li>
						<li><a href="freeList">자유게시판</a></li>
						<li><a href="auctionList">경매</a></li>
						<li><a href="noticeList">공지사항</a></li>
						<li><a href="suggList">건의사항</a></li>
					</ul>
				</div>
				
				<ul class="spot">				
					<c:if test="${sessionScope.sessionId == null}">
						<li><a href="loginForm">로그인</a></li>
						<li><a href="joinForm">회원가입</a></li>
					</c:if>
					
					<c:if test="${sessionScope.sessionLevel == 3}">
						<li><a href="logout">로그아웃</a></li>	
						<li><a onclick="location.href='myPage'">마이페이지</a></li>
					</c:if>
					<c:if test="${sessionScope.sessionLevel == 2}">
						<li><a href="logout">로그아웃</a></li>	
						<li><a onclick="location.href='AdminmyPage'">관리페이지</a></li>
					</c:if>
					
					<c:if test="${sessionScope.sessionLevel == 1}">
						<li><a href="logout">로그아웃</a></li>	
						<li><a onclick="location.href='superadmin'">권한페이지</a></li>
					</c:if>
		
				</ul>	
			</div>	
	</header>



</body>
<script></script>
</html>