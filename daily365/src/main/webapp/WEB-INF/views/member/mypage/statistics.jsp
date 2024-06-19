<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Statistics</title>
<style type="text/css">
canvas{
	width: 555px;
	display: inline;
	float: left;
	margin-bottom: 100px;
}
footer{
	clear: both;
	padding: 30px;
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
<body class="container">
<nav class="navbar navbar-expand-lg bg-body-tertiary bg-dark">
  <div class="container">
    <a class="navbar-brand" href="#">Statistics</a>
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
	<br><br><br><br>

<canvas id="chart3"  ></canvas>
<canvas id="chart4"  ></canvas>
<canvas id="chart5"  ></canvas>	
<canvas id="chart6"  ></canvas>	


<footer class="bg-dark ">
	<p class="m-0 text-center text-white">@Copyright : TaeHa-Hwang</p>
</footer>
</body>

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- bootStrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- chart.js -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 차트를 그럴 영역을 dom요소로 가져온다.
	var chartArea3 = document.getElementById('chart3').getContext('2d');
	var chartArea4 = document.getElementById('chart4').getContext('2d');
	var chartArea5 = document.getElementById('chart5').getContext('2d');
	var chartArea6 = document.getElementById('chart6').getContext('2d');
		
	var chart3Label =[]
	var chart3Data=[]
	
	<c:forEach var="chart3" items="${chart3List }">
		chart3Label.push('${chart3.regTimeChart}')
		chart3Data.push(${chart3.regDateChart })
	</c:forEach>
	
	var chart3 = new Chart(chartArea3, {
	    type: 'bar',
	    data: {
	        labels: chart3Label,
	        datasets: [{
	            label: '시간대별 게시글 작성 횟수',
	            data: chart3Data,
	            backgroundColor:[ 'rgb(255, 99, 132)',
      						 'rgb(255, 159, 64)',
      						 'rgb(255, 205, 86)',
      						 'rgb(75, 192, 192',
      						 'rgb(54, 162, 235)',
      						 'rgb(153, 102, 255)',
      						 'rgb(201, 203, 207)'
      			],borderColor: [
			      'rgb(255, 99, 132)',
			      'rgb(255, 159, 64)',
			      'rgb(255, 205, 86)',
			      'rgb(75, 192, 192)',
			      'rgb(54, 162, 235)',
			      'rgb(153, 102, 255)',
			      'rgb(201, 203, 207)'
			    ],
	            borderWidth: 1
	        }]
	    },options : {
	    	responsive : false
	    }
	});	
	
	var chart4Data1 = []
	var chart4Data2 = []
	
		<c:forEach var="chart4" items="${chart4List }">
			chart4Data1.push(${chart4.totalLikeChart})
			chart4Data2.push(${chart4.totalReportChart})
		</c:forEach>
	
	var chart4 = new Chart(chartArea4, {
	    type: 'bar',
	    data: {
	        datasets: [
		        {
		            label: '긍정 평가',
		            data: chart4Data1,
		            backgroundColor: '#00C7E2',
		            borderColor: 'rgba(255, 99, 132, 1)',
		            borderWidth: 1
		        },
	         	{
		            label: '부정 평가',
		            data: chart4Data2,
		            backgroundColor: '#FF7DA8',
		            borderColor: 'rgba(255, 99, 132, 1)',
		            borderWidth: 1
		        },
	        
	        ]
	    },options: {
			responsive: false,
			scales: {
				yAxes: [{
					ticks: {
						min: 0,
						max: 20,
						fontSize : 14
					}
				}]
			}
		}
	});
	
	
	
	var chart5Label=[]	
	var chart5Data=[]
	var chart5Color=[]
		
	<c:forEach var="chart5" items="${chart5List }">
		chart5Label.push('${chart5.colorChart}')
		chart5Data.push(${chart5.calendarChart })
		chart5Color.push('${chart5.color}')
	</c:forEach>
	
	var chart5 = new Chart(chartArea5, {
	    type: 'doughnut',
	    data: {
	        labels: chart5Label,
	        datasets: [{
	            label: '일정 분류에 따른 통계',
	            data: chart5Data,
	            backgroundColor: chart5Color,
     			hoverOffset: 4,				 
	            borderColor: 'rgba(255, 99, 132, 1)',
	            borderWidth: 1
        	}]
        },options : {
	    	responsive : false
	    }
	    
	});
	
	var chart6Lable =[]
	var chart6Data1 =[]
	var chart6Data2 =[]
	
	<c:forEach var="chart6" items="${chart6List}">
		chart6Lable.push("${chart6.yearChart}-${chart6.monthChart}")
		chart6Data1.push(${chart6.bnoChart})
		chart6Data2.push(${chart6.hitChart})
	</c:forEach>
	
	var chart6 = new Chart(chartArea6, {
		type: 'line',
		 data : {
		  labels: chart6Lable,
		  datasets: [{
		    order:1,
		    label: '게시글 수',
		    data: chart6Data1,
		    fill: false,
		    borderColor: 'rgb(255, 99, 132)'
		  }, {
		    order:2,
		    label: '조회수',
		    data: chart6Data2,
		    fill: false,
		    borderColor: 'rgb(54, 162, 235)'
		  }]
	 	},options : {
	    	responsive : false
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