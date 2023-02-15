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

		<div class="pull-left">
			<c:if test="${categoryId eq 4}">
				<div id="ListHeader">자유게시판 글 수정</div>
			</c:if>
			<c:if test="${categoryId eq 6}">
				<div id="ListHeader">공지사항 글 수정</div>
			</c:if>
			<c:if test="${categoryId eq 7}">
				<div id="ListHeader">건의사항 글 수정</div>
			</c:if>
		</div>
		
		<br>

		<form name="form" id="form" method="POST" action="update_g" enctype="multipart/form-data">
			
			<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" class="form-control" name="subject" id="subject" value="${boarddto.subject}" placeholder="제목을 입력해 주세요.">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea class="form-control" rows="10" name="content" id="content" placeholder="내용을 입력해 주세요.">${boarddto.content}</textarea>
			</td>
		</tr>
		<tr>
			<th>사진</th>
			<td>
				<input type="file" name="file"><!-- multiple="multiple" -->
			<c:if test="${file.newFileName ne null}">
				<img src="/photo/${file.newFileName}">
				<br />
			</c:if>
			</td>
		</tr>
	</table>
			<div style="margin-top: 30px" align="center">
			<span style="margin-right: 30px"><button type="button" class="btn btn-outline-primary btn_wp" id="btnCancel" onclick="history.back()">취소</button></span>
			<span><button type="submit" class="btn btn-outline-primary btn_wp" id="btnSave">저장</button></span>
		</div>
			<input type="hidden" name="categoryId" value="${boarddto.categoryId}">
			<input type="hidden" name="postId" value="${boarddto.postId}">

<br><br>
		</form>
	</div>
</body>


<script>








</script>



</html>



