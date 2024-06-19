<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="container-fluid">
	<br><br>
	<div class="g-3 row">
		<br><br>
		<h4 class="fw-bold">로그인</h4>
		<form id="loginForm" method="post">
			<div class="col-2">
				<label class="form-label">아이디</label>	
				<input type="text" id="userId" name="userId" class="form-control">
			</div>
			<div class="col-2">
				<label class="form-label">비밀번호</label>	
				<input type="password" id="userPass" name="userPass" class="form-control">
			</div>
			<br><br>
			<div class="col-2">
				<button type="button"	id="loginBtn" class="btn btn-outline-success">로그인</button>	
			</div>
			<br><br>
			<c:if test="${result eq false }">
				<div class="text-danger fw-bold">※ 아이디와 비밀번호를 확인해 주세요</div>
			</c:if>	
		</form>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#userId").focus()
	$("#loginBtn").on("click",function(){
		if(!$("#userId").val()){
			alert("아이디를 입력해 주세요");
			$("#userId").focus()
			return false;
		}else if(!$("#userPass").val()){
			alert("비밀번호를 입력해 주세요")
			$("#userPass").focus()
			return false;
		}else{
			$("#loginForm").attr("action","/member/login")
			$("#loginForm").submit()
		}
	
	});

});

</script>


</html>