<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel = "stylesheet" href="./resources/board/writeForm.css" type="text/css">
<style>


</style>
</head>
<body>

	<div class="container">

		<c:if test="${categoryId eq 5}">
			<div id="ListHeader">경매 글 작성</div>
		</c:if>
		<br>
		<form name="form" id="form" method="POST" action="write_a"	enctype="multipart/form-data">
		
		
		
		<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" class="form-control" name="subject" id="subject" placeholder="제목을 입력해 주세요.">
			</td>
		</tr>
		<tr>
			<th>경매 마감일</th>
			<td><p style="font: 13px verdana, dotum; margin-left:13px; text-align: left;">경매 마감일과 시간을 입력해주세요.</p>
				<input type="datetime-local" class="form-control" name="endDate" id="endDate">
			</td>
		</tr>
		<tr>
			<th>경매 시작가</th>
			<td>
				<input type="number" min='0' step='1' class="form-control" 
					name="startingPoint" id="startingPoint"
					placeholder="경매 시작가를 입력해 주세요.">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea class="form-control" rows="10" name="content" id="content" placeholder="내용을 입력해 주세요."></textarea>
			</td>
		</tr>
		<tr>
			<th>사진</th>
			<td>
				<input type="file" name="file">
			</td>
		</tr>
	</table>
	<div style="margin-top: 30px" align="center">
			<span style="margin-right: 30px"><button type="button" class="btn btn-outline-primary btn_wp" id="btnCancel" onclick="history.back()">취소</button></span>
			<span><button type="submit" class="btn btn-outline-primary btn_wp" id="btnSave">저장</button></span>
	</div>

			<input type="hidden" name="categoryId" value="${categoryId}">

		</form>
	</div>
	<br><br>
	
</body>

<script>








</script>
</html>



