<%@page import="java.util.Date"%>
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
<title>글쓰기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<% Date sysdate = new Date();
%>
<fmt:formatDate value="<%=sysdate %>" var="now" pattern="YYYY-MM-dd HH:mm:SS"/>
<body class="container-fluid">
	<br><br>
	<h4 class="fw-bold" >글쓰기</h4>
	<br><br>
	<form id="writeForm"  method="post" enctype="multipart/form-data">
	<div>
		<div class="col-6">
			<label class="form-label fw-bold">제목</label>
			<input type="text" id="title" name="title" class="form-control" maxlength="20">
			<div id="titleChk"></div>
		</div>
		<div class="col-6">
			<label class="form-label fw-bold">내용</label>
			<textarea id="content" class="form-control" name="content" maxlength="500"></textarea>
			<div id="contentChk"></div>
		</div>
		<div class="col-6">
			<label class="form-label fw-bold">작성자</label>
			<input type="text" name="writer" class="form-control" value="<%=session.getAttribute("userId")%>" maxlength="10" readonly="readonly" class="form-control">
		</div>
		<br><br>
		<div class="col-6">
			<input id="multiFile" type="file" name="multiFile" multiple="multiple" style="display: none;"><br>
			<button id="fileAddBtn" type="button" class="btn btn-outline-secondary">파일추가</button><br><br>
			<div class="fw-bold"><span class="text-danger">※ </span>파일은 5개 까지만 등록 가능합니다.</div><br>
			<div id="fileContent"></div><br>
		</div>
		<br><br>
		<div class="col-6">
			<button type="button" id="writeBtn" class="btn btn-primary col-4">작성</button>
		</div>
	
	</div>
	</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$("#title").focus()
	
	$("#writeBtn").on("click",function(){
		if(!$("#title").val()){
			$("#title").focus()
			$("#titleChk").text("제목을 작성해 주세요")
			$("#titleChk").attr("class","text-danger")
			
		}else if(!$("#content").val()){
			$("#content").focus()
			$("#contentChk").text("내용을 작성해 주세요")
			$("#contentChk").attr("class","text-danger")
		}else{
			uploadFileFunc()
			$("#writeForm").attr("action","/board/write")
			$("#writeForm").submit()
			alert("작성되었습니다")
		}
	});
	


	var fileNum =0;
	var fileContent =new Array()
	var fileSize = 0;
		
	$("#fileAddBtn").on("click",function(e){
		e.preventDefault();
		$("#multiFile").click()
	});	
	
	$("#multiFile").on("change",fileAddFunc)
	
	function fileAddFunc(e){
		var files = e.target.files;
	 	var fileArr = Array.prototype.slice.call(files);
				
		fileArr.forEach(function(f){ 		
			var reader = new FileReader();
			fileNum++;	
			
			var fileExt = f.type.substring(f.type.lastIndexOf("/")).replace("/","")
			
			fileSize +=f.size;
			
			if(fileNum>5){
				alert("파일은 5개까지 등록 가능합니다.");
				return false;
			}if(fileExt!='jpeg' && fileExt!='jpg'&&fileExt!='png'&&fileExt!='gif'){
				alert("확장자는 jpeg/jpg/png/gif 파일만 등록 가능합니다.")
				fileNum--;
				fileSize -=f.size;
					return false;
			}if(fileSize>1024**2*3){
				alert("용량은 3M 이하여야 합니다.")
				fileNum--;
				fileSize -=f.size;
				return false;
			}else{
				reader.onload=function(e){
					fileContent.push(f)
					$("#fileContent").append(
											"<div  id='file"+fileNum+"' class='fw-bold'>"
											+"<span>"+ f.name+"</span>"
											+"&nbsp;<button id='btn"+fileNum+"' type='button' class='btn btn-outline-danger' > X </button>"
											+"</div>"
											)
						$("#btn"+fileNum).on("click",function(){
							fileNum--;
							$(this).parent('div').remove()
						});
					}
					reader.readAsDataURL(f)
				}
			});
		$("#multiFile").val("")
	}

	function uploadFileFunc(){
		var formData = new FormData()
		
		for(var i=0; i<fileContent.length; i++){
			formData.append("uploadFiles",fileContent[i])
		}
	
		console.log(formData,fileContent)
		
		$.ajax({
			url:"/board/fileUpload",
			type:"post",
			data:formData,
			enctype: "multipart/form-data",
			processData: false,
			contentType : false,
			success:function(result){
				console.log(result)
			}
		});
	}
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
			location.href="/member/logout"
		}
	}
	 //1초식 감소
	var setinterval = setInterval(timer,1000);
	
	//타이머 리셋 
	$("#timerResetBtn").on("click",function(){
		localStorage.clear()
		$("#timer").html(convertSeconds(600))
		counter=0;
		
	});
	
});
</script>
</html>