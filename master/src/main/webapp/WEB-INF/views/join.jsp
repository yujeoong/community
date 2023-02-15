<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" href="resources/css/join.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>

	<br><br>
  <h2 id="mt">회원가입</h2>
  <br>
        <div id="meminfo">
           
                <ul>
                    <li>
                        <label for="userId">아이디</label>
                        <input type="text" id="userId" name="userId" maxlength="10" value="" placeholder="아이디를 입력해 주세요" >
                        <input type="button" id="overlay" value="아이디 중복 체크"/>
                        <span class="msg1"></span>
                    </li>

                    <li>
                        <label for="userPass1">비밀번호</label>
                        <input type="password" id="userPass1" name="userPass1" maxlength="10" placeholder="비밀번호를 입력해 주세요">
                        <span class="msg2"></span>
                    </li>
                    <li>
                        <label for="userPass2">비밀번호 확인</label>
                        <input type="password" id="userPass2" name="userPass2" maxlength="10" placeholder="비밀번호 확인을 입력해 주세요">
                        <span class="msg3"></span>
                    </li>
                    <li>
                        <label for="nickName">닉네임</label>
                        <input type="text" id="nickName" name="nickName" value=""  maxlength="20" placeholder="닉네임을 입력해 주세요" >
                        <input type="button" id="over" value="닉네임 중복 체크">
                       	<input type="button" id="random" value="닉네임 랜덤 추천">
                        <span class="msg4"></span>
                    </li>
                    <li>
                        <label for="email">이메일</label>
                        <input type="text" id="email" name="email" placeholder="이메일" >
                       	<input type="button" id="overemail" value="이메일 중복 체크">
                       	<input type="button" id="mailChkBtn" value="인증번호 발송하기"></input>
                       	<span class="msg5"></span>
                       	<label for="blank">&nbsp;</label>
                       	<input type="text" class="mailChk_input" placeholder="인증번호 6자리를 입력해주세요" maxlength="6">
                        
                        <br>
                      
                     </li>
                                              
                    <br>
                    
                    <li id="joinLi">                     
                        <input id="join" type="button" value="회원가입"/>                         
                    </li>
                </ul>


   
        </div>

</body>

<script type="text/javascript">
var idOverlayChk = false;
var nickOverlayChk = false;
var emailOverlayChk = false;

var idValChk = false;
var pwValChk = false;
var nickValChk = false;
var emailValChk = false;

var emailSendBtn = false;
var emailSendChk = false;

// var email_rule = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
$id = $("#userId");

$("#mailChkBtn").click(function(){
	const email = $("#email").val();
	const checkInput = $(".mailChk");
	
	
	if(!emailValChk){
		alert('이메일 형식에 맞지 않습니다.');
	}else{
		$.ajax({
			type: 'get',
			url: '<c:url value="/mailCheck?email="/>'+email,
			success : function(data){
				//console.log("data : "+data);
				checkInput.attr('disabled',false);
				code= data;
				alert("인증번호가 전송되었습니다.");
			}
		});
	}
	

});

$(".mailChk_input").blur(function(){
	const inputCode = $(this).val();
	const $resultMsg = $(".msg5");
	
	if(inputCode === code){
		$resultMsg.html('인증번호가 일치 합니다.');
		$resultMsg.css('color','blue');
		$('#mailChkBtn').attr("disabled",true);
		$('#email').attr('readonly',true);
		emailSendChk = true;
	}else{
		$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해 주세요');
		$resultMsg.css('color','red')
	}
	
	
});
	
$("#join").click(function(){
	
	
	
	$pw = $("#userPass1");
	$pw1 = $("#userPass2");
	$name = $("#nickName");
	$email = $("#email");
	$emailChk = $(".mailChk_input");
	
	if($id.val()==''){
		alert('아이디를 입력해 주세요');
		$id.focus();
	}else if($pw.val()==''){
		alert('비밀번호를 입력해 주세요');
		$pw.focus();
	}else if(!pwValChk){
		alert('비밀번호를 형식에 맞게 입력해 주세요');
		$('#userPass1').val('');
		$pw.focus();
	}else if($pw.val()!== $pw1.val()){
		alert('비밀번호 확인란을 확인해 주세요');
		$pw1.focus();
	}else if($name.val()==''){
		alert('닉네임을 입력해 주세요');
		$name.focus();
	}else if($email.val()==''){
		alert('이메일을 입력해 주세요');
		$email.focus();
	}else if(!idOverlayChk){
		alert('중복아이디 체크를 진행해 주세요.');
		$id.focus();
	}else if(!nickOverlayChk){
		alert('중복닉네임 체크를 진행해 주세요.');
		$id.focus();
	}else if(!emailOverlayChk){
		alert('중복이메일 체크를 진행해 주세요.');
		$id.focus();
	}else if(!emailSendChk){
		alert('이메일 인증을 완료해 주세요.');
		$emailChk.focus();
	}
	else{
		//console.log('서버로 전송');
		var param = {};
		param.userId = $id.val();
		param.password = $pw.val();
		param.nickname = $name.val();
		param.email = $email.val();
		//console.log(param);
		
		$.ajax({
			type:'POST',
			url:'ajaxJoin',
			data:param,
			dataType:'JSON',
			success:function(data){
				//console.log(data);
				if(data.success>0){
					alert("회원 가입에 성공했습니다.")
					location.href="./";
				}else{
					alert("회원 가입에 실패했습니다.")
				}
			},
			error:function(e){
				//console.log(e);
				//console.log("여기1");
			}
			
		});
		}

});


$("#overlay").click(function(){
	var id = $("#userId").val();
	//console.log(id);
	
	$.ajax({
		type:'GET',
		url:'overlay',
		data:{'userId':id},
		dataType:'JSON',
		success:function(data){
			//console.log(data);
			if(data.overlay){
				alert('이미 사용 중인 아이디 입니다.');
				$('.msg1').html('');
				$('#userId').val('');				
			}else if(!idValChk){
				alert('아이디 형식에 맞지 않습니다.');
				$('#userId').val('');	
			}
			else {
				idOverlayChk = true;
				alert('사용가능한 아이디 입니다.')
				$('.msg1').html('<b style="color:blue">사용가능한 아이디 입니다.</b>')
				//console.log("성공")
			}
		},
		error:function(e){
			//console.log(e);
			//console.log("여기2");
		}
		
	});
});

$("#over").click(function(){
	var nickName = $("#nickName").val();
	//console.log(nickName);
	$.ajax({
		type:'GET',
		url:'over',
		data:{'nickName':nickName},
		dataType:'JSON',
		success:function(data){
			//console.log(data);
			if(data.over){
				alert('이미 사용중인 닉네임 입니다.');
				$('.msg4').html('')
				$('#nickName').val('');	
			}
// 			else if(!nickValChk){
// 				alert('닉네임 형식에 맞지 않습니다.');
// 				$('#nickName').val('');
// 			} 
			else{
				nickOverlayChk = true;
				alert('사용 가능한 닉네임 입니다.');
				$('.msg4').html('<b style="color:blue">사용가능한 닉네임 입니다.</b>')
			}
		},
		error:function(e){
			//console.log(e);
		}
	});
});

$("#overemail").click(function(){
	var email = $("#email").val();
	//console.log(email);
	

	$.ajax({
		type:'GET',
		url:'overEmail',
		data:{'email':email},
		dataType:'JSON',
		success:function(data){
			//console.log(data);
			if(data.overEmail){
				alert('이미 사용중인 이메일 입니다.');
				$('.msg5').html('')
				$('#email').val('');	
			}
			else if(!emailValChk){
				alert('이메일 형식에 맞지 않습니다.');
				$('#email').val('');
			}			
			else{
				emailOverlayChk = true;
				alert('사용 가능한 이메일 입니다.');
				$('.msg5').html('<b style="color:blue">사용가능한 이메일 입니다.</b>')
			}
		},
		error:function(e){
			//console.log(e);
		}
	});
});


$(function(){
	
	$("input[type=text][id!=email2],input[type=password]")
	.blur(function(){		
		
		var cid = $(this).attr("id");
		var cv;
		
		cv = groSpace($(this).val());
		
		$(this).val(cv)
		
		//console.log("블러 처리 : "+cid+"/"+cv);
		
		if(cv == ""){
			$(this).siblings(".msg1").text("필수 입력");
			$(this).siblings(".msg2").text("필수 입력");
			$(this).siblings(".msg3").text("필수 입력");
			$(this).siblings(".msg4").text("필수 입력");
			$(this).siblings(".msg5").text("필수 입력");
			
			// pass = false;
		}
		else if(cid == "userId"){
			if(validReg(cv,cid)){
				
				$(this).siblings(".msg1")
				.html('<b style="color:blue">중복검사를 진행해 주세요</b>');
				idValChk = true;
			}
			else{
				$(this).siblings(".msg1")
				.text("아이디는 6~10자의 영문 대·소문자와 숫자로만 입력해 주세요");
				
			}
		}
		else if(cid== "userPass1"){
			
			if (!validReg(cv, cid)){
				$(this).siblings(".msg2").text("비밀번호 6~10자 영문자 또는 숫자");
				// pass = false;
			}
			else{
				pwValChk = true;
				$(this).siblings(".msg2").html('<b style="color:blue">사용가능한 비밀번호 입니다.</b>')
			}
			
		}
		else if(cid == "userPass2"){
			if(cv !== $("#userPass1").val()){
				$(this).siblings(".msg3").text("비밀번호가 일치하지 않습니다.");
				// pass = false;
			}else{
				$(this).siblings(".msg3").html('<b style="color:blue">비밀번호가 일치합니다.</b>')
			}
		}
		else if(cid == "nickName"){
// 			if(validReg(cv,cid)){
				$(this).siblings(".msg4")
				.html('<b style="color:blue">중복검사를 진행해 주세요</b>');
				nickValChk = true;
// 			}
// 			else{
// 				$(this).siblings(".msg4")
// 				.text("닉네임 6~10자의 영문 대·소문자와 숫자로만 입력해 주세요");
// 				// pass = false;
// 			}
		}else if(cid == "email"){
			if(validReg(cv,cid)){
				$(this).siblings(".msg5")
				.html('<b style="color:blue">중복검사를 진행해 주세요</b>');
				emailValChk = true;
			}
			else{
				$(this).siblings(".msg5").text("이메일 형식에 맞지 않습니다.");
				// pass = false;				
			}
			
		}
		
		else{
			$(this).siblings(".msg1").empty();
			$(this).siblings(".msg2").empty();
			$(this).siblings(".msg3").empty();
			$(this).siblings(".msg4").empty();			
		}
	});	
});


$("#random").click(function(){
	$name = $("#nickName").val();
	
	$.get({
		type: 'get',
		url: 'https://nickname.hwanmoo.kr/?format=json&count=1',
		data : {},
		dataType: 'text',
		success: function(data){			 
	
		//console.log(data);
		// $("#ranNick").val(data);
		var str = data;
		var words = str.split('"');
		//console.log(words[3]);
		 $("#nickName").val(words[3]);
		 }		
	})	
});





function groSpace(val){ // val - 전달 변수
    var newval = val.replace(/\s/g,"");
    // replace(바꾸고 싶은 값, 바꿀 값)
    // 바꾸고 싶은 값을 정규식으로 찾아 모두 바꿈
    // 슬래쉬 사이에 값을 쓰고 g 플래그를 사용하여 모두 바꿈
    // 스페이스는 정규식에서 \s로 표시
    // /\s/g -> 스페이스를 모두 찾아라

    // 변경된 값을 반환
    return newval;// 호출한 곳으로 변경된 값을 가지고 돌아간다.

}



function validReg(val, cid) {
    // val - 검사할 값, cid - 처리구분아이디
    //console.log(val+"/"+cid);

    // 정규식 변수
    var reg;

    switch (cid) {
        case "userId": //아이디
        	 reg = /^[a-zA-Z0-9]{6,10}$/g;
            //아이디는 6~10자 영문자 또는 숫자
            break;
        case "userPass1": //비밀번호
        	reg = /^[a-zA-Z0-9]{6,10}$/g;
        	//비밀번호 6~10자 영문자 또는 숫자
            break;
        case "nickName": //아이디
        	reg = /^[a-zA-Z0-9]{6,10}$/g;
            //닉네임 6~10자 영문자 또는 숫자
            break;
        case "email": //이메일
            reg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
            break;

    } ///// switch case문 ///////

    //console.log("정규식:"+reg);
    // 검사결과 리턴
    // test(값) 값을 검사하여 
    // true/false 리턴하는 JS내장함수
    return reg.test(val);

}
</script>
</html>