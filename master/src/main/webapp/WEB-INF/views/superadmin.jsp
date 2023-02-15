<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최고 관리자 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous" />
<script src="resources/js/jquery.twbsPagination.js"></script>
<style>
.search {
	margin-top: 100px;
	text-align: center;
}

.button {
	margin-top: 50px;
	text-align: center;
}

.my-custom-scrollbar {
position: relative;
height: 600px;
overflow: auto;
}
.table-wrapper-scroll-y {
display: block;
}

</style>
</head>
<body class="row d-flex justify-content-center"">
	<form name="frm1" method="post">
		<div>
			<div class="d-flex justify-content-around"><a href="./">
				<img src="./resources/img/head_logo.png" alt=""
					style="width: 100px;" />
					</a>
				<div class="d-flex align-items-center">
					<span style="margin-right: 10px;">최고 관리자(${sessionId})님</span>
					<button class="btn-secondary" onclick="btn_click('logout')">로그아웃</button>
				</div>
			</div>
		</div>
		<hr />
		<div class="table-wrapper-scroll-y my-custom-scrollbar">
		<table class="table table-bordered table-hover" style="width: 70%; margin : 0 auto;">
			<thead>
				<tr class="table-secondary">
					<th scope="col">ID</th>
					<th scope="col">이메일</th>
					<th scope="col">닉네임</th>
					<th scope="col">계정 상태</th>
					<th scope="col">회원등급</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="list" varStatus="lists">
					<tr>
						<c:if test="${list.userLevel eq 1}">
							<td style="color: orange;"><input name="userId"
								type="hidden" value="${list.userId}"> ${list.userId}</td>
						</c:if>
						<c:if test="${list.userLevel eq 2}">
							<td style="color: orange;"><input name="userId"
								type="hidden" value="${list.userId}"> ${list.userId}</td>
						</c:if>
						<c:if test="${list.userLevel eq 3}">
							<td><input name="userId" type="hidden"
								value="${list.userId}"> ${list.userId}</td>
						</c:if>
						<td>${list.email}</td>
						<td>${list.nickname}</td>
						<td><c:choose>
								<c:when test="${list.status eq 1}">정상</c:when>
								<c:when test="${list.status eq 2}">일시정지</c:when>
								<c:when test="${list.status eq 3}">탈퇴</c:when>
								<c:otherwise></c:otherwise>
							</c:choose></td>
						<td><c:choose>
								<c:when test="${list.userLevel eq 1}">
									<input type="hidden" name="grade" value="최고관리자">최고관리자
						</c:when>
								<c:when test="${list.userLevel eq 2}">
									<select name="grade" id="se1">
										<option value="user_admin" selected="selected">일반관리자</option>
										<option value="user_member">일반회원</option>
									</select>
								</c:when>
								<c:when test="${list.userLevel eq 3}">
									<select name="grade" id="se2">
										<option value="user_admin">일반관리자</option>
										<option value="user_member" selected="selected">일반회원</option>
									</select>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		<div class="search">
			<select name="status_user" id="" class="selectpicker">
				<option value="all">전체</option>
				<option value="2">일시정지</option>
				<option value="3">탈퇴</option>
				<option value="1">정상</option>
			</select> <select name="info_user" id="" class="selectpicker">
				<option value="userId">ID</option>
				<option value="email">이메일</option>
				<option value="nickname">닉네임</option>
			</select> <input type="text" name="search" /> <input type="submit" value="검색"
				class="btn btn-primary" onclick="btn_click('search')" /> <input
				type="button" value="취소" class="btn btn-secondary"
				onclick="location.href='superadmin'" />
		</div>
		<div class="button">
			<input type="button" value="취소" class="btn btn-secondary"
				onclick="location.href='superadmin'" />
			<!-- 			<input name="status_change" type="text" id="status_change"> -->
			<input type="submit" value="저장" class="btn btn-primary"
				onclick="btn_click('change')" />
		</div>
	</form>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<script>
	function btn_click(str) {
		if (str == 'change')  {
			frm1.action = "change_status";
		} else if (str == 'search') {
			frm1.action = "search_user";
		} else if (str == 'logout'){
			frm1.action = "logout";
		}
	}
</script>
</html>