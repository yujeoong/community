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
<link rel="stylesheet" href="resources/css/myPage.css">
<script src="resources/js/jquery.twbsPagination.js"></script>
<style>
table, th, td {
	border : 1px solid;
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

<div class=mpost>
	<div>
		<table class=mpost1>
			<thead>
				<tr>
					<th>번호</th>
					<th>경매 아이템</th>
					<th>경매 기간</th>
					<th>낙찰가</th>
					<th>배송지 입력</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
			<tr>
			 	<td colspan="5" id="paging">
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
</body>
<script>

/*
var msg = "${msg}";
if(msg != ""){
	alert(msg);
*/



var showPage = 1;
listCall(showPage); //hoisting

function listCall(page){
	$.ajax({
		type:'GET',
		url:'myAuction_listCall',
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
		content += '<td>'+list[i].postId+'</td>';
		content += '<td>'+list[i].subject+'</td>';
		var date1 = new Date(list[i].regDate);
		var date2 = new Date(list[i].endDate);
		content += '<td>'+date1.toLocaleDateString('ko-KR')+' ~  '+date2.toLocaleDateString('ko-KR')+'</td>';
		var point = list[i].winningPoint;
		var result = point.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		content += '<td>'+result+' POINT</td>';
		now = new Date();
// 		console.log("1"+date2.setDate(date2.getDate()+14));
		console.log("1111: "+((now.getTime()-date2.getTime())/(1000*60*60*24)));
		
		if(((now.getTime()-date2.getTime())/(1000*60*60*24))>14){
			content += '<td><button class=a6 id="aaa" disabled><input id="test" type="hidden" value="'+list[i].postId+'">'+"기간만료"+'</button></td>';		
		}else{
			content += '<td><button class=a5 id="aaa"><input id="test"  type="hidden" value="'+list[i].postId+'">'+"입력/수정"+'</button></td>';					
		}
		content += '</tr>';
	}
	$('#list').empty();
	$('#list').append(content);
}

$(document).on("click","#aaa",function(){	
	var bbb=$(this).children("#test").val();
	console.log(bbb);
	location.href="addrForm?postId="+bbb;
	});

var msg = "${msg}";
if(msg != ""){
	alert(msg);
}



</script>
</html>