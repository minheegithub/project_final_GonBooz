<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	font-size: 18px;
	border-radius: 4px;
	color: #fff;
	padding-right: 10px;
	padding-left: 10px; *
	margin-bottom: 10px;
	margin-top: 10px; 
	border: none;
	background-color: #3c3a3a;
	margin-left:210px;
	
}

.boardBtn:hover {
	background-color: #4C4C4C;
	color:#fff;
	border: none;
}

/* 상하좌우 전부 안쪽 여백 주기 */
#root {
	padding: 20px;
	width: 900px;
	border-radius: 4px;
	 margin: 10px auto; 
	background: none;
	border: 1px solid #ddd;
}

.gongzi th {
	color: black;
	background-color: rgba(255, 255, 255, 0.5);
	text-align: center;
	
}

.gongzi th, .gongzi td {
	padding: 4px;
	font-size:12px;
}

/* 리스트 전체 가운데 정렬 */
.gongzi td {
	text-align: center;
	color:white;
}
#new {
	background-color: #FF7012;
	color: #fff;
	font-size: 1px;
}
table{
	margin: 1px auto;
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
 
	</div>
		<div id="root">
		 <form name="enterBoard" action="board/boardList.do" method="get">
			<button type="submit" class="boardBtn" id="board">+&nbsp;"${studyVO.study_name}" 게시판 으로 바로 가기&nbsp;[${studyVO.sno}번방]</button>
			<input type="hidden" value="${title1}" name="board_name">
		 </form> 
		<table class="gongzi">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>추천수</th>
				<th>조회수</th>
			</tr>
		 <c:forEach items="${gongziList}" var = "gzlist">
		 	<tr>
		 		<td style="border-bottom:1px solid #ddd;">
						<img src="${pageContext.request.contextPath}/resources/img/gongzi.png"/>&nbsp;
					</td>
					<td style="border-bottom:1px solid #ddd;width:440px;">
							${gzlist.title}
						<jsp:useBean id="toDay" class="java.util.Date" /> 
						<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd HH" var="today" />  
						<fmt:parseDate value="${today}" pattern="yyyy-MM-dd HH" var="today1" /> 
				 	    <fmt:parseNumber value="${today1.time / (1000*60*60)}" integerOnly="true" var="strDate"></fmt:parseNumber>
						<fmt:parseDate value="${gzlist.regdate}" pattern="yyyy-MM-dd HH" var="writeDay" /> 
				 	    <fmt:parseNumber value="${writeDay.time /(1000*60*60)}" integerOnly="true" var="writeDate"></fmt:parseNumber>
						<c:if test="${strDate - writeDate < 24}">
						&nbsp;<span id = "new">&nbsp;N&nbsp;</span>
						</c:if> 
					</td>
					<td style="border-bottom:1px solid #ddd;">${gzlist.writer}</td>
					<td style="border-bottom:1px solid #ddd;"><fmt:formatDate value="${gzlist.regdate}" pattern="yyyy-MM-dd" /></td>
					<td style="border-bottom:1px solid #ddd;">-</td>
					<td style="border-bottom:1px solid #ddd;">${gzlist.hit}</td>
		 	</tr>
		 </c:forEach>
		 <c:forEach items="${getThreeList}" var = "list">
			 <tr>
				<!--글번호  -->
				<td ><c:out value="${list.bno}"/></td>
				<!--글제목  -->
				<td class="tit">
					<c:out value="${list.title}" /> 
					<!--댓글갯수  -->
					<c:if test="${list.recnt > 0}">
						<span class="rep"> (${list.recnt})</span>
					</c:if>  
					
					<!--24시간 new  -->
					<fmt:parseDate value="${list.regdate}" pattern="yyyy-MM-dd HH" var="writeDay" /> 
			 	    <fmt:parseNumber value="${writeDay.time /(1000*60*60)}" integerOnly="true" var="writeDate"></fmt:parseNumber>
					<c:if test="${strDate - writeDate < 24}">
					  &nbsp;<span id = "new">&nbsp;N&nbsp;</span>
					</c:if> 
					 <c:if test="${list.stored_file_name != 'n'}">
					<img src="${pageContext.request.contextPath}/resources/img/clip.png"/> <span style="font-size:1px;">첨부파일</span>
					 </c:if>
				</td>
				<!--글쓴이  -->
				<td><c:out value="${list.writer}" /></td>
				<!--날짜  -->
				<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd HH:MM" />
				</td>
				<!--추천수  -->
				<td><c:out value="${list.likecount}" /></td>
				<!--조회수  -->
				<td><c:out value="${list.hit}" /></td>
			</tr> 
		</c:forEach>
		<tr>
		<td><p>.........<p></td>
		</tr>
	</table>
		
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