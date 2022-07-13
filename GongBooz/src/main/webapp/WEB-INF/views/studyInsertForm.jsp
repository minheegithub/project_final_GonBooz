<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link href="${path}/resources/css/studyroomMain.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>스터디 등록</title>
</head>
<body>	
	
		<!--header title  -->
		<div class="modal-header">
			<h5 class="modal-title" id="insertModalLabel">스터디 등록</h5>
			<button class="close" type="button" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">✖</span>
			</button>
		</div>
		<!--body  -->
		<div class="modal-body" style="text-align:left;">
			<form action="studyInsert.do" method="get">
		
			<input type="hidden" value="${member.userid}" name="open_id"/>
			<%-- <input type="hidden" value="${member.userid}" name="study_member"/>  --%>
			✔스터디 이름 &nbsp;&nbsp;&nbsp;<input type="text" name="study_name" required><p></p>
			✔스터디 종류&nbsp;&nbsp;&nbsp;<select name="study_tag" required>
				<option value="외국어">외국어</option>
				<option value="면접">면접</option>
				<option value="스터디윗미">스터디윗미</option>
				<option value="대외활동">대외활동</option>
				<option value="자격증">자격증</option>
				<option value="공무원">공무원</option>
				<option value="기타">기타</option>
				</select>
			<p></p>
			✔오프라인 모임 장소&nbsp;&nbsp;&nbsp; <input type="text" name="region" required>
			<p></p>
			✔정원&nbsp;&nbsp;&nbsp; <input type="text" name="max_number" required><br></br>
			<input type="hidden" value="${swiper}" name="swiper"/> 
			
			<input type="submit" value="등록하기" id="plus">
		</form>
	</div>
	<div class="modal-footer">
		-GongBooz-
	</div>	
</body>
</html>