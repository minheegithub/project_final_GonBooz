<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link href="${path}/resources/css/member/memberUpdate.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>회원정보수정</title>
<style>
@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf")
		format('opentype');
}
</style>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
	<script type="text/javascript">
		$(document).ready(function() {
			// 취소
			$(".cencle").on("click", function() {

				var userid = $("#cancel").val();
				location.href = "myinfo.do?userid=" + userid;

			})

			$("#submit").on("click", function() {
				if ($("#userPass").val() == "") {
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				if ($("#newpass").val() == "") {
					alert("새 비밀번호를 입력해주세요.");
					$("#newpass").focus();
					return false;
				}
				if ($("#userName").val() == "") {
					alert("성명을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				if ($("#membermail").val() == "") {
					alert("이메일을 입력해주세요.");
					$("#membermail").focus();
					return false;
				}
				$.ajax({
					url : "passChk.do",
					type : "POST",
					dateType : "json",
					data : $("#updateForm").serializeArray(),
					success : function(data) {

						if (data == 0) {
							alert("패스워드가 틀렸습니다.");
							return;
						} else {
							if (confirm("회원수정하시겠습니까?")) {
								$("#updateForm").submit();
							}

						}

					}
				})//ajax 
			});

		})
	</script>
<body>

	<c:if test="${member.userid == null}">
				<script>
					location.href="${pageContext.request.contextPath}/member/login.do";
				</script>
	</c:if>
	
	<!-- <section id="container"> -->
		 <div class="joinWrap"> 
			
		<div class="join">
			<p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p> 
			
			<p class="welcome">회원정보수정<br><br>새 비밀번호를 입력하세요<p>	
			
			<form action="memberUpdate.do" method="post" id="updateForm">
				
				<table class="table">
					<tr>
						<th style="border-bottom:1px solid #fff;padding-bottom:17px;">
						<label class="control-label" for="userId">ID</label>
						</th>
						<td style="border-bottom:1px solid #fff;padding-bottom:17px;">
							${member.userid}
							<input type="hidden" value="${member.userid}" name="userid">
							
						</td>
					</tr>
					<tr>
						<th>
						<label class="control-label" for="userPass">Password</label>
						</th>
						<td>
						<input class="form-control" type="password" id="userpass" name="userpass" placeholder="현재 비밀번호를 입력하세요"/> 
						</td>
					</tr>
					<tr>
						<th>
						<label class="control-label" for="userPass">Password</label>
						</th>
						<td>
						<input class="form-control" type="password" id="newpass" name="newpass" placeholder="새 비밀번호를 입력하세요"/> 
						</td>
					</tr>
					<tr>
						<th>
						<label class="control-label" for="userName">NAME</label>
						</th>
						<td>
						<input class="form-control" type="text" id="username" name="username" value="${member.username}"/>
						</td>
					</tr>
					<tr>
						<th>
						<label class="control-label" for="userName">EMAIL</label>
						</th>
						<td>
						<input class="form-control" type="text" id="membermail" name="membermail" value="${member.membermail}"/>
						</td>
					</tr>
				
				</table>
			</form>
				<div class="form-group has-feedback">
					<button class="btn btn-success" type="submit" id="submit">회원정보수정</button>
					<button class="cencle btn btn-danger" type="button" value="${member.userid}" id="cancel">취소</button>
				</div>
		</div>
	 </div> 
</body>
</html>