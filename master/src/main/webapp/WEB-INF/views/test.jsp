<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script> -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script src="resources/js/jquery.twbsPagination.js"></script>
<link rel="stylesheet" href="resources/css/myPage.css">
<style>
table, th, td {
	border : 1px solid;
	border-collapse: collapse;
	padding: 5px 10px;
}
</style>
</head>
<body>
<h1 style="padding:5px 10px;">My Page</h1>
<hr size="4" color="black">
<div class=menu1>
	<div class=menu style="margin-top: 20px;"><span><a href="myPage">내 회원 정보</a></span></div><br>
	<div class=menu><span class=a><a href="myPost" class="myPost()">내가 쓴 글</a></span></div><br>
	<div class=menu><span class=a><a href="#">내가 낙찰한 경매</a></span></div><br>
	<div class=menu><span class=a><a href="#">포인트 기록</a></span></div><br>
	<div class=menu><span class=a><a href="#">회원 탈퇴</a></span></div><br>
</div>

<div>
<span style="font-size: 20pt"><a href="myPost">게시물</a></span>/<span style="font-size: 20pt"><a href="myComment">댓글</a></span>
	<div>
		<table>
			<thead>
				<tr>
					<th><input type="checkbox" id="all"/></th>
					<th>번호postid</th>
					<th>번호</th>
					<th>게시판</th>
					<th>글제목</th>
					<th>작성날짜</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
			<tr>
		 	<td colspan="6" id="paging">
		 		<div class="container">
		 			<nav aria-label="Page navigation" style="text-align:center">
		 				<ul class="pagination" id="pagination"></ul>
		 			</nav>
		 		</div>
		 	</td>
		</tr>
		</table>
		<div><button onclick="del()">삭제</button></div>
	</div>
</div>
<!-- 		<div id="pagint"> -->
<!-- 			<div class="container"> -->
<!-- 				<nav aria-label="Page navigation" style="text-align: center;"> -->
<!-- 				<ul class="pagination" id="pagination"></ul> -->
<!-- 				</nav> -->
<!-- 			</div> -->
<!-- 		</div> -->
</body>
<script>

/*
var msg = "${msg}";
if(msg != ""){
	alert(msg);
*/

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



var showPage = 1;
listCall(showPage); //hoisting

function listCall(page){
	$.ajax({
		type:'GET',
		url:'list',
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
		content += '<td><input type="checkbox" value="'+list[i].postId+'"/></td>';
		content += '<td>'+list[i].postId+'</td>';
		content += '<td>'+list[i].RowNum+'</td>';
		content += '<td>'+list[i].categoryName+'</td>';
		content += '<td>'+list[i].subject+'</td>';
		var date = new Date(list[i].regDate);
		content += '<td>'+date.toLocaleDateString('ko-KR')+'</td>';		
		content += '</tr>';
	}
	$('#list').empty();
	$('#list').append(content);
}

function del(){
	
	var chkArr = [];
	
	$('input[type="checkbox"]:checked').each(function(idx,item){
		if($(this).val() != 'on'){
			chkArr.push($(this).val());			
		}
	});	
	console.log(chkArr);
	
	$.ajax({
		type:'get',
		url:'del',
		data:{'delList':chkArr},
		dataType:'json',
		success:function(data){
			console.log(data);
			if(data.msg != ""){
				alert(data.msg);
				// 삭제가 완료 되면 ajax 는 기본적으로 페이지를 새로고침 하지 않는다.
				// 그래서 리스트를 다시 호출해 그려야 한다.
				//listCall();
			}
		},
		error:function(e){
			console.log(e);
		}
	});
}

/*
var detail=window.location.search.split('?detail=')[1];
console.log(detail);

var page=1;
AjaxCall(page);

function AjaxCall(page){	
	
	$.ajax({
		type:"get"
		,dataType:"JSON"
		,url:"myPost_ajax"
		,data:{"detail":detail,"page":page}
		,success:function(data){
			console.log("AJAX 성공");
			console.log(data);
			listCall(data.list);
			$("#pagination").twbsPagination({
				startPage : 1 // 시작 페이지
				,totalPages : data.total // 총 페이지 수
				,visiblePages : 4 // 기본으로 보여줄 페이지 수
				,onPageClick : function(e, page) { // 클릭했을때 실행 내용
					console.log(page);
					AjaxCall(page);
				}
			});	
		}
		,error:function(e){
			console.log("AJAX 실패");
			console.log(e);
		}
		
	});
}

function listCall(list){
	var content="";
	for (i = 0; i < list.length; i++) {
		content += "<tr>";
		content += '<td><input type="checkbox" value="'+list[i].postId+'"/></td>';
		content += "<td id='id'>" + list[i].RowNum + "</td>";
		content += "<td>" + list[i].categoryName + "</td>";
		content += "<td>" + list[i].subject + "</td>";
		var date=new Date(list[i].regDate);
		content +="<td>"+date.toLocaleDateString("ko-KR")+" "+date.toLocaleTimeString("en-US",{hour12:false})+"</td>";
		content += "</tr>";
	}
	$("#list").empty();
	$("#list").append(content);
}
*/





</script>
</html>