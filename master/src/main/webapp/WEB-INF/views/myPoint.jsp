<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="header.jsp" %>
<!-- <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script> -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/myPage.css">
<style>
table, th, tr,  td {
	border-left : none;
	border-right : none;
	border-collapse: collapse;
	padding: 5px 10px;
}
</style>
</head>
<body>
<h1 style="padding:10px 30px;"><span class= m1 style="margin-left: 10px 0px;">MY PAGE</span></h1>
<hr size="4" color="black">
<div class=menu1>
	<div class=menu style="margin-top: 20px;"><span><a href="myPage">내 회원 정보</a></span></div><br>
	<div class=menu><span class=a><a href="myPost">내가 쓴 글</a></span></div><br>
	<div class=menu><span class=b><a href="myAuction">내가 낙찰한 경매</a></span></div><br>
	<div class=menu><span class=c><a href="myPoint">포인트 기록</a></span></div><br>
	<div class=menu><span class=d><a href="quitChk">회원 탈퇴</a></span></div><br>
</div>

<div>
	<br>
	<div>
	<h4 class=point> 현재 ${list.nickname} 님의 포인트는 <span style="color:red;">${list.point} POINT </span>  입니다.</h4>
	</div>
	<br>
	<div>
	<div id=point1>
		<h3>포인트 적립/차감 내역</h3>
	</div>	
		<div class=mpost>
		<table class=mpost1>
			<thead>
				<tr>
					<th>번호</th>
					<th>발생일시</th>
					<th>상세내역</th>
					<th>적립/차감 포인트</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
			<tr>
			 	<td colspan="4" id="paging">
			 		<div class="container">
			 			<nav aria-label="Page navigation" style="text-align:center">
			 				<ul class="pagination" id="pagination"></ul>
			 			</nav>
			 		</div>
			 	</td>
			</tr>
		</table>
		</div>
	</div>
</div>
</body>
<script>

/*
var msg = "${msg}";
if(msg != ""){
	alert(msg);


$("#all").click(function(){
	var $chk = $('input[type="checkbox"]');
	console.log($chk);
	// attr : 정적인 속성을 다룰때
	// prop : 동적인 속성을 다룰때
	if($(this).is(':checked')){
		$chk.prop('checked',true);
	}else{
		$chk.prop('checked',false);
	}
});
*/



var showPage = 1;
listCall(showPage); //hoisting

function listCall(page){
	$.ajax({
		type:'GET',
		url:'myPoint_listCall',
		data:{page:page},
		dataType:'JSON',
		success:function(data){
			console.log(data);
			drawList(data.list);
			//플러그인 적용
			$('#pagination').twbsPagination({
				startPage:1, //시작페이지
				totalPages: data.total, //총 페이지 수
				visiblePages:5, //기본으로 보여줄 페이지 수
				onPageClick:function(e,page){ //클릭했을 때 실행 내용
					//console.log(e);
					listCall(page);
				}
			});
		},
		error:function(e){
			console.log(e);
		}
	});
};

function drawList(list){
	var content = '';
	for(var i=0; i<list.length;i++){
		console.log(list);		
		content += '<tr>';
		content += '<td>'+list[i].pointId+'</td>';
		var date = new Date(list[i].createDate);
		content += '<td>'+date.toLocaleDateString('ko-KR')+'</td>';		
		content += '<td>'+list[i].comment+'</td>';
		content += '<td>'+list[i].point+'</td>';
		content += '</tr>';
	}
	$('#list').empty();
	$('#list').append(content);
}







</script>
</html>