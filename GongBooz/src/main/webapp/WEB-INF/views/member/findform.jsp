<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${path}/resources/css/member/findform.css" rel="stylesheet"/>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf")
		format('opentype');
}
</style>
<title>아이디/비밀번호 찾기</title>
</head>
<body>


<div id="findWrap">
		<div class="findpw" >
			
			<div class="logo">
	        <p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p> 
			</div>
			
			<div class="w3-center w3-large w3-margin-top">
				<p class="welcome">비밀번호 찾기</p>
			</div>
			<div>
				<p>
					<label>ID</label><br>
					<input class="input" type="text" id="id" name="userid" required>
				</p>
				<p>
					<label>Email</label><br>
					<input class="input" type="text" id="email" name="membermail" required>
				</p>
				<p class="w3-center">
					<button type="button" id=findpwBtn class="btn">find</button><br>
					<button type="button" onclick="history.go(-1);" class="btn1">Cancel</button>
				</p>
			</div>
		</div>
		<div class="findid" >
			<div class="logo">
	        <p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p> 
			</div>
			<form action="find_id.do" method="post">
				<div class="w3-center w3-large w3-margin-top">
					<p class="welcome">아이디 찾기</p>
				</div>
				<div>
					
					<p>
						<label>Email</label><br>
						<input class="input" type="text" id="email" name="membermail" required>
					</p>
					<p class="w3-center">
						<button type="submit" id=findidBtn class="btn">find</button><br>
						<button type="button" onclick="history.go(-1);" class="btn1">Cancel</button>
					</p>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	$(function(){
		$("#findpwBtn").click(function(){
			$.ajax({
				url : "find_pw.do",
				type : "POST",
				data : {
					userid : $("#id").val(),
					membermail : $("#email").val()
				},
				success : function(result) {
					alert(result);
				},
			})
		});
	})
</script>
</html>
