<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style></style>
</head>
<body>

</body>
<script>
	var message = "${msg}";
	var url = "${url}";
	if(message !=""){
		alert(message);
		if(url =="closePopUp"){
			self.close();
		}else{		
			document.location.href = url;
		}
	}else{
		alert("메세지없음");
		history.back();
	}
</script>
</html>