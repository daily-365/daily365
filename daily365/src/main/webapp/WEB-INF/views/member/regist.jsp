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
<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="container-fluid"> 
	<br><br>
	<div class="align-items-center">
	<h4>회원가입</h4>
	<br><br>
		<form class="form" id="registForm" method="post">
			<div class="col-2">
				<label class="form-label fw-bold"><span class="text-danger">※</span> 아이디</label>
				<input type="text" id="userId" name="userId" class="form-control  " maxlength="15">
				<div id="userIdChk"></div>
			</div>
			<div class=" col-2">	
				<label class="form-label fw-bold"><span class="text-danger">※</span> 비밀번호</label>
				<input type="password" id="userPass" name="userPass" class="form-control " maxlength="16">
				<div id="userPwChk"></div>
			</div>
			<div class=" col-2">	
				<label class="form-label fw-bold"><span class="text-danger">※</span> 비밀번호 확인</label>
				<input type="password"  id="userPassChk" class="form-control " maxlength="16">
				<div id="userPwChk2"></div>
			</div>
			<div class=" col-2">	
				<label class="form-label fw-bold"><span class="text-danger">※</span> 이름</label>
				<input type="text" id="userName" name="userName" class="form-control " maxlength="10">
				<div id="userNameChk"></div>
			</div>
			<div class="col-2 ">	
				<button type="button" id="registBtn" class="btn btn-outline-success form-control fw-bold">가입</button>
			</div>
		</form>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){

	$("#userId").focus()
	$("#registBtn").on("click",function(){
		
	var idReg =RegExp(/^[A-za-z0-9]{5,15}/g);
	//영문 대문자 또는 소문자 또는 숫자로 시작하는 5자이상 입력해 주세요
	var passReg =RegExp(/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/);
	//8 ~ 16자 영문, 숫자, 특수문자를 입력해 주세요
		
		if(!$("#userId").val()){
			$("#userIdChk").text("아이디를 입력해 주세요");
			$("#userIdChk").attr("class","text-danger");
			$("#userId").focus()
			return false;
		}else{
				$.ajax({
					url:"/member/idDupChk",
					type:"post",
					data: {"userId" : $("#userId").val() },
					success:function(result){
						if(!result){
							alert("중복된 아이디입니다.")
							return false;
						}else{
							if(!idReg.test($("#userId").val())){	
								$("#userIdChk").text("영문 대문자 또는 소문자 또는 숫자로 시작하는 5자이상 입력해 주세요");
								$("#userIdChk").attr("class","text-warning");
								$("#userId").focus()
								return false;
							}else if(!$("#userPass").val()){
								$("#userIdChk").text("사용가능한 아이디 입니다.");
								$("#userIdChk").attr("class","text-primary");
								$("#userPwChk").text("비밀번호를 입력해 주세요");
								$("#userPwChk").attr("class","text-danger");
								$("#userPass").focus()
								return false;
							}else if(!passReg.test($("#userPass").val())){
								$("#userPwChk").text("8 ~ 16자 영문, 숫자, 특수문자를 입력해 주세요");
								$("#userPwChk").attr("class","text-warning")
								$("#userPass").focus()
								return false;
							}else if(!$("#userPassChk").val()||( $("#userPass").val()!=$("#userPassChk").val() ) ){
								$("#userPwChk").text("사용가능한 비밀번호 입니다.");
								$("#userPwChk").attr("class","text-primary")
								$("#userPwChk2").text("비밀번호를 확인해주세요.");
								$("#userPwChk2").attr("class","text-danger")
								$("#userPassChk").focus()
								return false;
							}else if(!$("#userName").val()){
								$("#userPwChk2").text("비밀번호가 확인되었습니다.");
								$("#userPwChk2").attr("class","text-primary")
								$("#userNameChk").text("이름을 입력해 주세요")
								$("#userNameChk").attr("class","text-danger");
								$("#userName").focus()
								return false;
							}else{
								$("#userNameChk").text("이름이 확인 되었습니다.")
								$("#userNameChk").attr("class","text-primary");
								
								$("#registForm").attr("action","/member/regist");
								$("#registForm").submit()
								alert("가입되었습니다.");
										
							}
						}
					}
				})
			}	
		});

});
</script>
</html>