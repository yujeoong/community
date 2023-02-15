<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<link rel="stylesheet" href="resources/css/header.css">
<link rel="stylesheet" href="resources/css/homeMain.css">



<style>
</style>
</head>
<p></p>
<body>
<%@ include file="header.jsp" %>


<br>



<div class="container">
  <h2>오늘의 투표</h2>
  <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="false">

    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
      <li data-target="#myCarousel" data-slide-to="4"></li>
      <li data-target="#myCarousel" data-slide-to="5"></li>
      <li data-target="#myCarousel" data-slide-to="6"></li>
      <li data-target="#myCarousel" data-slide-to="7"></li>
      <li data-target="#myCarousel" data-slide-to="8"></li>
      <li data-target="#myCarousel" data-slide-to="9"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" id="pollList">

    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>



	<div id="mainPost">
    <div id="maPo1">
    <p id="poSub">Today's Hot Post</p> <br>
        <table>
     		<c:forEach items="${list_fa }" var="list_fa">
				<tr>
					&nbsp;&nbsp;<td><a href="postDetail?postId=${list_fa.postId}"> &nbsp;&nbsp;${list_fa.subject}</a></td>	
				</tr>
			</c:forEach>
        </table>
    </div>

    <div id="maPo2">
    <p id="poSub">This Week's Auction</p> <br>
    <table>
    	    <c:forEach items="${list_po}" var="list_po">
    	    	<tr>
    	    		<td><a href="auction_detail?postId=${list_po.postId}">&nbsp;&nbsp;${list_po.subject}</a></td>
    	    	</tr>
				<tr>
					<td>
						<a href="auction_detail?postId=${list_po.postId}">
							<c:if test="${list_po.newFileName ne null}">		       
<!-- 							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
							<img style="height:250px" src="/photo/${list_po.newFileName}">
							</c:if>
						</a>
					</td>
				</tr>
		</c:forEach>

    
    </table>
    </div>

    <div id="maPo3">
        <p id="poSub">Notice</p><br>     
        <table>
           	<c:forEach items="${list_in}" var="list_in">
				<tr>
					&nbsp;&nbsp;<td><a href="postDetail?postId=${list_in.postId}"> &nbsp;&nbsp;${list_in.subject}</a></td>				
				</tr>
	
			</c:forEach>
        

        </table>
    </div>
</div>





</body>
<script>
//pollCall();
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

var content='';
var pIdList = [];
var loginId = "${sessionScope.sessionId}";
if(loginId == null || loginId =="") {
	loginId = "noLogin";}

for(var i=0;i<10;i++){
	pollCall(i);
}



function pollCall(pollNum){
	$.ajax({
		type:'GET',
		url:'pollCall',
		async : false,
		data:{pollNum:pollNum, loginId:loginId},
		dataType:'JSON',
		success:function(data){

			drawPoll(pollNum, data.pollList, data.pollCount, data.selected);
		},
		error:function(e){
			console.log(e);
		}
 	});
}

function drawPoll(pollNum, pollList, pollCount, selected){
	let postId = pollList[0].postId;
	pIdList.push(postId);
	let selList=[];
	endDate = new Date(pollList[0].endDate);
	
	if(pollNum == 0){
		content += '<div class="item active">';
	}else{
		content += '<div class="item">';		
	}
	content += '<div>';
// 	content += '<h3>'+postId+'</h3>';
	content += '<a href="postDetail?postId='+postId+'">'+pollList[0].subject+'</a>';
	content += '<hr>';
	if(selected != null || endDate < new Date()){
		content += '<div id="container'+postId+'" height: 400px; margin: 0"></div>';

		for(var i=0; i<pollList.length; i++){
			if(pollList[i].pollId == selected){
			selList.push("[V]"+pollList[i].selection);
// 			content += '<div>선택지 없앨예정:'+pollList[i].selection+'selected/ count:'+pollCount[i]+'</div><br>';
			}else{
			selList.push(pollList[i].selection);
// 			content += '<div>선택지 없앨예정:'+pollList[i].selection+' /count:'+pollCount[i]+'</div><br>';
			}
		}
	}else{
		for(var i=0; i<pollList.length; i++){
// 			content += '<a href="doPoll?pollId='+pollList[i].pollId+'">선택:'+pollList[i].selection+'</a><br>';
			content += '<button class="selection" id="'+pollList[i].pollId+'">선택:'+pollList[i].selection+'</button><br>';
		}
	}
	content += '<hr>';
	content += '<p>투표마감일: '+endDate+'</p>';
	content += '<p id="endCount'+postId+'">hi</p>';
	content += '<div style="height: 70px;"></div>'
	content += '</div>';
	content += '</div>';
	$('#pollList').empty();
	$('#pollList').append(content);
	countDown(endDate,postId);
	window['selList'+postId] =selList;
	window['pollCount'+postId]=pollCount;
}

$(document).ready(function(){
	$(document).on("click", "button[class='selection']", function(){
    	$.ajax({
    		type:'GET',
    		url:'doPoll2',
    		async : false,
    		data:{pollId:this.id},
    		dataType:'JSON',
    		success:function(data){
				alert(data.msg);
				
// 				투표완료 후 다시 불러오기+highchart
				content='';
				pIdList = [];
				for(var i=0;i<10;i++){
					pollCall(i);
				}
				pIdList.forEach(function(postId) {
					if(window['selList'+postId] != ""){
						highchart(postId, window['selList'+postId], window['pollCount'+postId]);
					}
				});
    		},
    		error:function(e){
    			console.log(e);
    		}
     	});
	});
	
	console.log("idList: "+pIdList);
	console.log("Highchart 부르기 직전");
	
	pIdList.forEach(function(postId) {
		if(window['selList'+postId] != ""){
			highchart(postId, window['selList'+postId], window['pollCount'+postId]);
		}
	});
	
});

function highchart(postId, selList, pollCount){
	Highcharts.chart('container'+postId, {
	  chart: {
	    type: 'bar'
	  },
	  title: {
	    text: ''
	  },
// 	  subtitle: {
// 	    text: 'Source: <a ' +
// 	      'href="https://en.wikipedia.org/wiki/List_of_continents_and_continental_subregions_by_population"' +
// 	      'target="_blank">Wikipedia.org</a>'
// 	  },
	  xAxis: {
	    categories: selList
	  },
	  yAxis: {
	    min: 0,
	    tickInterval: 1
	  },
	  tooltip: {
	    valueSuffix: '명'
	  },
	  plotOptions: {
	    bar: {
	      dataLabels: {
	        enabled: true
	      }
	    }
	  },
	  series: [{
	    name: '투표',
	    data: pollCount
	  }]
	});
};

function countDown(endDate,postId){
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
	var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	var seconds = Math.floor((distance % (1000 * 60)) / 1000);
	
	// Display the result in the element with id="demo"
	document.getElementById("endCount"+postId).innerHTML = "남은시간"+ days + "d " + hours + "h "
	+ minutes + "m " + seconds + "s ";
	
	// If the count down is finished, write some text
	if (distance < 0) {
	  clearInterval(x);
	  document.getElementById("endCount"+postId).innerHTML = "투표 종료";
	}
	}, 1000);
}
</script>
</html>