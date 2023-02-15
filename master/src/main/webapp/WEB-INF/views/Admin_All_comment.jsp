<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous" />
	<script src="resources/js/jquery.twbsPagination.js"></script>
<style>
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}	
</style>
</head>
<body class="container">  
<!-- d-flex justify-content-center -->
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
					onclick="location.href='AdminmyPage'">회원 관리</button>
			</div>
			<div>
				<button class="p-2 border" style="color: skyblue">게시글 관리</button>
			</div>
			<div>
				<button class="p-2 border" onclick="location.href='report_board'">신고 관리</button>
			</div>
		</div>
		<div class="d-grid gap-3" style="margin-top: 50px;">
			<div>
				<button class="p-2 border" onclick="location.href='noticeList'">공지사항</button>
			</div>
			<div>
				<button class="p-2 border" onclick="location.href='suggList'">건의사항</button>
			</div>
		</div>
	</div>
	<div class="col-7">
		 <span ><button onclick="location.href='Admin_All_Board'">게시글</button></span>
		 <span><button style="color: skyblue">댓글</button></span>
		 <table class="table table-hover">
					<thead>
						<tr>
							<th>댓글 번호</th>
							<th>게시글 번호</th>
							<th>댓글 내용</th>
							<th>작성자</th>
							<th>작성 날짜</th>
							<th>수정 날짜</th>
							<th>규제 여부</th>
						</tr>
					</thead>
					<tbody id="list">
					</tbody>
			 </table>
				 <input type="button" style="float: right;" class="btn btn-primary" value="신고 처리" id="report_process">
			 <div id="pagint">
				<div class="container">
					<nav aria-label="Page navigation" style="text-align: center;">
					<ul class="pagination" id="pagination"></ul>
					</nav>
				</div>
			</div>
			 <div class="search">
				<select id="all_search" name="all_search" class="selectpicker">
					<option value="1">댓글 번호</option>
					<option value="2">게시글 번호</option>
					<option value="3">내용</option>
					<option value="4">작성자</option>
				</select> 
				<input type="text" name="search" id="search"/>
				<input type="button" onclick='all_comment_search(page2)' value="검색" class="btn btn-primary" />
				<input type="button" value="취소" class="btn btn-secondary" onclick="location.href='Admin_All_comment'" />
			</div>
	</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<script>
var page=1;
AjaxCall(page);

$(document).on("click","#report_process",function(){
	var radio=$(":radio[name='radio']:checked").val();
	if(typeof radio == "undefined"){
		alert("체크 박스 선택 해주세요.");
		location.href="report_board";
	}else{			
		location.href="Admin_board_report?postId="+radio+"&&type="+"2";
	}
});

function AjaxCall(page){
	$.ajax({
		type:"post"
		,url:"Admin_all_comment_ajax"
		,data:{"page":page}
		,dataType:"JSON"
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
		content += "<td><input type='radio' name='radio' value='"+list[i].commentId+"'>" + list[i].commentId+ "</td>";
		content += "<td id='id'>" + list[i].postId+ "</td>";
		content += "<td><a href='postDetail?postId="+list[i].postId+"' target='_blank'>" + list[i].comContent + "</td>";
		content += "<td>" + list[i].userId + "</td>";
		var date=new Date(list[i].regDate);
		content += "<td>" + date.toLocaleDateString("ko-KR")+" "+date.toLocaleTimeString("en-US",{hour12:false}) + "</td>";
		var updateDate=new Date(list[i].updateDate);
		console.log(list[i].updateDate);
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
function all_comment_search(page2){
	status_change.push($("#all_search").val());
	if(flag){
	flag=false;
	var cate=$("#all_search").val();
	var search=$("#search").val();
	if(search == ""){
		return AjaxCall(page);
	}
	$.ajax({
		type:"post"
		,url:"all_comment_search"
		,dataType:"JSON"
		,data:{"cate":cate,"search":search,"page":page2}
		,success:function(data){
			listCall(data.list);
			if(pageflag == true && $('.pagination').data("twbs-pagination")
					|| status_change.at(-2) != $("#all_search").val()){
                $('.pagination').twbsPagination('destroy');
                pageflag=false;
            }
			$("#pagination").twbsPagination({
				startPage : 1 // 시작 페이지
				,totalPages : data.total // 총 페이지 수
				,visiblePages : 4 // 기본으로 보여줄 페이지 수
				,onPageClick : function(e, page) { // 클릭했을때 실행 내용
					all_comment_search(page);
				}
			});
			
		},error:function(e){
		},complete:function(){
			flag=true;
		}
		
	});
	}
}


</script>
</html>