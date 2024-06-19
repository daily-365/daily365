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
<title>댓글</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="container-fluid">
<input type="hidden" id="userId" value="<%=session.getAttribute("userId")%>" >
<br><br>
	<input type="hidden" id="bno" value="${bno }" >
	<input type="hidden" id="writer" value="${userId }" >
	<%Date date = new Date(); %>
	<fmt:formatDate value="<%=date%>" var="now" pattern="yyyy-MM-dd HH:mm:ss"/>
	<input type="hidden" id="regdate" value="${now }">
	<input type="hidden" id="setReplyLikeYn" value="">
	<input type="hidden" id="setReplyReportYn" value="">
	<h4 class="fw-bold">댓글</h4>
	<br><br>
	<form id="replyForm" method="post">
			<div class="col-4">
				<button type="button" class="btn btn-outline-primary"data-bs-toggle="modal" data-bs-target="#staticBackdrop">글쓰기</button>
			</div>
			<br><br>
			<br><br>
			<!-- Modal -->
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="staticBackdropLabel">댓글 쓰기</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			      	<textarea id="content" class="form-control"></textarea>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" id="replyWriteBtn">작성</button>
			        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
			      </div>
			    </div>
			  </div>
			</div>
		<c:forEach var="replyList" items="${replyList }" >
			<input type="hidden" id="rno" value="${replyList.rno }">
		<c:choose>	
		<c:when test="${replyList.reportCnt gt 2 or replyList.deleteYn eq 'Y'}">
			<br><br>
			<div class="col-2">
				<table class="table table-bordered"><tr><td class="fw-bold"><br><br><span class="text-danger">※ </span>삭제된 댓글 입니다.<br><br></td></tr></table>
			</div>
			<br><br>
		</c:when>
		<c:otherwise>
		<div class="row">
			<div class="col-2">
				<c:if test="${replyList.rno ne 0 and replyList.writer eq userId }">
					<textarea rows="5" class="form-control" id="updateContent">${replyList.content }</textarea><br>
					<input type="text" value="${replyList.writer }" readonly="readonly" class="form-control">
					<br>
					<input type="text" value="${replyList.regdate }" readonly="readonly" class="form-control">
					<br>
					
					<span id="likeCnt" class="fw-bold text-warning">좋아요 : ${replyList.likeCnt }  </span><span id="reportCnt" class="fw-bold text-danger">신고 :  ${replyList.reportCnt }</span>
					<br><Br>
				</c:if>
				<c:if test="${replyList.rno ne 0 and replyList.writer ne userId}">
					<textarea rows="5" class="form-control" readonly="readonly" >${replyList.content }</textarea><br>
					<input type="text" value="${replyList.writer }" readonly="readonly" class="form-control">
					<br>
					<input type="text" value="${replyList.regdate }" readonly="readonly" class="form-control">
					<br>
				
					<span id="likeCnt" class="fw-bold text-warning">좋아요 : ${replyList.likeCnt }  </span><span id="reportCnt" class="fw-bold text-danger">신고 :  ${replyList.reportCnt }</span>
					<br><Br>
				</c:if>
			</div>
			<c:if test="${replyList.rno eq 0 }">
				<div class="fw-bold"><span class="text-danger">※ </span>댓글이 없습니다.</div><br><br>
			</c:if>
			<br><br>
			<c:if test="${replyList.writer eq userId}">
				<div class="col-1">
					<button type="button" class="btn btn-warning replyUpdateBtn" value="${replyList.rno }">수정</button><br><br>
					<button type="button" class="btn btn-danger replyDeleteBtn" value="${replyList.rno }">삭제</button>
				</div>
			</c:if>
			
		</div>
		<div class="row">
			<c:if test="${ replyList.rno ne 0 and replyList.writer ne userId }">
				<div class="col-2">
					<button type="button" class="btn btn-outline-warning replyLikeBtn" value="${replyList.rno }">좋아요</button>
					<button type="button" class="btn btn-outline-danger replyReportBtn" value="${replyList.rno }">신고하기</button>
				</div><br>
			</c:if>
		</div>
		</c:otherwise>
		</c:choose>
		</c:forEach>
	</form>
</body>

<script type="text/javascript">

$(document).ready(function(){

	$("#replyWriteBtn").on("click",function(){
		$.ajax({
			url:"/reply/write",
			type:"post",
			data:{	"bno" :$("#bno").val(),
					"writer" :$("#writer").val(),
					"content" :$("#content").val(),
					"regdate" :$("#regdate").val()
		    },success:function(){
		    	alert("작성되었습니다.")
		    	location.reload(true)
		    }
		});
	
	});
	
	$(".replyUpdateBtn").on("click",function(){
		$.ajax({
			url:"/reply/update",
			type:"post",
			data: {"rno": $(this).val(),
					"content" : $("#updateContent").val()
				  },
			success:function(){
				alert("수정되었습니다.")
				location.reload(true)
			}
		})
	
	});
	
	$(".replyDeleteBtn").on("click",function(){
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}else{
			$.ajax({
				url:"/reply/delete",
				type:"post",
				data: {"rno": $(this).val() },
				success:function(){
					alert("삭제되었습니다.")
					location.reload(true)
				}
			});
		}
	});

	$(".replyLikeBtn").on("click",function(){
		$.ajax({
			url:"/reply/like",
			type:"post",
			data: {"rno" :$(this).val(),	
					"userId" :$("#userId").val(),
					"replyLikeCancleYn" :"N" } ,
			success:function(result){
			 alert(result)
			 location.reload(true)
			}
		
		});
	});
	$(".replyReportBtn").on("click",function(){
		$.ajax({
			url:"/reply/report",
			type:"post",
			data: {"rno" : $(this).val(),
					"userId" :$("#userId").val(),
					"replyReportCancleYn" : "N" } ,
			success:function(result){
			 alert(result)
			 location.reload(true)
			}
		
		});
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