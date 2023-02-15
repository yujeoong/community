<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="resources/common.css" type="text/css">
<style>
</style>
</head>

<body>
<form action="addrForm">
	<table>
		<tr>
			<th>No.</th>
			<th>경매 아이템</th>
			<th>경매 기간</th>
			<th>낙찰가</th>
			<th>배송지 입력</th>
		</tr>
		
		<c:if test="${auclist.size()<1}">
		<tr><td colspan="6">낙찰 내역이 없습니다.</td></tr>
		</c:if>		
		
		<c:forEach items="${auclist}" var="auclist">
		<tr>
			<td><input type='text' value="${auclist.postId}" readonly name="postId"></td>
			<td>${auclist.subject}</td>
			<td>${auclist.endDate}</td>
			<td>${auclist.winningPoint}</td>
			<td><input type=submit value="배송정보"></td>
			<td><input type=button onclick="location.href='./addrDetail?postId=${auclist.postId}'" value="수정하기"></td>
		</tr>
		</c:forEach>
	</table>
</form>
</body>
<script></script>
</html>