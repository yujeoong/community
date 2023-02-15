<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<style>
	table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
		background-color: mintcream;
	}
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
		<form action="adminSetPoint" method="post">
			<table>
			<thead>
				<tr>
					<th>아이디</th>
					<th>현재 포인트</th>
					<th>적립/차감</th>
					<th>변경 포인트</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${userId}</td>
					<td>${userPoint}</td>
					<td>
				        <select name="type" id="type" onchange="changeSelect()">
				          <option>선택</option>
				          <option value="add">적립</option>
				          <option value="use">차감</option>
				        </select>
					</td>
					<td>
						<input type="number" min='0' step='0.5' id="point" name="point" onchange="changePoint()">
					</td>
				</tr>				
			</tbody>
			</table>
		<input type="submit" id="submit" disabled='disabled' value="저장">
		<input type="hidden" name="userId" value="${userId}">
		</form>
   </div> 
</div>   

   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
      crossorigin="anonymous"></script>
</body>
<script>
function changeSelect(){
	if(($("#type").val()=="add"||$("#type").val()=="use") && $("#point").val() >0){
		$("#submit").prop('disabled', false);
	}else{
		$("#submit").prop('disabled', true);
	}
}

function changePoint(){
	if(($("#type").val()=="add"||$("#type").val()=="use") && $("#point").val() >0){
		$("#submit").prop('disabled', false);
	}else{
		$("#submit").prop('disabled', true);
	}
}

</script>
</html>