<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"	/>
<link rel="stylesheet" href="resources/css/main.css"></link> <!-- css -->
<link rel="shortcut icon" href="#"> <!-- favicon 오류용 -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script>
	$(document).ready(function(){
		$("#header").load("./include/gbHeader.jsp"); //헤더html 적용
		$("#footer").load("./include/gbFooter.jsp"); //풋터html 적용		
	});

</script>
<title>GongBooZ</title>
</head>
<body>
	<div id="header"></div> <!-- header 삽입부 -->
	<hr>
	
	<!-- 노란밑줄들은 테두리 없애는 속성 + 스크롤 삭제 -->
	<iframe id="mainifr" width="100%"	
	frameborder=0 framespacing=0 marginheight=0 marginwidth=0 vspace=0
	src="gbMusic.jsp"></iframe>

	<div id="footer"></div> <!-- footer 삽입부 -->
</body>
</html>

<!-- 탭을 누르면 iframe에 소스를 변경하도록 명령 -->