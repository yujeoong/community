<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> 
<%@ include file="header.jsp" %>
<script src="resources/board/jquery.twbsPagination.js"></script>
<link rel = "stylesheet" href="./resources/board/board.css" type="text/css">
<style>

</style>
</head>
<body>
	
	<div class="container">	
	
		<div id="List" class="pull-left"> 
		<div id="ListHeader">건의사항</div>
	
		<select id="searchType" name="searchType">
				<option value="1">제목+내용</option>
				<option value="2">제목</option>
				<option value="3">내용</option>
				<option value="4">작성자</option>
			</select> &nbsp; <input type="text" name="search" id="search" placeholder="검색어를 입력하세요.">
				<input type="image" id="search_post" onclick="search_post(page2)" src="./resources/board/search_icon.png">
		</div>
		
		<table class="table table-striped">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>

			<tbody id="list">
			</tbody>

		</table>
		<%
			if (session.getAttribute("sessionId") != null) {
		%>
		<button class="btn btn-outline-primary pull-right" onclick="location.href='writeForm_g?categoryId=7'" id="btnWrite">글쓰기</button>
		<%
			}
		%>

		<nav aria-label="Page navigation" style="text-align: center">
			<ul class="pagination" id="pagination"></ul>
		</nav>
	</div>

</body>


<script>
	var showPage = 1;//현재 보여주고 있는 페이지를 1로 잡는다 
	var categoryId = 7;
	listCall(showPage);  //hoisting //listCall 실행 //matchList은 showpage에 의해 출력

	
	var flag=true;
	var pageflag=true;
	var page2=1;
	var status_change=new Array();
	//게시판 검색  
	
	function search_post(page2){
		status_change.push($("#searchType").val());
		if(flag){
			flage=false;
		var searchType=$("#searchType").val();
		var search=$("#search").val();
		
		if(search == ""){
			return listCall(page);
		}
		$.ajax({
			type:"POST",
			url:"search_post_others",
			dataType:"JSON",
			data:{"searchType":searchType, "search":search, "categoryId":categoryId, "page":page2},
			success:function(data){
				drawList(data.list);
				if(pageflag == true && $('.pagination').data("twbs-pagination")
						|| status_change.at(-2) != $("#searchType").val()){
                    $('.pagination').twbsPagination('destroy');
                    pageflag=false;
                }
				$("#pagination").twbsPagination({
					startPage : 1 // 시작 페이지
					,totalPages : data.total // 총 페이지 수
					,visiblePages : 4 // 기본으로 보여줄 페이지 수
					,onPageClick : function(e, page) { // 클릭했을때 실행 내용
						search_post(page);
					}
				});
			},error:function(e){
			},complete:function(){
				flag=true;
			}
		});
		}
	}
	
	function listCall(page) {	
		
		$.ajax({
			type : 'GET', //전송 방식
			url : 'listCall', //요청 보낼 서버
			data : {page : page, categoryId : categoryId},
			
			dataType : 'JSON', //데이터를 주고 받을 형태 
			success : function(data) { //성공했을 때 넣을 데이터
				console.log(data);
				drawList(data.list);
				


				//pagination 플러그인 적용 
				$('#pagination').twbsPagination({
					startPage : 1, //시작 페이지
					totalPages : data.total, // 총 페이지 수 
					visiblePages : 5, //기본으로 보여줄 페이지 수 
					onPageClick : function(e, page) {//클릭했을 때 실행 내용 //e는 event
						console.log(e);
						listCall(page); //listCall을 호출해서 클릭한 page가 가도록 한다. -> 클릭할때 logger.info(list 요청!! +page) 페이지 수에 변화가 있다. 
					}
				});
			},
			error : function(e) { //에러 났을 때 넣을 데이터 
				console.log(e);
			}
		});
	}


	function drawList(list) { //데이터가 정상적으로 들어와있고 로그인이 되어있는 상태면 위의 drawList(data.list)를 호출한다.
		var content = ''; //for문이 돌때마다 한줄씩 생기기 위해 누적합으로 <tr>로 시작하고 </tr>로 끝낸다. 제이쿼리 시간에 배운거 응용
		//데이터가 정상적으로 들어와있는지 확인하기 위해 for문
		for (var i = 0; i < list.length; i++) {
			//console.log(list[i]);
			content += '<tr>';
			content += '<td style="text-align:center">' + list[i].postId + '</td>'; //list의 i번째에 있는 id 
			content += '<td><a href="postDetail?postId='+list[i].postId+'">' + list[i].subject +'</a></td>';
			content += '<td style="text-align:center">' + list[i].nickname + '</td>';

			var date = new Date(list[i].regDate); //reg_date를 date객체로 만든다. 
			content += '<td style="text-align:center">' + date.toLocaleDateString('ko-KR') + '</td>';

			content += '<td style="text-align:center">' + list[i].views + '</td>';
			content += '</tr>';
		}
		$('#list').empty(); //삭제 한번시키고 
		$('#list').append(content); //그 안의 내용을 덧붙이다. 
	}
	
	

	
	
</script>
</html>
















