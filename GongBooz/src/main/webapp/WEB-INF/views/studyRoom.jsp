<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<style>
@font-face {
	font-family: 'ChosunSg';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/ChosunSg.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

p {
	font-family: 'ChosunSg';
	color: white;
	display: inline-block;
	text-weight: 900;
	font-size: 18px;
}

#roomName {
	background-color: #E66E00;
	text-weight:
}

#text {
	margin-left: 100px;
}

#btn {
	border: none;
	font-size: 18px;
	background-color: #3c3a3a;
	border-radius: 4px;
	color: #fff;
}

#btn:hover {
	background-color: #4C4C4C;
}

.boardBtn {
	/* border: 1px solid gray; */
	font-size: 18px;
	/* background: none; */
	border-radius: 4px;
	color: #fff;
	padding-right: 10px;
	padding-left: 10px;
	margin-bottom: 10px;
	margin-top: 10px;
	border: none;
	background-color: #3c3a3a;
}

.boardBtn:hover {
	/* background-color: #fff; */
	background-color: #4C4C4C;
	/* color: black; */
	color:#fff;
	border: none;
}
</style>
<meta charset="UTF-8">
<title>스터디룸</title>
</head>
<% request.setCharacterEncoding("UTF-8");%>
<body>
	<div id="text">
		<p id="roomName">
			${studyVO.sno}. ${studyVO.study_tag} 스터디룸
			(${studyVO.study_name})</p><p>&nbsp;에 오신걸 환영합니다.
		</p><br>
		<p>
			현재 참여 인원: ${studyVO.cur_number} 명/ 정원 : ${studyVO.max_number} 명 (개설자 : ${studyVO.open_id})
		</p>
		<form name="you_out" >
		 	 <c:set value="${studyVO.study_member}" var="memberBea"/>
			 <p>등록멤버 :
			 <select name="study_member" style="border-radius:3px;background-color:transparent;color:#fff;height:30px;width:100px;">
				 <c:forEach items="${fn:split(memberBea,'/')}" var="list" varStatus="status">
					<option value="${list}" style="color:black;">
						${list}
					</option>
				</c:forEach> 
			 </select>
			 <c:if test="${studyVO.open_id == member.userid}">
			 	<button type="submit" class="youOut_btn" id="btn" >강퇴</button>&nbsp;&nbsp;&nbsp;${member.username}님은 개설자 이십니다.
				<c:if test = "${memberBea == null}">
					(등록멤버가 아직 없습니다.)
				</c:if>
				 <input type="hidden" value="${studyVO.sno}" name="sno"/>
			 	<input type="hidden" value="${member.userid}" name="user_id"/>
			 </c:if>
			 </p>	 
		</form>
	 	<!--등록 멤버의 경우 탈퇴를 할 수 있다.  -->
		<form name="study_out">
			<c:set value="${studyVO.study_member}" var="memberBea"/>
			<c:forEach items="${fn:split(memberBea,'/')}" var="list" varStatus="status">
			 	<c:if test = "${list ==  member.userid}">
					<button type="submit" class="btn_out" id="btn">탈퇴</button>
				</c:if> 
			</c:forEach> 
			<input type="hidden" value="${studyVO.sno}" name="sno"/>
			<input type="hidden" value="${member.userid}" name="study_member"/> 
			<input type="hidden" value="${member.userid}" name="user_id"/>
		</form>
		
		<c:choose>
			<c:when test = "${studyVO.study_tag eq '외국어'}">
				<c:set var="title1" value="l${studyVO.sno}" />
			</c:when>
			<c:when test = "${studyVO.study_tag eq '면접'}">
				<c:set var="title1" value="i${studyVO.sno}" />
			</c:when>
			<c:when test = "${studyVO.study_tag eq '스터디윗미'}">
				<c:set var="title1" value="s${studyVO.sno}" />
			</c:when>
			<c:when test = "${studyVO.study_tag eq '대외활동'}">
				<c:set var="title1" value="a${studyVO.sno}" />
			</c:when>
			<c:when test = "${studyVO.study_tag eq '자격증'}">
				<c:set var="title1" value="c${studyVO.sno}" />
			</c:when>
			<c:when test = "${studyVO.study_tag eq '공무원'}">
				<c:set var="title1" value="p${studyVO.sno}" />
			</c:when>
			<c:when test = "${studyVO.study_tag eq '기타'}">
				<c:set var="title1" value="e${studyVO.sno}" />
			</c:when>
		</c:choose>
		 <form name="enterBoard" action="board/boardList.do" method="get">
			<button type="submit" class="boardBtn" id="board">${studyVO.study_name} 게시판 으로 가기(${studyVO.sno}번방) ▶</button>
			<input type="hidden" value="${title1}" name="board_name">
		 </form> 
		 
	</div>
	
<%@ include file="chat.jsp" %>

</body>
</html>
<script type="text/javascript">
		
		$(document).ready(function(){
			var formObj = $("form[name='study_out']");
			// 탈퇴
			$(".btn_out").on("click", function(){
				
				var deleteYN = confirm("탈퇴 하시겠습니까?");
				if(deleteYN == true){
				
					formObj.attr("action", "outStudy.do");
					formObj.attr("method", "post");
					formObj.submit();
				
				}
			})
		
		})
		//강퇴
		$(document).ready(function(){
			var formObj = $("form[name='you_out']");
			// 강퇴
			$(".youOut_btn").on("click", function(){
				
				var outYN = confirm("강퇴시키겠습니까??");
				if(outYN == true){
				
					formObj.attr("action", "outStudy.do");
					formObj.attr("method", "post");
					formObj.submit();
				
				}
			})
		
		})
		
	
		
		
	</script>