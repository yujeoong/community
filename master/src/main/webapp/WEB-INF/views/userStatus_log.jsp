<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

	<div class="col-6">
			<c:forEach items="${list}" var="list" varStatus="lists">
					<p>회원 ID : ${list.userId}</p>
					<p>현재 상태 :
					<c:choose>
							<c:when test="${list.status eq 1}">정상</c:when>
							<c:when test="${list.status eq 2}">일시정지</c:when>
							<c:when test="${list.status eq 3}">탈퇴</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
					</p>
					<p>규제 받은 횟수 : ${list.sanctionNo}</p>
		<table class="table table-hover">
				<thead>
					<tr>
						<th>규제 횟수</th>
						<th>현재 계정 상태</th>
						<th>계정 상태 변경일</th>
				</thead>
				<tbody>
					<tr>
						<td> 
							0
						</td>
						<td>
							<c:choose>
							<c:when test="${list.status eq 1}">정상</c:when>
							<c:when test="${list.status eq 2}">일시정지</c:when>
							<c:when test="${list.status eq 3}">탈퇴</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
						</td>
						<td>
							${list.regDate}
						</td>
					</tr>
					<tr>
						<c:if test="${ 25 <= list.sanctionNo}">
						<td> 
								<c:if test="${list.sanctionNo <= 50}">
									25
								</c:if>
						</td>
						<td>
							<c:choose>
							<c:when test="${list.status eq 1}">정상</c:when>
							<c:when test="${list.status eq 2}">일시정지</c:when>
							<c:when test="${list.status eq 3}">탈퇴</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
						</td>
						<td>
							${list.updateDate}
						</td>
						</c:if>
					</tr>
				</tbody>
		</table>
				<input type="button" value="취소" class="btn btn-secondary"
				 onclick="location.href='detail_user?detail=${list.userId}'" />
		</c:forEach>

	</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<script></script>
</html>