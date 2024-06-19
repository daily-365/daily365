<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<%Date today =  new Date();%>
<fmt:formatDate var="now" value="<%=today%>" pattern="yyyy-MM-dd HH:mm:ss"/>
<body class="container-fluid">	
	<br><br>
	<h4 class="text-center fw-bold">마이페이지</h4>
	<br><br>
	<div class="g-3 row text-center">
		<div class="col">
				<button type="button" onclick="javascript: location.href='/mypage/updatepass'" class="btn btn-outline-warning">비밀번호 변경</button>
				<button type="button" onclick="javascript: location.href='/mypage/delete'" class="btn btn-outline-danger">탈퇴하기</button>
		</div>
	</div>
	<br><br>
	<form id="mypageForm" method="post">
		<label class="form-label">아이디</label>
		<input id="userId" type="text" value="${member.userId }" readonly="readonly" class="form-control ">
	
		<label class="form-label">이름</label>
		<input id="userName" type="text" value="${member.userName }"  readonly="readonly" class=" form-control">
	
		<label class="form-label">등록일</label>
		<input id="regDate" type="text" value="${member.regDate }" readonly="readonly" class=" form-control">
	
		<label class="form-label">마지막 수정일</label>
		<input id="modDate" type="text" value="${now }" readonly="readonly" class=" form-control">
	</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</html>