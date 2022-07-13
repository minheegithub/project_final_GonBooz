<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="${path}/resources/css/member/memberDelete.css" rel="stylesheet"/>
<title>회원탈퇴</title>
</head>
<style>
@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf") format('opentype');
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		// 취소
		$("#cancel").on("click", function() {
			var userid = $("#cancel").val();
			location.href = "myinfo.do?userid=" + userid;

		})

		$("#submit").on("click", function() {
			if ($("#userPass").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				return false;
			}

			if (confirm("회원탈퇴하시겠습니까?")) {
				$("#delForm").submit();
			}
		});
	})
</script>

<body>
	<c:if test="${member.userid == null}">
								<script>
									location.href = "${pageContext.request.contextPath}/member/login.do";
								</script>
	</c:if> 


	<div class="joinWrap"> 
			
		<div class="join">
	<p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p> 
			<h4 class="Q">${member.username}님 회원탈퇴하시겠습니까?</h4>
			<p class="Q">비밀번호를 입력하세요<p>
		<!-- <section id="container"> -->
			<form action="memberDelete.do" method="post" id="delForm">
				
				<table class="table">
					<tr>
						 <th class="first"><label for="id">아이디</label></th>
						<td>
							${member.userid}
						</td>
					</tr>
					<tr>
						 <th class="last"><label for="pw" >비밀번호</label></th>
						<td>
						<input class="pw" type="password" id="userPass" name="userpass" placeholder="            비밀번호를 입력하세요" />
						</td>
					</tr>
				</table>
				
				<%--  <div class="form-group has-feedback">
					<label class="control-label" for="userId">ID</label>
					<input class="form-control" type="text" id="userId" name="userid" value="${member.userid}" readonly="readonly"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">Password</label>
					<input class="form-control" type="password" id="userPass" name="userpass" placeholder="비밀번호를 입력" />
				</div> --%>
			<%-- 	<div class="form-group has-feedback">
					<label class="control-label" for="userName">Name</label>
					<input class="form-control" type="text" id="userName" name="username" value="${member.username}" readonly="readonly"/>
				</div>  --%>
				
			
			</form>
			<div class="form-group has-feedback">
				<!-- <button class="btn btn-success" type="button" id="submit">회원탈퇴</button> -->
				<button class="btn" type="button" id="submit">회원탈퇴</button>
				<!-- <button class="cencle btn btn-danger" type="button">취소</button> -->
				<button class="btn" type="button" id="cancel" value="${member.userid}">취소</button>
			</div>
			<div class="message">
				<c:if test="${msg == false}">
					비밀번호가 맞지 않습니다.
				</c:if>
			</div>
		<!-- </section> -->
	</div>
	 </div> 
</body>
</html>