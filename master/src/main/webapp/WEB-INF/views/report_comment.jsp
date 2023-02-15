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
<style></style>
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
					onclick="location.href='AdminmyPage'">회원 관리</button>
			</div>
			<div>
				<button class="p-2 border" onclick="location.href='Admin_All_Board'">게시글 관리</button>
			</div>
			<div>
				<button class="p-2 border" style="color: skyblue">신고 관리</button>
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
		 <span ><button onclick="location.href='report_board'">게시글 신고</button></span>
		 <span><button style="color: skyblue">댓글 신고</button></span>
		 <table class="table table-hover">
					<thead>
						<tr>
							<td>신고 번호</td>
							<td>신고 내용</td>
							<td>댓글 번호</td>
							<td>신고자</td>
							<td>신고 날짜</td>
							<td>처리 상태</td>
						</tr>
					</thead>
					<tbody id="list">
					</tbody>
			 </table>
			 <input type="button" id="report_process" style="float: right;" class="btn btn-primary" value="신고 처리" onclick="report_process()">
			 <div id="pagint">
				<div class="container">
					<nav aria-label="Page navigation" style="text-align: center;">
					<ul class="pagination" id="pagination"></ul>
					</nav>
				</div>
			</div>
			 <div class="search">
				<select id="board_user" name="status_user" class="selectpicker">
					<option value="reportId">신고 번호</option>
					<option value="reason">내용</option>
					<option value="userId">신고자</option>
				</select> 
				<input type="text" name="search" id="search"/>
				<input type="button" onclick='search_user_report(page2)' value="검색" class="btn btn-primary" />
				<input type="button" value="취소" class="btn btn-secondary" onclick="location.href='report_comment'" />
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
		location.href="report_comment";
	}else{			
		location.href="Admin_report_process?reportId="+radio+"&&type="+"2";
	}
});


function AjaxCall(page){
	$.ajax({
		type:"post"
		,url:"report_comment_ajax"
		,dataType:"JSON"
		,data:{"page":page}
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
	for(i=0;i<list.length;i++){
			content+="<tr>";
			content+="<td><input type='radio' name='radio' value='"+list[i].reportId+"'>"+list[i].reportId+"</td>";
			content+="<td>"+list[i].reason+"</td>";
			content+="<td>"+list[i].id+"</td>";
			content+="<td>"+list[i].userId+"</td>";
			var date=new Date(list[i].regDate);
			content+="<td>"+date.toLocaleDateString("ko-KR")+" "+date.toLocaleTimeString("en-US",{hour12:false})+"</td>";
			content+="<td>"+list[i].status+"</td>";
			content+="</tr>";
	}
	$("#list").empty();
	$("#list").append(content);
}


var flag=true;
var pageflag=true;
var page2=1;
var status_change=new Array();
function search_user_report(page2){
	status_change.push($("#board_user").val());
	var user=$("#board_user").val();
	var search=$("#search").val();
	if(search == ""){
		return AjaxCall(page);
	}
	$.ajax({
		type:"post"
		,url:"search_comment_report"
		,dataType:"JSON"
		,data:{"user":user,"search":search,"page":page}
		,success:function(data){
			listCall(data.list);
			if(pageflag == true && $('.pagination').data("twbs-pagination")
					|| status_change.at(-2) != $("#board_user").val()){
                $('.pagination').twbsPagination('destroy');
                pageflag=false;
            }
			$("#pagination").twbsPagination({
				startPage : 1 // 시작 페이지
				,totalPages : data.total // 총 페이지 수
				,visiblePages : 4 // 기본으로 보여줄 페이지 수
				,onPageClick : function(e, page) { // 클릭했을때 실행 내용
					search_user_report(page);
				}
			});
		}
		,error:function(e){
		},complete:function(){
			flag=true;
		}
		
	});
}












</script>
</html>