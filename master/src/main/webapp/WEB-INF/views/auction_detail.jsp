<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="header.jsp"%>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<style>
#ListHeader{ 
    font-weight: bold;  
    font-size: 2.3em; 
    line-height: 1.0em; 
   padding : 20px 0 20px; 
   color : rgb(0, 74, 173); 
    margin-top: 20px; 
 } 

</style>
</head>
<body>
<div style="width:70%; margin:auto; text-align: center;">
				<div style="display:inline-block; margin-right: 70px;position: relative;
    			bottom: 100px; right: 100px;" >
				<h1 id="ListHeader" style="text-align: left;"> 경매 </h1>
				<c:if test="${info.newFileName ne null}">
<!-- 				        <p>이미지</p> -->
						<img src="/photo/${info.newFileName}" style="width: 200px;height: 200px;"><br/>
				</c:if>
				</div>
<!-- 				<hr> -->
				<div style="display:inline-block; margin:50px 0px 30px 0px; text-align: left;">
				<p>아이템 이름: ${info.subject}</p>
				
				<p><span>남은 시간 : </span><span id="demo"></span></p>
				
				<p>종료 일시: ${info.endDate} </p>
				<p>현재 입찰 최고가: ${bidlog[0].bidPoint} point</p><a onclick="openChild()">[입찰기록 ${bidlog.size()-1}]</a>
				<div class="input-group mb-3">
				<form action="bidding" method="post">
				<input type="number" 
				style="width: 70px; margin-right: 10px;" class="form-control" min='0' step='1' name="bidPoint" placeholder="point" value='0'>
				<input type="submit" id="bidSubmit" class="btn btn-primary" value="입찰">
				<input type="hidden" name="postId" value="${info.postId}">
				</form>
				</div>
				<p>${bidlog[0].bidPoint}포인트 이상 입력하세요.</p>
				<p>시작가: ${info.startingPoint}</p>
				<p>입찰 단위는 1포인트 입니다. </p>
				<p>입찰 후 철회는 불가능합니다.</p>
				</div>
<hr>
	<div style="width: 800px; text-align: left; position: relative;left: 200px; ">
		<h3>상세정보</h3>
		<c:if test="${sessionScope.sessionLevel eq 2}">
			<a style="float: right;" id="report" href="updateForm?categoryId=5&postId=${info.postId}">수정</a>
		</c:if>
		<p>${info.content}</p>
		<p>조회수: ${info.views}</p>
		<p>작성일: ${info.regDate}</p>
		<p>작성자: ${info.userId}</p>
	</div>
</div>

</body>

<script>

//var openWin;

function openChild()
{
	window.open("bidLog?postId=${info.postId}", "bidLogPop","width=570, height=350");
//    window.name = "parentForm";
//    openWin = window.open("bidLog",
//            "childForm", "width=570, height=350, resizable = no, scrollbars = no");    
}




// 카운트다운
var endDate="${info.endDate}";
//Set the date we're counting down to
var countDownDate = new Date(endDate).getTime();

// Update the count down every 1 second
var x = setInterval(function() {

  // Get today's date and time
  var now = new Date().getTime();

  // Find the distance between now and the count down date
  var distance = countDownDate - now;

  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

  // Display the result in the element with id="demo"
  document.getElementById("demo").innerHTML = days + "d " + hours + "h "
  + minutes + "m " + seconds + "s ";

  // If the count down is finished, write some text
  if (distance < 0) {
    clearInterval(x);
    document.getElementById("demo").innerHTML = "경매가 종료되었습니다.";
    document.getElementById("bidSubmit").disabled = true;
    
  }
}, 1000);
</script>
</html>