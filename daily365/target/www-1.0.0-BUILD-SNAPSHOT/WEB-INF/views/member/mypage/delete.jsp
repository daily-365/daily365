<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="container-fluid">
	<br><br>
	<h4 class="text-center fw-bold">비밀번호 변경</h4>
	<br><br>
	<form id="mypageForm" method="post">
		<input type="hidden" id="modDate" value="${now }">
		<label class="form-label">아이디</label>
		<input id="userId" type="text" value="${userId }" readonly="readonly" class="form-control">

		<label class="form-label">비밀번호</label>
		<input id="userPass" type="password" maxlength="16" class="form-control">

		<label class="form-label">비밀번호 확인</label>
		<input id="userPassChk" type="password" maxlength="16" class="form-control">
		<br><br>
		<button type="button" id="deleteBtn" class="btn btn-outline-danger">탈퇴하기</button>
	</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$("#deleteBtn").on("click",function(){
		if(!$("#userPass").val()){
			alert("비밀번호를 입력해 주세요")
			return false;
		}if(!$("#userPassChk").val()){
			alert("비밀번호를 확인해 주세요")
			return false;
		}if($("#userPass").val()!=$("#userPassChk").val()){
			alert("비밀번호가 서로 다릅니다.")
			return false;
		}else{
			$.ajax({
				url:"/mypage/passchk",
				type:"post",
				data:{"userId":$("#userId").val()
						, "userPass" :$("#userPass").val() },
				success:function(result){
					if(result==false){
						alert("비밀번호가 일치하지 않습니다.")
						return false
					}else{
						if(confirm("정말로 탈퇴하시겠습니까?")){
							$.ajax({
								url:"/mypage/delete",
								type:"post",
								data:{"userId":$("#userId").val() ,
									"userPass" :$("#userPass").val()},
								success:function(result){
								  	console.log(result)
								  	alert("탈퇴되었습니다.")
								  	location.href="/"
								  }
							
							});
						}
					}
				}
			});
		}
		
		
	});
	

});


</script>
</html>