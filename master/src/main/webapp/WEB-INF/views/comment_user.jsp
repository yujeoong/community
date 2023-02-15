<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}	
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous" />
	<script src="resources/js/jquery.twbsPagination.js"></script>
</head>
<body class="container">  
	<div class="row justify-content-md-center">
		<div class="col-9 ">
			<div class="d-flex justify-content-between">
				<img alt="" src="resources/img/head_logo.png" onclick="location.href='.'" style="width: 200px;">
				<p style="line-height: 100px;">${sessionId} 님<button class="btn btn-secondary"
				onclick="location.replace('logout')">로그아웃</button></p>
			</div>
			<hr>
			<h2>관리자 페이지</h2>
			<hr>
		</div>
	</div>
	<div class="row justify-content-md-center">
	<div class="col-2">
		<div class="d-grid gap-3">
			<div>
				<button class="p-2 border"
					onclick="location.href='AdminmyPage'" style="color: skyblue">회원 관리</button>
			</div>
			<div>
				<button class="p-2 border" onclick="location.href='Admin_All_Board'">게시글 관리</button>
			</div>
			<div>
				<button class="p-2 border" onclick="location.href='report_board'">신고 관리</button>
			</div>
		</div>
		<div class="d-grid gap-3" style="margin-top: 50px;"
		>
			<div>
				<button class="p-2 border" onclick="location.href='noticeList'">공지사항</button>
			</div>
			<div>
				<button class="p-2 border" onclick="location.href='suggList'">건의사항</button>
			</div>
		</div>
	</div>
	<div class="col-7">
		<span ><button onclick="profile()">프로필</button></span>
			 <span><button onclick="board_user()">작성 게시글</button></span>
			 <span><button style="color: skyblue">작성 댓글</button></span> 
			 <span><button onclick="report_log()">신고 내역</button></span>
			 <p><span style="font-weight: bold;">유저 ID: </span><span id="top_userId" ></span></p>
			 <table class="table table-hover">
					<thead>
						<tr>
							<td>댓글번호</td>
							<td>게시글번호</td>
							<td>댓글 내용</td>
							<td>작성날짜</td>
							<td>수정날짜</td>
							<td>규제 여부</td>
						</tr>
					</thead>
					<tbody id="list">
					</tbody>
			 </table>
			 <div id="pagint">
				<div class="container">
					<nav aria-label="Page navigation" style="text-align: center;">
					<ul class="pagination" id="pagination"></ul>
					</nav>
				</div>
			</div>
			 <div class="search">
				<select id="comment_user" name="status_user" class="selectpicker">
					<option value="1">게시글번호</option>
					<option value="2">댓글 내용</option>
					<option value="3">댓글번호</option>
				</select> 
				<input type="text" name="search" id="search"/>
				<input type="button" onclick='search_user_comment(page2)' value="검색" class="btn btn-primary" />
				<input type="button" value="취소" class="btn btn-secondary" onclick="cancel()" />
			</div>
	</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<script>
var detail=window.location.search.split('?detail=')[1];
var page=1;
$("#top_userId").text(detail);
function report_log(){
	var url1=window.location.search;
	var url=location.href="user_report_log"+url1;
}

function cancel(){
	var url=window.location.search;
	location.href="comment_user"+url;
}




function board_user(){
	var url1=window.location.search;
	var url=location.href="board_user"+url1;
}

function profile(){
	var url1=window.location.search;
	var url=location.href="detail_user"+url1;
}

AjaxCall(page)

function AjaxCall(page){
	$.ajax({
		type:"get"
		,url:"comment_user_ajax"
		,dataType:"JSON"
		,data:{"detail":detail,"page":page}
		,success:function(data){
			listCall(data.list);
			$("#pagination").twbsPagination({
				startPage : 1 // 시작 페이지
				,totalPages : data.total // 총 페이지 수
				,visiblePages : 4 // 기본으로 보여줄 페이지 수
				,onPageClick : function(e, page) { // 클릭했을때 실행 내용
					AjaxCall(page);
				}
			});	
		}
		,error:function(e){
		}
	});
	
}

function listCall(list){
	var content="";
	for (i = 0; i < list.length; i++) {
		content += "<tr>";
		content += "<td>" + list[i].commentId+ "</td>";
		content += "<td id='id'>" + list[i].postId+ "</td>";
		content += "<td><a href='postDetail?postId="+list[i].postId+"' target='_blank'>" + list[i].comContent + "</td>";
		
// 		var date=new Date(list[i].regDate);
		var timestamp  = Number(new Date());
		var date = new Date(timestamp);
		content += "<td>" + date.toLocaleDateString("ko-KR")+" "+date.toLocaleTimeString("en-US",{hour12:false}) + "</td>";
		
		var updateDate=new Date(list[i].updateDate);
// 		content += "<td>" + updateDate.toLocaleDateString("ko-KR")+" "+updateDate.toLocaleTimeString("en-US",{hour12:false}) + "</td>";
		if(list[i].updateDate ){
			content += "<td>" + updateDate.toLocaleDateString("ko-KR")+" "+updateDate.toLocaleTimeString("en-US",{hour12:false}) + "</td>";
		}else{
			content += "<td>" + "-" + "</td>";
		}
		content += "<td>" + list[i].blind + "</td>";
		content += "</tr>";
	}
	$("#list").empty();
	$("#list").append(content);
}

var flag=true;
var pageflag=true;
var page2=1;
var status_change=new Array();
function search_user_comment(page2){
	status_change.push($("#comment_user").val());
	if(flag){
	var user=$("#comment_user").val();
	var search=$("#search").val();
	if(search == ""){
		return AjaxCall(page);
	}
	
	$.ajax({
		type:"post"
		,url:"comment_user_search"
		,dataType:"JSON"
		,data:{"user":user,"search":search,"detail":detail,"page":page2}
		,success:function(data){
			listCall(data.list);
			if(pageflag == true && $('.pagination').data("twbs-pagination")
					|| status_change.at(-2) != $("#comment_user").val()){
                $('.pagination').twbsPagination('destroy');
                pageflag=false;
            }
			$("#pagination").twbsPagination({
				startPage : 1 // 시작 페이지
				,totalPages : data.total // 총 페이지 수
				,visiblePages : 4 // 기본으로 보여줄 페이지 수
				,onPageClick : function(e, page) { // 클릭했을때 실행 내용
					search_user_comment(page);
				}
			});
		}
		,error:function(e){
		},complete:function(){
			flag=true;
		}
	});
	}
}
	
</script>
</html>