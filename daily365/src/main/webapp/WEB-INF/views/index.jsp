<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<title>Main</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<%@ include file="common/datepicker.jsp" %>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

</head>
<body class="container-fluid">
	<input type="hidden" id="userId" value="<%=session.getAttribute("userId")%>" >
	<br><br>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	    <a class="navbar-brand fw-bold text-dark h4" href="#"><%=session.getAttribute("userId")%></a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link fw-bold text-dark" aria-current="page" href="/mypage/main">마이페이지</a>
	        </li>
	        <li class="nav-item ">
	          <a class="nav-link fw-bold text-dark" href="/board/write" id="writeBtn">글쓰기</a>
	        </li>
	        <li class="nav-item ">
         	  <a class="nav-link fw-bold text-dark" href="/member/logout" onclick="javascript: alert('로그아웃 되었습니다.')" id="logoutBtn">로그아웃</a>
	        </li>
	      </ul>
	     </div>
	     <div class="row">
      		<div class="col">
	       		<i class="bi bi-alarm">
	        		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-alarm" viewBox="0 0 16 16">
	  					<path d="M8.5 5.5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9z"/>
	  					<path d="M6.5 0a.5.5 0 0 0 0 1H7v1.07a7.001 7.001 0 0 0-3.273 12.474l-.602.602a.5.5 0 0 0 .707.708l.746-.746A6.97 6.97 0 0 0 8 16a6.97 6.97 0 0 0 3.422-.892l.746.746a.5.5 0 0 0 .707-.708l-.601-.602A7.001 7.001 0 0 0 9 2.07V1h.5a.5.5 0 0 0 0-1zm1.038 3.018a6 6 0 0 1 .924 0 6 6 0 1 1-.924 0M0 3.5c0 .753.333 1.429.86 1.887A8.04 8.04 0 0 1 4.387 1.86 2.5 2.5 0 0 0 0 3.5M13.5 1c-.753 0-1.429.333-1.887.86a8.04 8.04 0 0 1 3.527 3.527A2.5 2.5 0 0 0 13.5 1"/>
					</svg>
	        	</i>
        		<span id="timer"></span>
        		<i  id="timerResetBtn" class="bi bi-arrow-counterclockwise">
        			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2z"/>
					    <path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466"/>
					</svg>
				</i>
			</div>
      	</div>
   	 </nav>
   	 <br><br>
      <form id="excelForm" method="post">
      	<div class="row">
      		<div class="col-2">
				<select id="pagePerNum" name="pagePerNum"  class="form-control ">
					<option value=10 <c:out value="${scri.pagePerNum eq 10?'selected':'' }"/>>10개씩보기</option>
					<option value=15 <c:out value="${scri.pagePerNum eq 15?'selected':'' }"/>>15개씩보기</option>
					<option value=30 <c:out value="${scri.pagePerNum eq 30?'selected':'' }"/>>30개씩보기</option>
					<option value=50 <c:out value="${scri.pagePerNum eq 50?'selected':'' }"/>>50개씩보기</option>
				</select>
			</div>
      		<div class="col-1">
				<select name="searchType" id="searchType" class="form-control ">
					<option value="all" <c:out value="${scri.searchType eq 'all'?'selected':'' }"/>>전체</option>
					<option value="t" <c:out value="${scri.searchType eq 't'?'selected':'' }"/>>제목</option>
					<option value="c" <c:out value="${scri.searchType eq 'c'?'selected':'' }"/>>내용</option>
					<option value="w" <c:out value="${scri.searchType eq 'w'?'selected':'' }"/>>작성자</option>
				</select>
			</div>
			<div class="col-2">
				<input type="text" id="startDate" name="startDate" class="form-control" readonly="readonly" placeholder="시작날짜" value="${scri.startDate }" >
			</div>
			<div class="col-2">
				<input type="text" id="endDate" name="endDate" class="form-control"  readonly="readonly" placeholder="끝날짜" value="${scri.endDate }" >
			</div>
			<div class="col-2">
	        	<input class="form-control me-2" type="search" placeholder="검색어를 입력해주세요" id="keyword" name="keyword" aria-label="Search"  value= "${scri.keyword }">
	        </div>
	        <div class="col-1">
	        	<button class="btn btn-outline-success" type="button" id="searchBtn">검색</button>
      		</div>
      		<div class="col-2">
        		<button type="button" class="btn btn-success" id="excelDownBtn">엑셀 파일 다운로드</button>
       		</div>
      	</div>
      </form>
     
	<br><br>
	<div class="g-3 row">
		<table class="table table-hover table-bordered">
			<tr>	
				<th>#</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>댓글</th>
				<th>좋아요 / 신고</th>
			</tr>
			<c:forEach var="list" items="${list }" >
				<tr>
					<td >${list.rnum }</td>
					<td><button type="button" value="${list.bno }" class="readBtn btn btn-outline-primary">${list.title }</button></td>
					<td>${list.writer }</td>
					<td>${list.regdate }</td>
					<td>${list.hitCnt }</td>
					<td><button type="button" class="replyBtn btn btn-outline-success"  value="${list.bno}">댓글 보기</button></td>
					<td> 
						<button type="button" class="likeBtn btn btn-warning"  value="${list.bno}" >추천  ${list.likeCnt }</button>
						<button type="button" class="reportBtn btn btn-danger"  value="${list.bno}">신고  ${list.reportCnt }</button> 
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<br><br>
	<div class="text-center">
		<a class="btn btn-primary" href="${pageMaker.makeSearch(1) }">&laquo;&laquo;</a>
		<c:if test="${pageMaker.prev }">
			<a class="btn btn-outline-primary" href="${pageMaker.makeSearch(pageMaker.startPage-1) }">&laquo;</a>
		</c:if>
		<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage}"  >
			<a class="btn btn-outline-primary <c:if test="${param.page eq idx}">active</c:if>"  href="${pageMaker.makeSearch(idx) }">${idx}</a>
		</c:forEach>
		<c:if test="${pageMaker.next && pageMaker.endPage>0}">
			<a class="btn btn-outline-primary" href="${pageMaker.makeSearch(pageMaker.endPage+1)}">&raquo;</a>
		</c:if>
		<a class="btn btn-primary" href="${pageMaker.makeSearch(pageMaker.maxPage) }">&raquo;&raquo;</a>
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Jquery CountDown -->
<script src="https://cdn.jsdelivr.net/npm/jquery-countdown@2.2.0/dist/jquery.countdown.min.js"></script>
<script type="text/javascript">

	
$(document).ready(function(){

	  //모든 datepicker에 대한 공통 옵션 설정
      	$.datepicker.setDefaults({
          dateFormat: 'yy-mm-dd' //Input Display Format 변경
          ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
          ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
          ,changeYear: true //콤보박스에서 년 선택 가능
          ,changeMonth: true //콤보박스에서 월 선택 가능                
          ,showOn: "button" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
          ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
          ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
          ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
          ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
          ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
          ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
          ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
          ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트

     	 });
	   
	$('#startDate').datepicker();
   	$('#startDate').datepicker("option", "maxDate", $("#endDate").val());
    $('#startDate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#endDate").datepicker( "option", "minDate", selectedDate );
    });

    $('#endDate').datepicker();
    $('#endDate').datepicker("option", "minDate", $("#startDate").val());
    $('#endDate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#startDate").datepicker( "option", "maxDate", selectedDate );
    });;
	
	$("#pagePerNum").on("change",function(){
		self.location="${pageMaker.makeQuery(1)}" +"&searchType="+$("#searchType").val()+"&keyword="+$("#keyword").val()+"&pagePerNum="+$("#pagePerNum").val()+"&startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val()
	});
	
	$("#searchBtn").on("click",function(){
		self.location="${pageMaker.makeQuery(1)}" +"&searchType="+$("#searchType").val()+"&keyword="+$("#keyword").val()+"&pagePerNum="+$("#pagePerNum").val()+"&startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val()
	});
	
	$(".likeBtn").on("click",function(){
		$.ajax({
			url:"/board/like",
			type:"post",
			data : {"bno": $(this).val() 
					,"userId" : $("#userId").val()  },
			success : function(result){
				alert(result)
				location.reload(true)
			} 
		});
	});
	
	$(".reportBtn").on("click",function(){
		$.ajax({
			url:"/board/report",
			type:"post",
			data : {"bno": $(this).val() 
					,"userId" : $("#userId").val() },
			success:function(result){
				alert(result)
				location.reload(true)
			}
		});
	});
	
	$(".readBtn").on("click",function(){
		location.href="/board/read"+"${pageMaker.makeQuery(1)}" +"&searchType="+$("#searchType").val()+"&keyword="+$("#keyword").val()+"&pagePerNum="+$("#pagePerNum").val()+"&bno="+$(this).val()+"&startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val()

	});
	
	$(".replyBtn").on("click",function(){
		location.href="/board/reply"+"${pageMaker.makeQuery(1)}" +"&searchType="+$("#searchType").val()+"&keyword="+$("#keyword").val()+"&pagePerNum="+$("#pagePerNum").val()+"&bno="+$(this).val()+"&startDate="+$("#startDate").val()+"&endDate="+$("#endDate").val()
		
	});
	
	$("#excelDownBtn").on("click",function(){
		$("#excelForm").attr("action","/board/excelDown")
		$("#excelForm").submit();
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
	
	//타이머 리셋 
	$("#timerResetBtn").on("click",function(){
		localStorage.clear()
		$("#timer").html(convertSeconds(600))
		counter=0;
		
	});
});
</script>
</html>
