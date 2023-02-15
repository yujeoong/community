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
<style></style>
</head>
<body class="row d-flex justify-content-center">
<h2>관리자 페이지</h2>
	<hr />
	<div class="col-2">
		<div class="d-grid gap-3">
			<div>
				<button class="p-2 border"
					onclick="location.href='AdminmyPage'">회원 관리</button>
			</div>
			<div>
				<button class="p-2 border">게시글 관리</button>
			</div>
			<div>
				<button class="p-2 border" style="color: skyblue">신고 관리</button>
			</div>
		</div>
		<div class="d-grid gap-3">
			<div>
				<button class="p-2 border">공지사항</button>
			</div>
			<div>
				<button class="p-2 border">건의사항</button>
			</div>
		</div>
	</div>
	<div class="col-4">	
		<h3>신고 처리</h3>
		<table class="table table-hover">
			<tbody>
				<tr>
					<th id="report_Id">신고 번호</th>
					<td>${reportId}</td>
				</tr>
				<tr>
					<th>관리자 아이디</th>
					<td>${adminId}</td>
				</tr>
				<tr>
					<th>처리 결과</th>
					<td>
						<select id="report_result" name="report_result" class="selectpicker">
							<option value="N">반려</option>
							<option value="B">블라인드</option>
						</select> 
					</td>
				</tr>
				<tr>
					<th>사유</th>
					<td class="textbox">
						<textarea class="form-control" style="width:300px;height:200px;resize: none;"></textarea>
						<div class="count"><span>0</span>/30</div>
					</td>
				</tr>
				
			</tbody>
		</table>	
		<input type="button" value="취소" class="btn btn-primary" onclick="history.back()"/>
		<input type="button" value="적용" class="btn btn-secondary" onclick="AjaxCall()" />
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<script>
var msg="${msg}";
console.log("하하"+"${flag}");
console.log("하하"+"${type}");
if("${flag}" != ""){
	if("${type}" == 1){
		$("#report_Id").text("게시글 번호");
	}else if("${type}" == 2){
		$("#report_Id").text("댓글 번호");
	}
}	
if(msg != ""){
	alert(msg);
	history.back();
}

var msg3="${alert2}";
if(msg3 != ""){
	var result2=alert(msg3+"\n신고 번호 : "+"${reportId}");
	history.back();
}

var msg2="${alert}"
if(msg2 != ""){
	var result=confirm(msg2);
	if(!result){
	history.back();
	}
}

var ExceptionMsg="${Exception}";
if(ExceptionMsg){
	alert("ExceptionMsg");
	history.back();
}




$(".textbox textarea").keyup(function(){
	  var content = $(this).val();
	  $('.textbox .count span').html(content.length);
	  if (content.length > 30){
	    alert("최대 30자까지 입력 가능합니다.");
	    $(this).val(content.substring(0, 30));
	    $('.textbox .count span').html(30);
	  }
});

function AjaxCall(){
params={};
var $reportId="${reportId}";
var $adminId="${adminId}";
var $report_result=$("#report_result").val();
var $textbox=$(".textbox textarea").val();
var type="${type}";
var flag="${flag}";
data:params.reportId=$reportId;
data:params.adminId=$adminId;
data:params.report_result=$report_result;
data:params.textbox=$textbox;
data:params.type=type;
data:params.flag=flag;

	$.ajax({
		data:"post"
		,url:"report_process"
		,data:params
		,dataType:"JSON"
		,success:function(data){
			if(data.row > 0){
				location.href="report_board";
			}
			
			if(data.success > 0){
				location.href="Admin_All_Board";
			}
		}
		,error:function(e){
		}
	});
}

</script>
</html>