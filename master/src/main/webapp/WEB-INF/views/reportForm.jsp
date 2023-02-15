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

	<div class="container" role="main">

	<div id="ListHeader" >신고 양식</div>
	
	<br>

	<form name="form" id="form" method="POST" action="report">
	<table class=reportTable>
			<tr>
				<th>신고자 ID</th>
				<td>${list.userId}</td>
			</tr>
			
			<c:if test="${reportType eq 1}">
				<tr>
				<th>신고할 글 제목</th>
				<td>${list.subject}</td>
				</tr>
			</c:if>
				
			<c:if test="${reportType eq 2}">
				<tr>
				<th>신고할 댓글</th>
				<td>${list.comContent}</td>
				</tr>
			</c:if>
				
			<tr>
				<th>신고 사유</th>
				<td class="reasons">
				<textarea name="reason" id="reason" rows="8">${list.content}</textarea>
				<div style="text-align:right; margin-right: 11px;" class="count"><span>0</span>/100</div>
				</td>
			</tr>
		
	</table>
			
		<div style="margin-top: 30px" align="center">
			<span style="margin-right: 30px"><button type="button" class="btn btn-outline-primary btn_wp" id="btnCancel" onclick="history.back()">취소</button></span>
			<span><button type="submit" class="btn btn-outline-primary btn_wp" id="btnSave">신고하기</button></span>
		</div>
		
		<input type="hidden" name ="reportType" value="${reportType}">
		<input type="hidden" name ="id" id="id" value="${id}">
	</form>
	<br><br>
	</div>
</body>

<%
	if (session.getAttribute("sessionId") == null) {
	response.sendRedirect("loginForm");
} else {
}
%>

<script>


$(".reasons textarea").keyup(function(){
	  var content = $(this).val();
	  $('.reasons .count span').html(content.length);
	  if (content.length > 100){
	    alert("최대 100자까지 입력 가능합니다.");
	    $(this).val(content.substring(0, 100));
	    $('.reasons .count span').html(100);
	  }
});


</script>



</html>



