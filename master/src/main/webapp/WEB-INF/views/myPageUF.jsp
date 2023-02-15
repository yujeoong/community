<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/myPage.css">
<style>

</style>
</head>
<body>
<%@ include file="header.jsp" %>
<h1 style="padding:10px 30px;"><span class= m1 style="margin-left: 10px 0px;">MY PAGE</span></h1>
<hr size="4" color="black">
<div class=menu1>
	<div class=menu style="margin-top: 20px;"><span><a href="myPage">내 회원 정보</a></span></div><br>
	<div class=menu><span class=a><a href="myPost">내가 쓴 글</a></span></div><br>
	<div class=menu><span class=b><a href="myAuction">내가 낙찰한 경매</a></span></div><br>
	<div class=menu><span class=c><a href="myPoint">포인트 기록</a></span></div><br>
	<div class=menu><span class=d><a href="quitChk">회원 탈퇴</a></span></div><br>
</div>
	
<div class=mypage>
	<table class=table2>
		<tr>
			<td class=td1>아이디</td>
			<td>${list.userId}</td>
		</tr>
		<tr>
			<td class=td1>비밀번호</td>
			<td><span>********</span> <button id="toggle1">변경</button>
			<form action ="pwUpdate" method="post">
				<div class="toggle1">
				<span> - 영문 또는 숫자 6자리 이상 입력해 주세요.</span><br>
				새 비밀번호 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" id = "newpw1"  name= "newpw1"><br>
				새 비밀번호 확인&nbsp;<input type="password" id="newpw2"  name="newpw2">
				<input type="submit" id="pwChk" value="수정" onchange="fixname()">
				</div>
			</form>
			</td>
		</tr>
		<tr>
			<td class=td1>닉네임</td>
			<td><span id="nic">${list.nickname}</span> <button id="toggle2">변경</button>
				<div class="toggle2">
					- 이번달 수정 가능 횟수 <span id="change">${nickPossible}</span>회 (월 최대 1회까지만 변경 가능합니다.)<br><br>
					- 길이는 최대 20자 이내로 작성해 주세요.<br>
					- 중복 닉네임 불가합니다.<br><br>
					&nbsp; 현재 닉네임 : <span id="prenick">${list.nickname} </span><br><br>
					<input type="text" id="nickname" name ="nickname" placeholder="새로운 닉네임을 입력하세요." maxlength="20"/>
					<button id="random">닉네임 추천</button>
					<button id="nameChk">중복 확인</button>
					<button id="nameUpt">수정</button>		
				</div>
		</tr>
		<tr>
			<td class=td1>이메일</td>
			<td>${list.email}</td>
		</tr>
		<tr>
			<td class=td1>보유포인트</td>
			<td>${list.point}</td>
		</tr>
	</table>
</div>


</body>
<script>

var msg = "${msg}";
console.log(msg);
if(msg != ""){
	alert(msg);
}


$(".toggle1").hide();
$(".toggle2").hide();

$("#toggle1").click(function(){
    $(".toggle1").toggle(10,function(){
        var tog = $("#toggle1").html();
        if(tog == "변경"){
            $("#toggle1").css("visibility","hidden");
        }else{
            $("#toggle1").html("변경");
        }
    });
}); //비밀번호 변경폼 토글

$("#toggle2").click(function(){
    $(".toggle2").toggle(10,function(){
        var tog = $("#toggle2").html();
        if(tog == "변경"){
            $("#toggle2").css("visibility","hidden");
            $("#nic").css("visibility","hidden");
        }else{
            $("#toggle2").html("변경");
        }
    });
}); //닉네임 변경폼 토글

var nic ="";
$("#nameChk").click(function() {
    nic = $("#nickname").val();
    if(nic == ""){
        alert("새로운 닉네임을 입력하세요");
    }else{
    	nicChk(nic);
    }    
});


var nameCh=false;
function fixname(){
	var nameCh = false;
}
function nicChk(nic) {
    $.ajax({
        type:'POST',
        url:'nicChk',
        dataType : 'JSON',
		data : {'nic' : nic},
		success : function(data){
			console.log(data)
			if(data.nicChk== true){
				alert("중복된 닉네임입니다.");
				$("#nickname").val('');
				console.log(nameCh);
			}else if(data.nicChk==false){
				alert("사용가능한 닉네임 입니다.");
				nameCh = true;
				console.log(nameCh);
			}else{
				alert("닉네임 형식을 확인하세요.");
			}
				
		},
		error : function(){
			alert("ajax error");
		}
	})
}

$("#random").click(function(){
	$name = $("#nickname").val();
	
	$.get({
		type: 'get',
		url: 'https://nickname.hwanmoo.kr/?format=json&count=1',
		data : {},
		dataType: 'text',
		success: function(data){			 
	
		console.log(data);
		// $("#ranNick").val(data);
		var str = data;
		var words = str.split('"');
		console.log(words[3]);
		 $("#nickname").val(words[3]);
		 }		
	})	
});

// function nicChk(nic) {
//     $.ajax({
//         type:'POST',
//         url:'nicChk',
//         dataType : 'JSON',
// 		data : {'nic' : nic},
// 		success : function(data){
// 			console.log(data)
// 			if(data.nicChk== true && data.result==true){
// 				alert("중복된 닉네임입니다.");
// 				$("#nickname").val('');
// 				console.log(nameCh);
// 			}else if(data.nicChk==false && data.result ==true){
// 				alert("사용가능한 닉네임 입니다.");
// 				nameCh = true;
// 				console.log(nameCh);
// 			}else{
// 				alert("닉네임 형식을 확인하세요.");
// 			}
				
// 		},
// 		error : function(){
// 			alert("ajax error");
// 		}
// 	})
// }



$("#nameUpt").click(function() {
    var nicPossible = ${nickPossible};
    	fixname();
   if(nicPossible>0){
    	if(nameCh != false && nic !=""){
			nameUpt(nic);
    	}else{
			alert("닉네임 중복확인을 해주세요.")
    	}
   }else{
	   alert("닉네임 변경 횟수를 확인하세요.")
   }
});

function nameUpt(nic) {
    $.ajax({
        type:'POST',
        url:'nameUpt',
        dataType : 'JSON',
		data : {'nic' : nic},
		success : function(data){
			console.log("아무거나");
			if(data.nameUpt=1){
				alert("닉네임이 수정되었습니다.");
				location.reload();
				prenick();
			}else{
				alert("닉네임 수정 불가");
			}
		},
		error : function(){
			alert("ajax error");
		}
	})
}
prenick();
function prenick(){
    $.ajax({
        type:'POST',
        url:'prenick',
        dataType : 'JSON',
		data : {},
		success : function(data){
			console.log("현재닉네임");
			if(data!=null){
				console.log("닉네임 가져오기 성공");
				$("#prenick").val("${list.nickname}");

			}
		},
		error : function(){
			alert("ajax error");
		}
	})	
}






</script>
</html>