<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	/* border:1px solid #ddd; */
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
<body style="color:#fff">
	<div class="box">
		<p class="msg">데이터를 처리 하는 과정에서 문제가 발생하였습니다.</p>
		<p class="msg">관리자에게 문의하여 주십시오.</p>
		<p class="gongbooz">GongBooZ</p>

	</div>

	<h4>${exception.getMessage()}</h4>
	<ul>
		<c:forEach items="${exception.getStackTrace()}" var="stack">
			<li>${stack.toString()}</li>
		</c:forEach>
	</ul>
</body>
</html>