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
<title>게시글 상세 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="container-fluid">
	<form id="readForm" method="post">
	<input type="hidden" id="bno" value="${read.bno }">
	<input type="hidden" id="page" value="${param.page }">
	<input type="hidden" id="keyword" value="${param.keyword }">
	<input type="hidden" id="searchType" value="${param.searchType}">
	<input type="hidden" id="pagePerNum" value="${param.pagePerNum }">
	<c:if test="${param.startDate ne null and  param.endDate ne null }">
		<input type="hidden" id="startDate" value="${param.startDate}">
		<input type="hidden" id="endDate" value="${param.endDate }">
	</c:if>
		<input type="hidden" id="fileNo" value="" name="fileNo">
	<br><br>
	<h4 class="fw-bold">게시글 상세 페이지</h4>
	<br><br>
		<div class="col-2">
			<label class="form-label fw-bold">제목</label>
			<input type="text" id="title" class="form-control" value="${read.title }">
		</div><br>
		<div class="col-2">
			<label class="form-label fw-bold">내용</label>
			<textarea id="content" rows="5" class="form-control"> ${read.content }</textarea>
		</div><br>
		<div class="col-2">
			<label class="form-label fw-bold">작성자</label>
			<input type="text"id="writer" readonly="readonly" class="form-control"  value="${read.writer }" >
		</div><br>
		<div class="col-2">
			<label class="form-label fw-bold">작성일</label>
			<input type="text" id="regdate" readonly="readonly" class="form-control"  value="${read.regdate }">
		</div><br>
		<div class="col-4">
		<c:choose>
			<c:when test="${userId eq read.writer }">
				<label class="fw-bold form-label">첨부파일</label><br>
				<input type="file" multiple="multiple" id="multiFile" name="multiFile" style="display: none;">
				<button id="fileAddBtn" type="button" class="btn btn-outline-dark">+ 추가</button>
				<button id="fileModBtn" type="button" class="btn btn-outline-dark">저장</button><br><br>
				<c:if test="${not empty file }">
					<c:set var="fileCount" value="${fn:length(file)}" />
 					<c:forEach var="file" items="${file }" >
						<button type="button" class="fileNameBtn btn btn-outline-primary" value="${file.fileNo }" >${file.originFileName }</button>
						<span> &nbsp;  ${file.fileSize } KB &nbsp;</span> 
						<button type="button" id="file${file.fileNo }" value="${file.fileNo }" class="fileDelBtn btn btn-outline-danger" > X </button>
						<br>
					</c:forEach>
				</c:if>
				
				<div id="fileContent"></div>
			</c:when>
			<c:otherwise>
				<label class="fw-bold form-label">첨부파일</label><br>
				<input type="file" multiple="multiple" id="multiFile" name="multiFile" style="display: none;">
				<c:if test="${not empty file }">
					<c:forEach var="file" items="${file }">
						<button type="button" class="fileNameBtn btn btn-outline-primary" value="${file.fileNo }" >${file.originFileName }</button>
						<span> &nbsp;  ${file.fileSize } KB &nbsp;</span> 
						<br>
					</c:forEach>
				</c:if>
			</c:otherwise>
		</c:choose>
		
		</div>
		<br><br>
		<div class="col-4">
			<c:choose>
				<c:when test="${userId eq read.writer }">
					<button type="button" class="btn btn-primary returnIndex" >목록으로</button>
					<button type="button" class="btn btn-warning" id="updateBtn">수정</button>
					<button type="button" class="btn btn-danger " id="deleteBtn">삭제</button>
					<br><br>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-primary returnIndex" >목록으로</button>
					<br><br>
				</c:otherwise>
			</c:choose>
		</div>
	</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$(".returnIndex").on("click",function(){
		location.href="/?"+"page="+$("#page").val() + "&searchType="+$("#searchType").val()+"&keyword="+$("#keyword").val()+"&pagePerNum="+$("#pagePerNum").val()+"&startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val()
	});
	
	var clicked =0;
	
	var fileNum ='<c:out value="${fileCount }"/>'
	var fileContent = new Array()
	var fileSize = 0;
	var bno = $("#bno").val()
	
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
											"<div>"
											+"<button type='button' class='btn btn-outline-primary'>"+ f.name+"</button>"
											+"<span> &nbsp;"+ (f.size/1024).toFixed(1)  +"&nbsp; KB &nbsp;</span>"
											+"&nbsp; <button id='btn"+fileNum+"' type='button' class='btn btn-outline-danger' > X </button>"
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
			formData.append("bno",bno)
	
		if(fileContent.length<1){
			alert("추가할 파일을 하나이상 선택해 주세요.미 선택시 변경사항 없이 그대로 저장됩니다.");
			return false;
		}else{
			clicked++;

			$.ajax({
				url:"/board/fileUpdate",
				type:"post",
				data:formData,
				enctype: "multipart/form-data",
				processData: false,
				contentType : false,
				success:function(result){
					alert(result)
				}
			});
		}
	}
	
	$("#fileModBtn").on("click",uploadFileFunc)
	
	$("#updateBtn").on("click",function(){
		if(clicked<1&&!confirm("파일이 저장되지 않았습니다. 그대로 진행하시겠습니까?")){
			return false;
		}else{
			$.ajax({
				url:"/board/update",
				type:"post",
				data:{"bno" :$("#bno").val(),
					 "title" :$("#title").val(),
					 "content" : $("#content").val()
				},success:function(result){
					alert(result)
					location.reload(true)
				}
			});
		}
	});
	
	$("#deleteBtn").on("click",function(){
		if(confirm("삭제하시겠습니까"))
		$.ajax({
			url:"/board/delete",
			type:"post",
			data: {"bno" : $("#bno").val()
			},success:function(result){
				alert(result)
				location.href="/";
			}
		});
	});
	
	$(".fileNameBtn ").on("click",function(){
		$("#fileNo").val($(this).val())
		$("#readForm").attr("action","/board/fileDown")
		$("#readForm").submit()
	
	});
	$(".fileDelBtn").on("click",function(){
		if(confirm("기존 파일입니다. 삭제하시겠습니까?"))
		$.ajax({
			url:"/board/fileDelete",
			type:"post",
			data: {"fileNo": $(this).val() },
			success:function(result){
				alert(result)
				location.reload(true)
			}
		});
	});
	
	
});
</script>
</html>