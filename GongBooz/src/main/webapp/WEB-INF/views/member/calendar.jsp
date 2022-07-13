<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href='${pageContext.request.contextPath}/resources/fullcalendar/main.css' rel='stylesheet' />
    <script src='${pageContext.request.contextPath}/resources/fullcalendar/main.js'></script>
    <script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          googleCalendarApiKey: 'AIzaSyAo_lknaQtrqzHbvRGYxYkVAys07lLWu-c',
          events: {
            googleCalendarId: 'b0dp00003s6p9fd2hmoi65g6i8@group.calendar.google.com',
            className: 'gcal-event' // an option!
          },
          eventClick: function(info){
        	  info.jsEvent.stopPropagation();
        	  info.jsEvent.preventDefault();
          }
        });
        calendar.render();
      });

    </script>
<style>
@font-face {
    font-family: 'ChosunSg';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/ChosunSg.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
	
	*{			font-family: 'ChosunSg';
				margin:0;
				padding:0;
			}
	
	
	#calWrap{
		width:730px;
		   background-color:#F7F7F7;  
		/* margin:300px auto; */
		/* color:black; */
		border:1px solid #ffffff;
		/* margin-left:30px; */
		
		 box-shadow:  2px 5px 16px 0px, 5px 5px 15px 5px rgba(0,0,0,0);
			       border-radius:4px;
	}
	
	#calendar{
		width:700px;
		margin:0px auto;
		padding-top: 30px;
		padding-left: 40px;
		padding-right: 40px;
		 padding-bottom:70px; 
	}
	h2{
		margin-left:70px;
		padding-top:40px;
		
	}

</style>
</head>
<body>
 <div id="calWrap">
 	<h2>주요기업 취업일정 공고</h2>
 	<div id='calendar'>
 	
 </div>
</div>
 

</body>
</html>