<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(".cancel_btn").on("click", function(){
				location.href = "boardView.do?bno=${replyUpdate.bno}"
					+ "&b_name=${board_name}"
					+ "&userid=${member.userid}"  
					+ "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			})
			
		})
		
</script>
<link href="${pageContext.request.contextPath}/resources/css/board/replyUpdateView.css" rel="stylesheet"/>
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
		<c:if test="${member == null}"><a href="${pageContext.request.contextPath}/member/login.do">로그인</a></c:if> 
			
		<div class="board_wrap">
			<header>
				<p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p>
				<h3>Q&A</h3>
				<h5>댓글수정 창입니다.${board_name}</h5>
			</header>
		
			<section id="container">
				<form name="updateForm" role="form" method="post" action="replyUpdate.do">
					<input type="hidden" name="bno" value="${replyUpdate.bno}" />
					<input type="hidden" name="rb_name" value="${board_name}" />
					<input type="hidden" id="userid" name="userid" value="${member.userid}" />  
					<input type="hidden" id="rno" name="rno" value="${replyUpdate.rno}" />
					<input type="hidden" id="page" name="page" value="${scri.page}"> 
					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
					
				<div class="replyWrite">
				   	<div class="reply_writer">
				   			<dl>
				   				<dt style="font-weight:bold;;">글쓴이</dt>
				   				<dd>${replyUpdate.writer}</dd>
				   			</dl>
				   	</div>
				    <div class="reply_content">
				    	<textarea id="content" name="content"  title="내용을 입력하세요.">${replyUpdate.content}</textarea>
				    </div>
				 </div>
	
					<div class="bt_wrap">
						<button type="submit" class="update_btn">저장</button>
						<button type="button" class="cancel_btn">취소</button>
						<a class="btn1" href="boardList.do?board_name=${board_name}" class="on">목록</a>
					</div>
				</form>
			</section>
		</div>
</body>
</html>