<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link href="${path}/resources/css/member/find_id.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>아이디 검색결과</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf")
		format('opentype');
}

</style>

<script>
	$(function(){
		$("#loginBtn").click(function(){
			 location.href='${pageContext.request.contextPath}/member/login.do'; 
		})
	})
</script>
</head>
<body>
<div id="findWrap">
		<div class="findid">
			<div class="logo">
	       <p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p> 
			</div>
			<div class="w3-center w3-large w3-margin-top">
				<p class="welcome">아이디 찾기 검색결과</p>
			</div>
			<div>
				<c:forEach items="${array}" var = "list">
				<h5>${list.userid}</h5>
				</c:forEach>
				<p class="w3-center">
					<button type="button" id=loginBtn class="btn">Login</button>
					<button type="button" onclick="history.go(-1);" class="btn1">Cancel</button>
				</p>
			</div>
		</div>
	</div>
</body>
</html>