<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
	table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
		background-color: mintcream;
	}
</style>
</head>
<body>
	<c:if test="${sessionScope.sessionLevel eq 2}">
		<a href="auctionConfirm?postId=${postId}">낙찰 확정</a>
	</c:if>
	<h2 id="postId">입찰 기록</h2>
	<table>
		<thead>
			<tr>
				<th>아이디</th>
				<th>입찰 포인트</th>
				<th>입찰 시간</th>
			</tr>
		</thead>
		<tbody id="list">
		</tbody>
	</table>
</body>
<script>
var postId = "${postId}";
listCall(postId);
//let date = new Date(year, monthIndex, day, hours, minutes, seconds, milliseconds);

function listCall(postId){
	$.ajax({
		type:'GET',
		url:'bidLogCall',
		data:{postId: postId},
		dataType:'JSON',
		success:function(data){
			console.log(data);
			if(data.login == false){
				alert('로그인이 필요한 서비스입니다.');
				location.href='./';
			}else{
				drawList(data.list);
			}
		},
		error:function(e){
			console.log(e);			
		}
	});
}//listCall

function drawList(list){
	var content='';
	for (var i = 0; i < list.length-1; i++) {
		let userId = list[i].userId
		content += '<tr>';
//		content += '<td>'+userId.replace(/(?<=.{1})./gi, "*")+'</td>';
		content += '<td>'+userId.replace(/.{2}$/, "**")+'</td>';
		content += '<td>'+list[i].bidPoint+'</td>';
		let date = new Date(list[i].bidDate);
		content += '<td>'+date+'</td>';
		content += '</tr>';
	}
	$('#list').empty();		//append하기 전에 비워주는 작업
	$('#list').append(content);
}


</script>
</html>