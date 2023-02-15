<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<script src="resources/js/jquery.twbsPagination.js"></script>
<link rel = "stylesheet" href="./resources/css/postDetail.css" type="text/css">

<style></style>
</head>

<body>
	<div class="body">
	<p id="ListHeader">${post.categoryName}</p>
	<div id="subject">${post.subject}</div>
	<div id="postInfo">작성자: ${post.nickname} &nbsp; 작성날짜: ${post.regDate} &nbsp; 조회수: ${post.views}</div>
	<div id="poll"></div>
	<hr>
	<c:if test="${sessionScope.sessionId eq post.userId}">
		<a class="detailA" id="delete" href="delete?postId=${post.postId}">삭제</a>
		<a class="detailA" id="update" href="updateForm?postId=${post.postId}&categoryId=${post.categoryId}">수정</a>	
	</c:if>
	<c:if test="${sessionScope.sessionId ne null && (post.categoryId eq 3 || post.categoryId eq 4)}">
		<a class="detailA" id="report" href="reportForm?reportType=1&id=${post.postId}">신고</a>
	</c:if>
	<c:if test="${sessionScope.sessionLevel eq 2 && post.categoryId eq 1}">
		<a class="detailA" id="matchResult" onclick="openChild()">승부 결과 입력</a>
	</c:if>
	<br>
	<div id="content">${post.content}</div>

	<c:if test="${post.newFileName ne null}">
		<img src="/photo/${post.newFileName}"><br/>
	</c:if>
	<br>
	
	
	<div class="outer-div">
		<br> <span><strong>댓글</strong></span><span id="cCnt"></span> <br><hr>
		<div class="inner-div">
			<!-- 댓글 목록 -->
			<div class="CommentList">
					<!-- 댓글 리스트가 들어가는 공간  -->
			</div>

			<div>
				<div id="paging">
					<div class="container">
						<nav aria-label="Page navigation" style="text-align: center">
							<ul class="pagination" id="pagination"></ul>
						</nav>
					</div>
				</div>
			</div>

			<!-- 로그인 시에만 입력 창 띄움 -->
			<c:choose>
				<c:when test="${not empty sessionScope.sessionId }">
					<div>
						<input type="text" id="comment" placeholder="댓글을 입력하세요.">
						<button id="comtSubmit">등록</button>
					</div>
				</c:when>
				<c:otherwise>
					<input type="text" placeholder="로그인이 필요한 서비스 입니다.">
					<button>등록</button>
				</c:otherwise>
			</c:choose>

		</div>
	</div>

	</div>
</body>
<script>

var msg = "${msg}";
if(msg != ""){
	alert(msg);
}


	var content = '';
	var selPoll = '';
	var loginId = "${sessionScope.sessionId}";
	if (loginId == null || loginId == "") {
		loginId = "noLogin";
	}

	var message = "${msg}";
	console.log(message);

	if ("${post.categoryId}" == 1 || "${post.categoryId}" == 2
			|| "${post.categoryId}" == 3) {
		pollDetailCall("${post.postId}");
	}

	function pollDetailCall(postId) {
		$.ajax({
			type : 'GET',
			url : 'pollDetailCall',
			data : {
				postId : postId
			},
			dataType : 'JSON',
			success : function(data) {
				drawPoll(data.pollList, data.pollCount, data.selected);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

	function drawPoll(pollList, pollCount, selected) {
		content = '';
		var selList = [];
		content += '<div id="drawPoll">';
		endDate = new Date(pollList[0].endDate);

		content += '<hr>';
		if (selected != null || endDate < new Date()) {
			content += '<div id="container" style="width: 100%; height: 400px; margin: 0"></div>';

			for (var i = 0; i < pollList.length; i++) {
				if (pollList[i].pollId == selected) {
					selList.push("[V]" + pollList[i].selection);
// 					content += '<div>선택지:' + pollList[i].selection
// 							+ 'selected/ count:' + pollCount[i] + '</div><br>';
				} else {
					selList.push(pollList[i].selection);
// 					content += '<div>선택지:' + pollList[i].selection + ' /count:'
// 							+ pollCount[i] + '</div><br>';
				}
			}
		} else {
			for (var i = 0; i < pollList.length; i++) {
				// 			content += '<a href="doPoll?pollId='+pollList[i].pollId+'">선택:'+pollList[i].selection+'</a><br>';
				content += '<button class="selection" id="'+pollList[i].pollId+'">선택:'
						+ pollList[i].selection + '</button><br>';
			}
		}
		content += '<br>';
		content += '<div id="countdown">';		
		content += '<p>투표마감일: ' + endDate + '</p>';
		content += '<p id="endCount"></p>';
		content += '</div>';		
		content += '</div>';
		$('#poll').empty();
		$('#poll').append(content);
		countDown(endDate);
		if (selected != null || endDate < new Date()) {
			highchart(selList, pollCount, selected);
		}
	}

	$(document).ready(function() {
		$(document).on("click", "button[class='selection']", function() {
			$.ajax({
				type : 'GET',
				url : 'doPoll2',
				async : false,
				data : {
					pollId : this.id
				},
				dataType : 'JSON',
				success : function(data) {
					console.log(data.msg);
					pollDetailCall("${post.postId}");
				},
				error : function(e) {
					console.log(e);
				}
			});
		});
	});

	function highchart(selList, pollCount, selected) {
		Highcharts.chart('container', {
			chart : {
				type : 'bar'
			},
			title : {
				text : ''
			},
			// 	  subtitle: {
			// 	    text: 'Source: <a ' +
// 	      'href="https://en.wikipedia.org/wiki/List_of_continents_and_continental_subregions_by_population"' +
// 	      'target="_blank">Wikipedia.org</a>'
			// 	  },
			xAxis : {
				categories : selList
			},
			yAxis : {
				min : 0,
				tickInterval : 1
			},
			tooltip : {
				valueSuffix : '명'
			},
			plotOptions : {
				bar : {
					dataLabels : {
						enabled : true
					}
				}
			},
			series : [ {
				name : '투표',
				data : pollCount
			} ]
		});
	};

	function countDown(endDate) {
		// var endDate="${info.endDate}";
		//Set the date we're counting down to
		var countDownDate = new Date(endDate).getTime();

		//Update the count down every 1 second
		var x = setInterval(function() {

			// Get today's date and time
			var now = new Date().getTime();

			// Find the distance between now and the count down date
			var distance = countDownDate - now;

			// Time calculations for days, hours, minutes and seconds
			var days = Math.floor(distance / (1000 * 60 * 60 * 24));
			var hours = Math.floor((distance % (1000 * 60 * 60 * 24))
					/ (1000 * 60 * 60));
			var minutes = Math.floor((distance % (1000 * 60 * 60))
					/ (1000 * 60));
			var seconds = Math.floor((distance % (1000 * 60)) / 1000);

			// Display the result in the element with id="demo"
			document.getElementById("endCount").innerHTML = "남은시간" + days
					+ "d " + hours + "h " + minutes + "m " + seconds + "s ";

			// If the count down is finished, write some text
			if (distance < 0) {
				clearInterval(x);
				document.getElementById("endCount").innerHTML = "투표가 종료되었습니다.";
			}
		}, 1000);
	}

	function openChild() {
		window.open("matchResultForm?postId=${post.postId}", "matchResultPop",
				"width=570, height=350");
	}
	
	var sessionId='${sessionScope.sessionId}';
	var postId = ${post.postId};
	/* 댓글 쓰기 */	
		$("#comtSubmit").click(function(){
			var comment = document.getElementById("comment").value;
			if(comment=='null'||comment==''){
				alert('내용을 입력하세요');
			}else{
				$.ajax({
					type:'POST',
					url:'comtSubmit',
					data:{comment:comment, postId:postId},
					datatype:'JSON',
					success:function(data){
						if(data.success>0){
							document.getElementById("comment").value="";
							listCall(postId, page);
						}else{
							alert("댓글 등록에 실패하였습니다.");
						}
					},
					error:function(e){
					}
				});
			}
		})	
		
	var page = 1;
	listCall(postId, page);

	function listCall(postId, page) {
			$('#list').empty();
			$.ajax({
				type:'POST',
				url:'commentListCall',
				data:{postId:postId, page:page},
				datatype:'JSON',
				success:function(data){
					console.log(data.list);
					drawList(data.list);
					console.log(data.total);
					/* 페이징 처리 */
					$('#pagination').twbsPagination({
						startPage:1, //시작페이지
						totalPages: data.total, //총 페이지 수
						visiblePages: 5, //기본으로 보여줄 페이지 수
						onPageClick:function(e, page){ // 클릭했을 때 실행 내용
						listCall(postId, page);
					}
					
					});
				},
				error:function(e){
				}      
			});
	}
		
	function drawList(list){
		var content='';
		for(var i=0; i<list.length; i++){
			console.log(list);
			var date = new Date(list[i].regDate);
			content += "<div id='reOuterDiv'>";
			content += "<div class='rereply-content'>";
			content += 		"<br>";
			content += 		"<span class='reNum'>";
			var blind = list[i].blind;
 			if(blind =="B"){
 			content += 			'규제된 댓글입니다';						
 			}else{
 			content += 			list[i].nickname;	
 			content += 		"</span>";
 			content += 		"<br>";
 			content += 		"<br>";
 			content += 		"<p class='comment'>";
			content += 			list[i].comContent;
			content += 		"<input class='comId' type='hidden' value='"+list[i].commentId+"'>";
			content += 		"</p>"
	        content+=			'<input type="hidden" id="comtModifyInput">';
			content += 		"<br>";
            content += 		"<span>";
// 			content += date.toLocaleDateString('ko-KR');
			content += date.toLocaleDateString("ko-KR")+" "+date.toLocaleTimeString("en-US",{hour12:false})
			content += 		"</span>";
		        if(sessionId==list[i].userId){
		        content+=			'<button onclick="comtModify(this)">'+'수정'+'</button>';
		        content += 			"&emsp;";
		        }
		        if(sessionId==list[i].userId){
			    content+=			'<button class="comDel" onclick="comDel('+list[i].commentId+')">'+'삭제'+'</button>';
		        }	
		        if(sessionId !=list[i].userId){
				    content += 		"<span>";
				    content+=          '<a id="report" href="reportForm?reportType=2&id='+list[i].commentId+'">신고</a>';
			    }
 			}
			content += 		"<br>";
			content += "</div>";  
			content += "</div>";  
		$(".CommentList").empty();
		$(".CommentList").append(content); //넣음
		    
	}
}

	
	function comtModify(modifyBtn){
		var comment = $(modifyBtn).closest("div").find("p.comment").text();
		console.log(comment);
		//$(comment).find("span").hide();
		//$(comment).find("input").prop("type","text");
		$(modifyBtn).html("저장");
		modifyBtn.setAttribute("onclick","modify(this)");
		$(modifyBtn).closest("div").find("button.comDel").html("취소");
		$(modifyBtn).closest("div").find("button.comDel").attr("onclick","comCancel()")	
		$(modifyBtn).closest("div").find("input#comtModifyInput").prop("type","text")
		$(modifyBtn).closest("div").find("input#comtModifyInput").attr("value",comment)
	}	
		
		function modify(modifyBtn){
			var comment = $(modifyBtn).closest("div").find("input#comtModifyInput").val();
			console.log(comment);
			var commentId = $(modifyBtn).closest("div").find("input.comId").val();
			if(comment=='null'||comment==''){
				alert('댓글을 입력해 주세요');
			}else{
				$.ajax({
					type:'POST',
					url:'comtUpdate',
					data:{
						comment : comment,
						commentId : commentId
					},
					datatype:'JSON',
					success:function(data){
						if(data.success>0){
							listCall(postId, page);
							alert("댓글이 수정되었습니다.");
						}else{
							alert("댓글 수정을 실패하였습니다.");				
						}
					},
					error:function(e){
						alert("ajax error");
					}
				});
			}
		}	

		function comDel(commentId){
			console.log(commentId);
			if(confirm("삭제 하시겠습니까?")){
				$.ajax({
					type:'POST',
					url:'comDelete',
					data:{commentId:commentId},
					datatype:'JSON',
					success:function(data){
						if(data.success>0){
							listCall(postId, page);
						}else{
							alert("댓글 삭제를 실패하였습니다.");				
						}
					},
					error:function(e){
						alert("ajax error");
					}
				});
			}
		}		
		function comCancel(){ //수정 취소
			listCall(postId, page);
		}
		

</script>
</html>