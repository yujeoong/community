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
ul {
	list-style: none;
}

.first_ul li {
	margin-bottom: 30px;
}

.second_ul {
	margin-top: 100px;
}

.second_ul li {
	margin-bottom: 30px;
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous" />
<script src="resources/js/jquery.twbsPagination.js"></script>
</head>
<body>
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
					<button class="p-2 border" style="color: skyblue;"
						onclick="location.href='AdminmyPage'">회원 관리</button>
				</div>
				<div>
					<button class="p-2 border"
						onclick="location.href='Admin_All_Board'">게시글 관리</button>
				</div>
				<div>
					<button class="p-2 border" onclick="location.href='report_board'">신고
						관리</button>
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
			<table class="table table-hover">
				<thead>
					<tr>
						<th>No.</th>
						<th>ID</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>계정 상태</th>
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
				<select id="status_user" name="status_user" class="selectpicker">
					<option value="all">전체</option>
					<option value="2">일시정지</option>
					<option value="3">탈퇴</option>
					<option value="1">정상</option>
				</select> <select id="info_user" name="info_user">
					<option value="userId">ID</option>
					<option value="email">이메일</option>
					<option value="nickname">닉네임</option>
				</select> <input type="text" name="search" id="search" /> <input
					type="button" onclick='search_user(page2)' value="검색"
					class="btn btn-primary" /> <input type="button" value="취소"
					class="btn btn-secondary" onclick="location.href='AdminmyPage'" />
			</div>
		</div>
	
	<form action="detail_user" method="get">
		<input type="hidden" id="detail" name="detail"> <input
			id="submit" type="submit" style="display: none">
	</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<script>
	var page = 1;

	// 	var pageflag2=true
	listCall(page);
	////////////////AJAX 실행//////////////
	function listCall(page) {
		$.ajax({
			type : "POST",
			url : "adminlistCall",
			dataType : "JSON",
			data : {
				"page" : page
			},
			success : function(data) {
				listInput(data.list);
				console.log("AJAX 실행");
				$("#pagination").twbsPagination({
					startPage : 1 // 시작 펭지
					,
					totalPages : data.total // 총 페이지 수
					,
					visiblePages : 4 // 기본으로 보여줄 페이지 수
					,
					onPageClick : function(e, page) { // 클릭했을때 실행 내용
						listCall(page);
					}
				});
			},
			error : function(e) {
			}
		});
	}
	////////////////AJAX 실행//////////////

	////////////////list 출력//////////////
	function listInput(list) {
		var content = "";
		var status = "";
		for (i = 0; i < list.length; i++) {
			content += "<tr>";
			content += "<td>" + list[i].rowNum + "</td>";
			content += "<td id='id'>" + list[i].userId + "</td>";
			content += "<td>" + list[i].nickname + "</td>";
			content += "<td>" + list[i].email + "</td>";
			if (list[i].status == 1) {
				status = "정상";
			}
			if (list[i].status == 2) {
				status = "일시정지";
			}
			if (list[i].status == 3) {
				status = "탈퇴";
			}
			content += "<td>" + status + "</td>";
			content += "</tr>";
		}
		$("#list").empty();
		$("#list").append(content);
	} // listInput
	////////////////list 출력//////////////

	////////////////검색 및 검색 AJAX //////////////
	var flag = true;
	var status_change=new Array();
	var page2 = 1;
	var test = 0;
	var pageflag = true;
	function search_user(page2) {
		status_change.push($("#status_user").val());
		if (flag) {
			flag = false;
			var status = $("#status_user").val();
			var info = $("#info_user").val();
			var search = $("#search").val();
			if (status == "all" && search == "") {
				window.location.reload();
			}
			var chkArr = new Array();
			chkArr.push(status);
			chkArr.push(info);
			chkArr.push(search);
			$.ajax({
				type : "POST",
				url : "search_user_admin",
				dataType : "JSON",
				data : {
					"chkArr" : chkArr,
					"page" : page2
				},
				success : function(data) {
					listInput(data.list);
					if (pageflag == true && $('.pagination').data("twbs-pagination")
							|| status_change.at(-2) != $("#status_user").val()) {
						$('.pagination').twbsPagination('destroy');
						pageflag = false;
					}
					$("#pagination").twbsPagination({
						startPage : 1 // 시작 페이지
						,
						totalPages : data.total // 총 페이지 수
						,
						visiblePages : 4 // 기본으로 보여줄 페이지 수
						,
						initiateStartPageClick : false,
						onPageClick : function(e, page) { // 클릭했을때 실행 내용
							search_user(page);
						}
					});
				},
				error : function(e) {
				},
				complete : function() {
					flag = true;
				}
			});
		}
	}
	////////////////검색//////////////

	////////////////유저 상세보기//////////////
	$(document).on("click", "#id", function() {
		var id = $(this).text();
		$("#detail").val(id);
		$("#submit").trigger("click");
	});
	////////////////유저 상세보기//////////////
</script>
</html>