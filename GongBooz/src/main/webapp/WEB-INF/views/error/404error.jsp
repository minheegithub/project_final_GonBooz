<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.box {
	margin: 40px auto; /*가로너비*/
	width: 440px; /*높이만큼 늘어남*/
	overflow: hidden; /*배경색상*/
	/*안쪽여백*/
	padding: 30px;
	padding-top: 50px;
	padding-bottom: 30px;
	/*글자의 정렬*/
	text-align: center; /*box안에 인라인 요소들 가운데 정렬?  */
	border-radius: 4px;
	color: black;
	background-color: rgba(255, 255, 255, 0.5);
	box-shadow: 2px 5px 16px 0px, 5px 5px 15px 5px rgba(0, 0, 0, 0);
}

@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf")
		format('opentype');
}

.gongbooz {
	font-family: 'title', cursive;
	font-size: 20px;
	text-align: center;
}

.msg {
	font-weight: bold;
}
</style>

</head>
<body>
	<div class="box">
		<p class="msg">죄송합니다.</p>
		<p class="msg">요청하신페이지를 찾을 수 없습니다.</p>
		<p class="gongbooz">GongBooZ</p>
	</div>
</body>
</html>