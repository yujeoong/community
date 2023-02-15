<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 상세페이지</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style></style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous" />
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
				<button class="p-2 border" style="color: skyblue;"
					onclick="location.href='AdminmyPage'">회원 관리</button>
			</div>
			<div>
				<button class="p-2 border" onclick="location.href='Admin_All_Board'">게시글 관리</button>
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
		<span ><button style="color: skyblue">프로필</button></span>
		 <span><button onclick="board_user()">작성 게시글</button></span>
		  <span><button onclick="comment_user()">작성 댓글</button></span> 
		  <span><button onclick="report_log()">신고 내역</button></span>
		  
		  <table class="table table-hover">
		  <c:forEach items="${list}" var="list" varStatus="status">
			<tbody>
				<tr>
					<th>ID</th>
					<td>${list.userId}</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>${list.nickname}</td>
					<th>닉네임 변경 날짜</th>
					<td>${list.nickUpdateDate}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${list.email}</td>
				</tr>
				<tr>
					<th>포인트</th>
					<td>${point}</td>
					<td><input type="button" value="적립/차감" class="btn btn-primary btn-sm"
					onclick="location.href='adminPoint?userId=${list.userId}'"/></td>
				</tr>
				<tr>
					<th>신고 횟수</th>
					<td>${report}</td>
				</tr>
				<tr>
					<th>제재 받은 횟수</th>
					<td>${list.sanctionNo}</td>
				</tr>
				<tr>
					<th>계정 상태</th>
					<td>
						<c:choose>
							<c:when test="${list.status eq 1}">정상</c:when>
							<c:when test="${list.status eq 2}">일시정지</c:when>
							<c:when test="${list.status eq 3}">탈퇴</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
					</td>
					<td><input type="button" value="계정 상태 로그" class="btn btn-secondary btn-sm" 
					onclick="location.href='userStatus_log?userId=${list.userId}'"/></td>
				</tr>
				<tr>
					<th>가입 날짜</th>
					<td>${list.regDate}</td>
				</tr>
				<tr>
					<th>이메일 인증</th>
					<td>${list.emailValid}</td>
				</tr>
				<tr>
					<th>회원 등급</th>
					<td>
						<c:choose>
								<c:when test="${list.userLevel eq 1}">최고관리자</c:when>
								<c:when test="${list.userLevel eq 2}">일반관리자</c:when>
								<c:when test="${list.userLevel eq 3}">일반회원</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
					</td>
				</tr>
				
			</tbody>
	</c:forEach>
		</table>
	</div>
	
	
	
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<script>
	function report_log(){
		var url1=window.location.search;
		console.log("완료");
		var url=location.href="user_report_log"+url1;
	}
	function board_user(){
		var url1=window.location.search;
		console.log("완료");
		var url=location.href="board_user"+url1;
	}
	
	function comment_user(){
		var url1=window.location.search;
		console.log("완료");
		var url=location.href="comment_user"+url1;
	}
	
	
</script>
</html>