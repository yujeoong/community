<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link rel="stylesheet" href="resources/css/pwrest.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
.msg{
   color: red;
}
</style>
</head>
<body>
<%@ include file="header.jsp" %>

<br><br>

<div id="pwRe">
<form action="updatePw" method="post">
   <h3>비밀번호 재설정</h3>
   <br>
      <ul>
         <li>
            <label>비밀번호</label>
            <input type="password" name="newPw" id="newPw" required maxlength="10">
            <span class="msg"></span>
            
            <input type="hidden" name="userId" value="${userId}">
         </li>
         
         
         <li>
            <label>비밀번호 확인</label>
            <input type="password" name="newPw1" id="newPw1" required maxlength="10">
            <span class="msg"></span>
         </li>
         <br><br>
         <li>
            <input type="submit" value="완료" id="pwReset">
         </li>
      
      </ul>
   
<!--       <table> -->

<!--          <tr> -->
<!--             <td>비밀번호 : <input type="password" name="newPw" id="newPw" required maxlength="10"></td> -->
<!--             <span class="msg"></span> -->
<!--          </tr> -->
<!--          <tr> -->
<!--             <td><input type="hidden" name="userId" value="${userId}"></td> --!>
<!--          </tr> -->
<!--          <tr> -->
<!--             <td><input type="submit" value="완료" id="pwReset"></td> -->
<!--          </tr> -->
         
<!--       </table> -->
   </form>
   
</div>
</body>
<script>
var pwChk = false;

var msg = "${msg}";
if(msg != ""){
   alert(msg);
}

var pwRul = /^[a-zA-Z0-9]{6,10}$/;


$(function(){
   
   $("input[type=password]").blur(function(){
      
      var newPw = $("#newPw").val();
      
      
      if($("#newPw").val() == ""){
         $("#newPw").siblings(".msg").text("필수 입력");
         
      }else if(!pwRul.test($("#newPw").val())){
         $("#newPw").siblings(".msg").text("사용불가능한 비밀번호입니다.");
         $("#newPw").val('');
         
      }else if(pwRul.test($("#newPw").val())){
         $("#newPw").siblings(".msg").html('<b style="color:blue">사용가능한 비밀번호입니다.</b>');
         
         if($("#newPw").val() != $("#newPw1").val()){
            console.log("비밀번호 다릅니다.");
             $("#newPw1").siblings(".msg").text("비밀번호가 다릅니다.");
             $("#newPw1").val('');
         }else if($("#newPw").val() == $("#newPw1").val()){
             $("#newPw1").siblings(".msg").html('<b style="color:blue"> 비밀번호가 일치합니다.</b>');
         }
      }else{
         $("#newPw").siblings(".msg").html('<b style="color:blue">비밀번호 변경이 가능합니다.</b>');
      }

   })
   
});


</script>
</html>