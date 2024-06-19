<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<title>calendar</title>
<style>
/* fullCalendar CSS (link/script 보다 위에 위치해야함) */

/* 일요일 날짜 빨간색 */
.fc-day-sun {
  color: red;
  text-decoration: none;
}

/* 토요일 날짜 파란색 */
.fc-day-sat {
  color: blue;
  text-decoration: none;
}

</style>
</head>
 <!-- jquery -->
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <!-- bootstrap 4 -->
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <!-- flatpicker -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/airbnb.css">
<!-- fullcalendar -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
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
	<div class="d-flex justify-content-center">
		<h4 class="fw-bold text-dark">일정 관리</h4>
	</div>
	<br><br>
	<div class="row">
		<div class="col">
			<div class="card" style="padding:10px; background-color:red; ">
			  <div class="card-body">
			    <h5 class="card-title text-white fw-bold">휴가</h5>
			  </div>
			</div>
		</div>
		<div class="col">
			<div class="card" style="padding:10px; background-color:green; ">
			  <div class="card-body">
			    <h5 class="card-title text-white fw-bold">회의</h5>
			  </div>
			</div>
		</div>
		<div class="col">
			<div class="card" style="padding:10px; background-color:blue; ">
			  <div class="card-body">
			    <h5 class="card-title text-white fw-bold">행사</h5>
			  </div>
			</div>
		</div>
		<div class="col">
			<div class="card" style="padding:10px; background-color:yellow; ">
			  <div class="card-body">
			    <h5 class="card-title text-white fw-bold">기타</h5>
			  </div>
			</div>
		</div>
	</div>
	<br><br>
	
	<!-- Button trigger modal -->
<button id="regModalBtn" type="button" style="display: none;" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#regModal">
</button>

<!-- Modal -->
<div class="modal fade" id="regModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-center fw-bold h4" id="exampleModalLabel">일정 등록</h1>
      </div>
      <div class="modal-body fw-bold">
      <input type="hidden" id="regUserId" value="${userId}">
      	<div class="col">
      		<label class="form-label">제목</label>
      		<input type="text" id="regTitle"  class="form-control">
      	</div><br>
      	<div class="col">
      		<label class="form-label">내용</label>
      		<textarea id="regContent" class="form-control" ></textarea>
      	</div><br>
        <div class="col">
        	<label class="form-label">시작일</label>
			<input type="text" id="regStartDate"  class="form-control" placeholder="시작일을 선택해주세요.">
		</div><br>
		<div class="col">
			<label class="form-label">종료일</label>
			<input type="text" id="regEndDate"  class="form-control" placeholder="종료일을 선택해주세요." >
		</div><br>
		<div class="col">
			<label class="form-label">종류</label>
			<select id="regEventType" class="form-control">
				<option value="">선택</option>
				<option value="red">휴가</option>
				<option value="green">회의</option>
				<option value="blue">행사</option>
				<option value="yellow">기타</option>
			</select>
		</div><br>
      </div>
      <div class="modal-footer">
      	<button type="button"  id="addEventBtn" class="btn btn-primary">등록</button>
        <button type="button" id="closeBtn" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

	<!-- Button trigger modal -->
<button id="readModalBtn" type="button" style="display: none;" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#readModal">
</button>

<!-- Modal -->
<div class="modal fade" id="readModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-center fw-bold h4" id="exampleModalLabel">일정 등록</h1>
      </div>
      <div class="modal-body fw-bold">
      	<input type="hidden" id="readIdx">
      	<input type="hidden" id="readWriter">
      	<div class="col">
      		<label class="form-label">제목</label>
      		<input type="text" id="readTitle" class="form-control">
      	</div><br>
      	<div class="col">
      		<label class="form-label">내용</label>
      		<textarea id="readContent" class="form-control" ></textarea>
      	</div><br>
        <div class="col">
        	<label class="form-label">시작일</label>
			<input type="text" id="readStartDate" class="form-control" placeholder="시작일을 선택해주세요.">
		</div><br>
		<div class="col">
			<label class="form-label">종료일</label>
			<input type="text" id="readEndDate"  class="form-control" placeholder="종료일을 선택해주세요." >
		</div><br>
		<div class="col">
			<label class="form-label">종류</label>
			<select id="readEventType"  class="form-control">
				<option value="">선택</option>
				<option value="red">휴가</option>
				<option value="green">회의</option>
				<option value="blue">행사</option>
				<option value="yellow">기타</option>
			</select>
		</div><br>
      </div>
      <div class="modal-footer">
      	<button type="button"  id="modEventBtn" class="btn btn-warning">수정</button>
      	<button type="button"  id="delEventBtn" class="btn btn-danger">삭제</button>
        <button type="button" id="closeBtn" class="btn btn-dark" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div id="calendar"></div>
<br><br><br><br>
<footer class="bg-dark">
   <div class="container" style="padding: 30px;">
   	<p class="m-0 text-center text-white">@Copyright : TaeHa-Hwang</p>
   </div>
</footer>
</body>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- bootStrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- flatpicker -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr@latest/dist/l10n/ko.js"></script>
<!-- fullcalendar -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	//flatPickr 초기 설정
	$("#regStartDate,#readStartDate").flatpickr({
		locale: 'ko',
		format: 'Y-m-d H:i',
		enableTime: true,
		defaultDate : 'today'
	})
	$("#regEndDate,#readEndDate").flatpickr({
		locale: 'ko',
		format : 'Y-m-d H:i',
		enableTime: true,
		defaultDate: 'today'
	})
	
	// 시작날짜 끝날짜 범위 지정
	var startDate;
	$("#regStartDate,#readStartDate").on("change",function(){
		startDate = this.value
		$("#regEndDate,#readEndDate").flatpickr({
			locale: 'ko',
			format: 'Y-m-d H:i',
			enableTime: true,
			minDate : startDate
		})
	})
	var endDate;
	$("#regEndDate,#regEndDate").on("change",function(){
		endDate = this.value
		$("#regStartDate,#regStartDate").flatpickr({
			locale: 'ko',
			format: 'Y-m-d H:i',
			enableTime: true,
			maxDate : endDate
		})
	})
	
	//modal 닫기 버튼 클릭시 날짜 값 없애기
	$("#closeBtn").on("click",function(){
		$("#regStartDate,#readStartDate,#regEndDate,#regEndDate").val("")
	});
	
	function modCalendarFunc(){
		var readContent = $("#readContent").val().replaceAll(/(?:\r\n|\r|\n)/g, '<br>'); //textarea enter 문제
		
		$.ajax({
			url : "/mypage/calendar/update",
			type : "post",
			data : {"idx" : $("#readIdx").val(),
					"title" :  $("#readTitle").val(),
					"content" :  readContent,
					"start" :  $("#readStartDate").val(),
					"end" :  $("#readEndDate").val(),
					"color" :  $("#readEventType").val()
			},success: function(result){
				alert(result)
				location.reload(true);
			}
		});
	}
	
	function delCalendarFunc(){
		if(!confirm("해당 일정을 삭제하시겠습니까?")){
			return false;
		}else{
			$.ajax({
				url : "/mypage/calendar/delete",
				type: "post",
				data : { "idx" : $("#readIdx").val()
				},success:function(result){
					alert(result)
					location.reload(true);
				}
			});
		}
	}
	
	var calendarEl = document.getElementById("calendar"); //캘린더를 넣어줄 html div
	var calendar;
	
	calendarRendering();
	
	function calendarRendering() {
	  calendar = new FullCalendar.Calendar(calendarEl, {
	  	googleCalendarApiKey : 'AIzaSyCtpVmWXVfqvdzspZCyuKn5jfpIR1S-aQs',
	    titleFormat: function (date) {
	      year = date.date.year;
	      month = date.date.month + 1;
	      return year + "년 " + month + "월";
	    },headerToolbar : {
	    	left : 'addEventBtn',
	    	center : 'title',
	    	right : 'prev next today dayGridMonth listMonth'
	    },customButtons : {
	    	addEventBtn : {
	    		text:"일정 등록",
	    		click: function(){
	    			$("#regModalBtn").click()
  					
	    			$("#addEventBtn").on("click",function(){
	    				if(!$("#regTitle").val()){
	    					alert("제목을 입력해 주세요")
	    					$("#regTitle").focus()
	    					return false;
	    				}else if(!$("#regContent").val()){
	    					alert("내용을 입력해 주세요")
	    					$("#content").focus()
	    					return false;
	    				}else if(!$("#regStartDate").val()){
	    					alert("시작날짜를 선택해 주세요")
	    					$("#regStartDate").focus()
	    					return false;
	    				}else if(!$("#regEndDate").val()){
	    					alert("종료날짜를 선택해 주세요");
	    					$("#regEndDate").focus()
	    					return false;
	    				}else if(!$("#regEventType").val()){
	    					alert("일정 종류를 선택해 주세요")
	    					return false;
	    				}else{
	    					calendar.addEvent({
	    						title :  $("#regTitle").val(),
	    						start: $("#regStartDate").val(),
	    						end: $("#regEndDate").val(),
	    						color : $("#regEventType").val()
	    					})
							
							var regContent = $("#regContent").val().replaceAll(/(?:\r\n|\r|\n)/g, '<br>'); //textarea enter 문제
							
		 					$.ajax({
								url:"/mypage/calendar/insert",
								type:"post",
								data : { "title" : $("#regTitle").val(),
										"content" : regContent,
										"start" :$("#regStartDate").val(),
										"end" : $("#regEndDate").val(),
										"color" : $("#regEventType").val()   
								},success:function(result){
									alert(result);
									location.reload(true)
								}
							});
	    					
	    				}
	    			});
	    		}
	   		},
	    	
	    },eventSources : [
	    	{
	    		googleCalendarId :'ko.south_korea#holiday@group.v.calendar.google.com',
	    		backgroundColor :'navy'
	    	}
	    ],eventClick : function(event){
	    	if(event.event._def.sourceId=='14'){
	    		event.jsEvent.preventDefault();  //구글 url 이동 막기
	    	}else{
	    		
	    		var idx =event.event._def.extendedProps.statusIdx //배열 순번에 따라 조회 
	    		
	    		$("#readModalBtn").click();
	    		
	    		$("#readIdx").val(event.event._context.options.events[idx].idx)
	    		$("#readTitle").val(event.event._context.options.events[idx].title)
	    		$("#readContent").val(event.event._context.options.events[idx].content.split('<br>').join("\r\n")) //br --> enter로 변환
	    		$("#readWriter").val(event.event._context.options.events[idx].writer)
	    		$("#readStartDate").val(event.event._context.options.events[idx].start)
	    		$("#readEndDate").val(event.event._context.options.events[idx].end)
	    		$("#readEventType").val(event.event._context.options.events[idx].color)
	    		
	    		$("#modEventBtn").unbind("click").bind("click",modCalendarFunc)	//수정 버튼 클릭 : 수정 함수 호출  .이벤트 버블링 방지
	    		$("#delEventBtn").unbind("click").bind("click",delCalendarFunc)  //삭제 버튼 클릭 : 삭제 함수 호출  .이벤트 버블링 방지
	    														
	    	}
    	
	    }, events : [
	    	<c:forEach var='list' items='${calendarList}'  varStatus='status'>
	   			{	"statusIdx" : '${status.index}',
	   				"idx" : '${list.idx}',
	   				"title" : '${list.title}',
	   				"content" : '${list.content}',
	   				"writer" : '${list.writer}',
	   				"start" : '${list.start}',
	   				"end"   : '${list.end}',
	   				"color" : '${list.color}'
	   			}, 	
	    	</c:forEach>
	    	
	    ], 
	    editable:false, //드래그 수정 방지
	    displayEventTime: true //시간 있음
	  });
	  calendar.render();
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
			localStorage.clear()
			location.href="/member/logout"
		}
	}
	 //1초식 감소
	var setinterval = setInterval(timer,1000);
	
});




</script>
</html>