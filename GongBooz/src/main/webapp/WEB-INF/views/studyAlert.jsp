<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link href="${path}/resources/css/studyroomMain.css" rel="stylesheet"/>
<meta charset="UTF-8">
<%@ page import="java.net.URLEncoder" %>
<title>스터디 입장</title>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
<style>
@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf")
		format('opentype');
}

#name {
	color: white;
	margin: 0 auto;
	width: 200px;
	font-family: 'Poor Story', cursive;
}

#button {
	margin: 0 auto;
}

#guide {
	width: 670px;
	margin: 0px auto;
	padding-top: 70px;
	text-align: center;
}

#enter {
	backgroun-color: white;
	margin-top: 30px;
	width: 87px;
	height: 34px;
	border-radius: 5px;
	font-size: 19px;
	transition-duration: 0.4s;
	border: none;
}

#enter:hover {
	background-color: #E1E1E1;
}

.modal-body {
	border: 1px solid #ddd;
	border-radius: 4px;
	box-shadow: 2px 5px 16px 0px, 5px 5px 15px 5px rgba(0, 0, 0, 0);
	width: 700px;
	margin: 0 auto;
	padding-top: 100px;
	padding-bottom: 70px;
	padding-left: 30px;
	margin-top: 30px;
	text-align: center;
	font-family: 'Poor Story', cursive;
}

.gongbooz {
	color: #ffffff;
	margin-top: 70px;
	font-family: 'title', cursive;
	font-size: 40px;
}

.room_name {
	color: #fff;
	font-size: 21px;
	font-weight: bold;
	margin-bottom: 17px;
	font-family: 'Poor Story', cursive;
}

.img {
	width: 70px;
	margin-left: 300px;
}

.img img {
	display: block;
	width: 100%;
	border-radius: 3px;
}
</style>
<body>

		<!--header title  -->
		<div class="modal-header"" >
			<h5 style="color:white;margin-left: 47%;">스터디 참가</h5>
			<button class="close" type="button" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">✖</span>
			</button>
		</div>
		<div class="modal-body">
	
			
		<p class="room_name">${studyVO.sno}. ${studyVO.study_tag} 스터디룸<br><br>
		
		<${studyVO.study_name}>
		</p>
				<c:choose>
					<c:when test="${studyVO.study_tag eq '외국어'}">
						<div class="img">
						<img src="${pageContext.request.contextPath}/resources/img/l.png"/>
						</div>
					</c:when>
					<c:when test="${studyVO.study_tag eq '면접'}">
						<div class="img">
						<img src="${pageContext.request.contextPath}/resources/img/i.png"/>
						</div>
					</c:when>
					<c:when test="${studyVO.study_tag eq '스터디윗미'}">
						<div class="img">
						<img src="${pageContext.request.contextPath}/resources/img/s.png"/>
						</div>
					</c:when>
					<c:when test="${studyVO.study_tag eq '대외활동'}">
						<div class="img">
						<img src="${pageContext.request.contextPath}/resources/img/a.png"/>
						</div>
					</c:when>
					<c:when test="${studyVO.study_tag eq '자격증'}">
						<div class="img">
						<img src="${pageContext.request.contextPath}/resources/img/c.png"/>
						</div>
					</c:when>
					<c:when test="${studyVO.study_tag eq '공무원'}">
						<div class="img">
						<img src="${pageContext.request.contextPath}/resources/img/p.png"/>
						</div>
					</c:when>
					<c:when test="${studyVO.study_tag eq '기타'}">
						<div class="img">
						<img src="${pageContext.request.contextPath}/resources/img/e.png"/>
						</div>
					</c:when>
				</c:choose>
			<div id="name">									
		(현재 인원 ${studyVO.cur_number} / 정원 ${studyVO.max_number}) <br><br>
		
		개설자 : ${studyVO.open_id}<br>
		
		등록멤버 <br>
		
		<c:set value="${studyVO.study_member}" var="memberBea"/>
		
		 <c:forEach items="${fn:split(memberBea,'/')}" var="list" varStatus="status">
			
			<c:if test = "${list ==  member.userid}">
				<c:set value="${list}" var="existMember"/>
			</c:if>
				${list}<br>
		</c:forEach> 
			<c:if test = "${memberBea == null}">
				(등록멤버가 아직  없습니다.)
			</c:if>
			</div>
			
		<div id = "guide">
			
			<c:choose>
				<c:when test="${member.userid == studyVO.open_id}">
					<span style="color:white">${member.username}님은 개설자이십니다. 입장하세요</span>
					<form name="enterRoom" action="enterRoom.do" method="post">
						<button type="submit" class="enterBtn"  id="enter" >입장하기</button>
						<input type="hidden" value="${studyVO.sno}" name="sno">
					</form>
				</c:when>
				<c:when test="${existMember eq null}">
					
					<c:if test="${studyVO.cur_number < studyVO.max_number}">
						<span style="color:white;"> ${member.userid}님 현재 "${studyVO.study_name}"등록 명단에 없습니다. 먼저 등록을 해주세요</span><br>
						<form id="button"name="enroll">
							<button type="submit" class="enrollBtn"  id="enter" >등록하기</button>
							<input type="hidden" value="${studyVO.sno}" name="sno">
							<input type="hidden" value="${member.userid}" name="study_member">
						</form>
					</c:if>
					
					<c:if test="${studyVO.cur_number >= studyVO.max_number}">
						<span style="color:white">정원이 찼습니다. 다른 스터디룸을 개설해보세요!</span>
					</c:if>
				</c:when>
				<c:otherwise>
					<form name="enterRoom" action="enterRoom.do" method="post">
						<span style="color:white">${member.userid}님 현재 "${studyVO.study_name}"의 맴버입니다. 입장하세요.</span><br>
						<button type="submit" class="enterBtn" id="enter">입장하기</button>
						<input type="hidden" value="${studyVO.sno}" name="sno">
					</form>
				</c:otherwise>
			</c:choose>
		<form action="studyAll.do" method="get">			
			<input type="submit" value="돌아가기" id="plus">
			<input type="hidden" value="y" name="swiper">
		</form>	
		</div>
		
		<p class="gongbooz">GongBooZ</p> 
	</div>

</body>
</html>

<script type="text/javascript">
		
		$(document).ready(function(){
			var formObj = $("form[name='enroll']");

			// 등록
			$(".enrollBtn").on("click", function(){
				
				var deleteYN = confirm("등록 하시겠습니까?");
				if(deleteYN == true){
				
					formObj.attr("action", "studyRoom.do");
					formObj.attr("method", "post");
					formObj.submit();
				
				}
			})
		
		})
	
		
	</script>