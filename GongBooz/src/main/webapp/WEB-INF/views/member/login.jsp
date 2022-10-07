<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="${path}/resources/css/member/login.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>로그인</title>
<style>
@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf") format('opentype');
}
</style>
</head>
<body>
	<c:if test="${member.userid != null}">
		<script>
			location.href = "${pageContext.request.contextPath}/member/myinfo.do";
		</script>
	</c:if>

	<div id="login">
	<form name='homeForm' method="post" action="loginOk.do">
		<c:if test="${member == null}">
			<div class="logo">
	        <p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p> 
			</div>
			<div>
				<label for="userId"></label>
				<input type="text" id="userId" name="userid" class="box" value="minhee123" >
			</div>
			<div>
				<label for="userPass"></label>
				<input type="password" id="userPass" name="userpass" class="box" value="rfpwrymwfzjo" >
			</div>
			<div>
				<button type="submit" class="btn">로그인</button>
			</div>
			<c:if test="${msg == false}">
			<p style="color: white;"> 아이디와 비밀번호 확인해주세요.</p>
		</c:if> 
		
		<hr>
		
		<div class="join">
			<a href="findPw.do">아이디 / 비밀번호 찾기</a>  
		</div>
		<div class="join">
			<a href="join.do">회원가입</a>  
		</div>
		</c:if>

	</form>
</div>
</body>
</html>
