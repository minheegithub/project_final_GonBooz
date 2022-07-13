<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link href="${path}/resources/css/member/myinfo.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Link Swiper's CSS -->
<link	rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"	/>
<script type="text/javascript">
	$(document).ready(function(){
	
		$("#memberUpdateBtn").on("click", function(){
			location.href="${pageContext.request.contextPath}/member/memberUpdateView.do";
		})
		
	})
</script>
<style>
@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf")
		format('opentype');
}
</style>


</head>
<body  >
	<c:if test="${member.userid == null}">
		<script>
			location.href = "${pageContext.request.contextPath}/member/login.do";
		</script>
	</c:if>

	<c:if test="${member != null}">
		<div id="wrap">
		<aside >
			 <%@ include file="./calendar.jsp" %>	 
		</aside>	
		<section>
			<div class="myinfoWrap">
				<div class="myinfo">
					<div class="logo">
				        <p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p> 
					</div>
					<p class="welcome">${member.username}님 안녕하세요.</p>
					<table class="modifyTable">
				        <tr>
				            <th class="first"><label for="id">아이디</label></th>
				            <td class="first">
				            ${member.userid}
				        	</td>
				        </tr>
				        <tr>
				            <th><label for="date">가입날짜</label></th>
				            <td>
				            	<fmt:formatDate value="${member.regdate}" pattern="yyyy-MM-dd HH:MM"/>
				        	 </td>
				        </tr>
				        <tr>
				            <th class="last"><label for="phone1" >이메일</label></th>
				            <td class="last">
				            	${member.membermail}
				        	 </td>
				        </tr>
					</table>
					<div class="myinfobottom">
							<a href="${pageContext.request.contextPath}/member/memberUpdateView.do"
								style="color: #ffffff;">회원정보수정 </a>/ 
							<a href="${pageContext.request.contextPath}/member/memberDeleteView.do"
							style="color: #ffffff;">회원탈퇴</a>
					</div>
				</div>
			</div>
		</section>
		</div>
		</c:if>
</body>
</html>