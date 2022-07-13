<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>게시글 보기</title>
<link href="${pageContext.request.contextPath}/resources/css/board/gongziView.css" rel="stylesheet"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style>
@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf")
		format('opentype');
}
</style>
	
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

		<c:if test="${member.userid == null}">
				<script>
					location.href="${pageContext.request.contextPath}/member/login.do";
				</script>
		</c:if> 

	<div class="board_wrap">
			<p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p>
			<p class="board_name">|&nbsp;&nbsp;공지사항&nbsp;&nbsp;|</p><br>
			<div id="board_write">
				<form name="readForm" role="form" method="post">
				 <input type="hidden" id="gno" name="gno" value="${gzView.gno}" /> 
				  <input type="hidden" id="b_name" name="b_name" value="${board_name}" />
				  <input type="hidden" id="gongzi" name="gongzi" value="y" />
				</form>
		
				<div class="board_view_wrap">
					<div class="board_view">
						<div class="title">
							${gzView.title}
						</div>
						
						<div class="info">
							<dl>
								<dt>공지글</dt>
								<dd></dd>
							</dl>
							<dl>
								<dt>글쓴이</dt>
								<dd>${gzView.writer}</dd>
							</dl>
							<dl>
								<dt>작성일</dt>
								<dd>
									<fmt:formatDate value="${gzView.regdate}" pattern="yyyy-MM-dd" />
									<!--24시간 new  -->
									<jsp:useBean id="toDay" class="java.util.Date" /> 
									<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd HH" var="today" />  
									<fmt:parseDate value="${today}" pattern="yyyy-MM-dd HH" var="today1" /> 
							 	    <fmt:parseNumber value="${today1.time / (1000*60*60)}" integerOnly="true" var="strDate"></fmt:parseNumber>
									<fmt:parseDate value="${gzView.regdate}" pattern="yyyy-MM-dd HH" var="writeDay" /> 
							 	    <fmt:parseNumber value="${writeDay.time /(1000*60*60)}" integerOnly="true" var="writeDate"></fmt:parseNumber>
									<c:if test="${strDate - writeDate < 24}">
									   <span id="new">&nbsp;N&nbsp;</span>
									</c:if> 
								</dd>
							</dl>
							<dl>
								<dt>조회수</dt>
								<dd>${gzView.hit}</dd>
							</dl>
								
						</div>
						
						<div class="cont">
								<br>
								<img width="400px;" src="${pageContext.request.contextPath}/resources/img/gonggi_top.jpg"/>
								<br>
								<br>
								<br>
								${gzView.content}
						</div>
					</div>			
				
					<div class="btns">
						<c:if test="${member.userid == gzView.writer}">
							<button type="submit" class="delete_btn">삭제</button>
						</c:if>
						<button type="submit" class="list_btn">목록</button>	
					</div>
				
				</div>
			
			</div>
		</div>
</body>
</html>

<script type="text/javascript">
		
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");
		
			// 삭제
			$(".delete_btn").on("click", function(){
				var deleteYN = confirm("삭제하시겠습니까?");
				if(deleteYN == true){
				formObj.attr("action", "boardDelete.do");
				formObj.attr("method", "post");
				formObj.submit();
				}
			})
			
			// 목록
			$(".list_btn").on("click", function(){
				location.href = "boardList.do?page=${scri.page}"
				+"&board_name=${board_name}"
				+"&perPageNum=${scri.perPageNum}"
				+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
			})
			
		
		})
		
		
		
		
	</script>