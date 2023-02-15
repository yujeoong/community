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
	
		<c:if test="${categoryId eq 1}">
			<div id="ListHeader">승부예측 글 작성</div>
		</c:if>
		<c:if test="${categoryId eq 2}">
			<div id="ListHeader">뉴스반응 글 작성</div>
		</c:if>
		<c:if test="${categoryId eq 3}">
			<div id="ListHeader">일반투표 글 작성</div>
		</c:if>
	
		<br>

		<form name="form" id="form" method="POST" action="write_p" enctype="multipart/form-data">
		
		
		<table>
		<tr>
			<th>제목</th>
			<td>
				<input style="width: 400px" type="text" class="form-control" name="subject" id="subject" placeholder="제목을 입력해 주세요.">
			</td>
		</tr>
		<tr>
			<th>투표 마감일</th>
			<td><p style="font: 12px verdana, dotum; margin-left:13px; text-align: left;">투표 마감일과 시간을 입력해주세요.</p>
				<input style="width: 400px" type="datetime-local" class="form-control" name="endDate" id="endDate">
			</td>
		</tr>
		<tr>
			<th>선택지</th>
			<td>
				<p style="font: 12px verdana, dotum; margin-left:13px; text-align: left;">선택지는 최대 5개까지 작성 가능합니다. 
				<span id="extcount" style="color: #ff0000; font: 13px verdana, dotum;">(2개)</span>
			</p>
			<input type="text" name="ext[]" class="input" style="margin-right: 26px;" placeholder="선택지를 입력해 주세요." >
				<br> <input type="text" name="ext[]" class="input" placeholder="선택지를 입력해 주세요.">
				<a href="#" class="add_btn"><img src="./resources/board/add-icon.png" /></a>
			<div class="append"></div>
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
			<td >
				<input type="file" name="file">
			</td>
		</tr>
	</table>
	<div style="margin-top: 30px" align="center">
				<span style="margin-right: 30px"><button type="button" class="btn btn-outline-primary btn_wp" id="btnCancel" onclick="history.back()">취소</button></span>
			<span><button type="submit" class="btn btn-outline-primary btn_wp" id="btnSave">저장</button></span>
	</div>
	
	
	<input type="hidden" name ="categoryId" value="${categoryId}">
		</form>
	</div>
	<br><br>
	
</body>
<hr>
<script>


// 선택지 Min n Max Nos.
$(document).ready(function(){
    var maxField = 5; //최대 개수
    var wrapper = $('.append');
    var extcnt = 2; // 최초 카운트 1
    var fieldHTML = '<div><input type="text" name="ext[]" value="" class="input" placeholder="선택지를 입력해 주세요."/> <a href="#" class="remove_btn"><img src="./resources/board/remove-icon.png"/></a></div>';
    $('.add_btn').click(function(){
        if(extcnt < maxField){
            extcnt++; // 숫자 증가
            $('.append').append(fieldHTML); // Add field
            $('#extcount').html("(" + extcnt + "개)");
        }
    });
    $(wrapper).on('click', '.remove_btn', function(e){
        e.preventDefault();
        $(this).parent('div').remove(); // Remove field
        extcnt--; // 카운트 감소
        $('#extcount').html("(" + extcnt + "개)");
    });
});




</script>
</html>



