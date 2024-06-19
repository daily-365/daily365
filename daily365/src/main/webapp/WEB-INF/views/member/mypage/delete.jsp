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
<body class="container">
	<nav class="navbar navbar-expand-lg bg-body-tertiary bg-dark">
  <div class="container">
    <a class="navbar-brand" href="#">Calendar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
      	<li class="nav-item">
          <a class="nav-link" href="/mypage/main">MyPage</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/">MainPage</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Management
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/mypage/account">개인정보관리</a></li>
            <li><a class="dropdown-item" href="/mypage/calendar">일정관리</a></li>
            <li><a class="dropdown-item" href="/mypage/statistics">통계</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="/member/logout">Logout</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
	<br><br>
	<h4 class="text-center fw-bold">회원 탈퇴</h4>
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
	<br><br><br><br>
<footer class="bg-dark">
   <div class="container" style="padding: 30px;">
   	<p class="m-0 text-center text-white">@Copyright : TaeHa-Hwang</p>
   </div>
</footer>
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
	
	// 타이머 
	var counter =0;
	var seconds = 600;
	
	function convertSeconds(s){
		var min = Math.floor(s/60)
		var sec = s%60;
		
		if(String(sec).length==1){
			return min+":0"+sec
		}else{
			return min+":"+sec
		}
	}
	
	
	function timer(){
		counter = localStorage.getItem("counter")
		counter ++;
		
		//localStrorage에 저장 : 화면전환후에도 값이 유지되게 함을 위함.
		var minute=convertSeconds(seconds-counter).substring(0,1)*60
		var second=convertSeconds(seconds-counter).substring(2,5)
		
		localStorage.setItem("counter",counter)
		localStorage.setItem("seconds",String(Number(minute)+Number(second)))
		
		var storageMin =  Math.floor(localStorage.getItem("seconds")/60)
		var storageSec =  localStorage.getItem("seconds")%60;
		
		if(String(storageSec).length==1){
			$("#timer").html(storageMin+":0"+storageSec)
		}else{
			$("#timer").html(storageMin+":"+storageSec)
		}
		
		if(counter==600){
			alert("세션이 만료 되었습니다. 다시 로그인 해 주세요")
			$("#timer").html("00:00")
			localStorage.clear()
			location.href="/member/logout"
		}
	}
	 //1초식 감소
	var setinterval = setInterval(timer,1000);
	
});


</script>
</html>