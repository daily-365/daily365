<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
</head>
<meta charset="UTF-8">
<title>마이페이지 메인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="container-fluid">
<nav class="navbar navbar-dark bg-dark fixed-top">
 <div class="container-fluid">
	<button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon "></span>
    </button>
    <a class="navbar-brand" href="#">Admin Page</a>
	<div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="offcanvasDarkNavbar" aria-labelledby="offcanvasDarkNavbarLabel">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasDarkNavbarLabel">Home</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
     </div>
     <div class="offcanvas-body">
        <ul class="navbar-nav justify-content-start flex-grow-1 pe-3">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#">Admin Main Page</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/">User Main Page</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
             	Management
            </a>
            <ul class="dropdown-menu dropdown-menu-dark">
              <li><a class="dropdown-item" href="#">회원정보관리</a></li>
              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" href="#">일정관리</a></li>
              <li><a class="dropdown-item" href="#">통계</a></li>
            </ul>
          </li>
        </ul>
        <form class="d-flex mt-3" role="search">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-success" type="submit">Search</button>
        </form>
      </div>
    </div>
  </div>
</nav>

</body>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>


<script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
// 차트를 그럴 영역을 dom요소로 가져온다.
var chartArea1 = document.getElementById('myChart1').getContext('2d');
var chartArea2 = document.getElementById('myChart2').getContext('2d');
var chartArea3 = document.getElementById('myChart3').getContext('2d');
// 차트를 생성한다. 
var myChart1 = new Chart(chartArea1, {
    // ①차트의 종류(String)
    type: 'bar',
    // ②차트의 데이터(Object)
    data: {
        // ③x축에 들어갈 이름들(Array)
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        // ④실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
        datasets: [{
            // ⑤dataset의 이름(String)
            label: '# of Votes',
            // ⑥dataset값(Array)
            data: [12, 19, 3, 5, 2, 3],
            // ⑦dataset의 배경색(rgba값을 String으로 표현)
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            // ⑧dataset의 선 색(rgba값을 String으로 표현)
            borderColor: 'rgba(255, 99, 132, 1)',
            // ⑨dataset의 선 두께(Number)
            borderWidth: 1
        }]
    },
    // ⑩차트의 설정(Object)
    options: {
        // ⑪축에 관한 설정(Object)
        scales: {
            // ⑫y축에 대한 설정(Object)
            y: {
                // ⑬시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
                beginAtZero: true
            }
        }
    }
});
// 차트를 생성한다. 
var myChart2 = new Chart(chartArea2, {
    // ①차트의 종류(String)
    type: 'line',
    // ②차트의 데이터(Object)
    data: {
        // ③x축에 들어갈 이름들(Array)
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        // ④실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
        datasets: [{
            // ⑤dataset의 이름(String)
            label: '# of Votes',
            // ⑥dataset값(Array)
            data: [12, 19, 3, 5, 2, 3],
            // ⑦dataset의 배경색(rgba값을 String으로 표현)
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            // ⑧dataset의 선 색(rgba값을 String으로 표현)
            borderColor: 'rgba(255, 99, 132, 1)',
            // ⑨dataset의 선 두께(Number)
            borderWidth: 1
        }]
    },
    // ⑩차트의 설정(Object)
    options: {
        // ⑪축에 관한 설정(Object)
        scales: {
            // ⑫y축에 대한 설정(Object)
            y: {
                // ⑬시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
                beginAtZero: true
            }
        }
    }
});
// 차트를 생성한다. 
var myChart3 = new Chart(chartArea3, {
    // ①차트의 종류(String)
    type: 'pie',
    // ②차트의 데이터(Object)
    data: {
        // ③x축에 들어갈 이름들(Array)
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        // ④실제 차트에 표시할 데이터들(Array), dataset객체들을 담고 있다.
        datasets: [{
            // ⑤dataset의 이름(String)
            label: '# of Votes',
            // ⑥dataset값(Array)
            data: [12, 19, 3, 5, 2, 3],
            // ⑦dataset의 배경색(rgba값을 String으로 표현)
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            // ⑧dataset의 선 색(rgba값을 String으로 표현)
            borderColor: 'rgba(255, 99, 132, 1)',
            // ⑨dataset의 선 두께(Number)
            borderWidth: 1
        }]
    },
    // ⑩차트의 설정(Object)
    options: {
        // ⑪축에 관한 설정(Object)
        scales: {
            // ⑫y축에 대한 설정(Object)
            y: {
                // ⑬시작을 0부터 하게끔 설정(최소값이 0보다 크더라도)(boolean)
                beginAtZero: true
            }
        }
    }
});

 (function(){    $(function(){      
 // calendar element 취득      
 var calendarEl = $('#calendar')[0];      
 // full-calendar 생성하기      
 var calendar = new FullCalendar.Calendar(calendarEl, {        
 height: '700px', 
 // calendar 높이 설정        
 expandRows: true, 
 // 화면에 맞게 높이 재설정       
 slotMinTime: '08:00', 
 // Day 캘린더에서 시작 시간        
 slotMaxTime: '20:00', 
 // Day 캘린더에서 종료 시간       
// 해더에 표시할 툴바       
 headerToolbar: {          
 left: 'prev,next today',          
 center: 'title',          
 right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'        },        
 initialView: 'dayGridMonth', 
 // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)        
 initialDate: '2021-07-15', 
 // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)        
 navLinks: true, 
 // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크        
 editable: true, 
 // 수정 가능?        
 selectable: true, 
 // 달력 일자 드래그 설정가능        
 nowIndicator: true, 
 // 현재 시간 마크        
 dayMaxEvents: true, 
 // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)        
 locale: 'ko', 
 // 한국어 설정        
 eventAdd: function(obj) { 
 // 이벤트가 추가되면 발생하는 이벤트         
  console.log(obj);        },        
  eventChange: function(obj) { 
  // 이벤트가 수정되면 발생하는 이벤트          
  console.log(obj);        },        
  eventRemove: function(obj){ 
  // 이벤트가 삭제되면 발생하는 이벤트          
  console.log(obj);        },        
  select: function(arg) { 
  // 캘린더에서 드래그로 이벤트를 생성할 수 있다.          
  var title = prompt('Event Title:');         
   if (title) {            
   calendar.addEvent({              
   title: title,              
   start: arg.start,              
   end: arg.end,              
   allDay: arg.allDay            
   })          
   }          
   calendar.unselect()       
},        // 이벤트         
events: [          {            
title: 'All Day Event',            
start: '2021-07-01',          },          
{            
title: 'Long Event',            
start: '2021-07-07',            
end: '2021-07-10'          },          
{            
groupId: 999,            
title: 'Repeating Event',            
start: '2021-07-09T16:00:00'          },          
{            
groupId: 999,            
title: 'Repeating Event',            
start: '2021-07-16T16:00:00'          },          
{            
title: 'Conference',            
start: '2021-07-11',            
end: '2021-07-13'          },          
{            
title: 'Meeting',            
start: '2021-07-12T10:30:00',            
end: '2021-07-12T12:30:00'          },          
{            
title: 'Lunch',            
start: '2021-07-12T12:00:00'          },          
{            
title: 'Meeting',            
start: '2021-07-12T14:30:00'          },          
{            
title: 'Happy Hour',            
start: '2021-07-12T17:30:00'          },          
{            
title: 'Dinner',            
start: '2021-07-12T20:00:00'          },          
{            
title: 'Birthday Party',            
start: '2021-07-13T07:00:00'          },          
{            
title: 'Click for Google',            
url: 'http://google.com/', 
// 클릭시 해당 url로 이동           
 start: '2021-07-28'          
 }        
 ]      
 });      
 // 캘린더 랜더링      
 calendar.render();    
 });  
 })();
</script>
</html>