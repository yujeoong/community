<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>

</style>
</head>
<body>
	<h3><span>경기 결과 입력</span></h3>
	<p>경기 결과 입력과 동시에 해당 경기 결과를 맞춘 회원들에게 포인트 지급</p>
	<form action="matchResult" method="post">
		<p>게시글 번호: ${postId}</p>
        <ul>
        <c:forEach var="poll" items="${pollList}">
			<li>
				<input type="radio" name="winPollId" value="${poll.pollId}" />${poll.selection}
			</li>
        </c:forEach>
        </ul>
		<input type="submit" id="submit" value="저장">
		<input type="hidden" name="postId" value="${postId}">
		</form>
</body>
<script></script>
</html>