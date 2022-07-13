<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>게시글 보기</title>

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
<link href="${pageContext.request.contextPath}/resources/css/board/boardView.css" rel="stylesheet"/>
</head>
<body>

	<c:if test="${member.userid == null}">
			<script>
				location.href="${pageContext.request.contextPath}/member/login.do";
			</script>
	</c:if> 

	<div class="board_wrap">
			<header>
					<p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p>
					<p class="board_name">
					
					<c:set var="title" value="${board_name}" />
					<c:set var="title1" value="${fn:substring(board_name,0,1)}" />
					
					<c:set var="title2" value="${fn:split(board_name,'_')[0]}"/>
					<c:set var="title3" value="${fn:length(title2)}"/><!--019  -->
					<c:set var="sno" value="${fn:substring(title2,1,title3)}" /> 
					<c:choose>
						<c:when test="${title1 eq 'l'}">
							|&nbsp;&nbsp;${sno}번방 스터디룸&nbsp;&nbsp;|<br>Q&A 외국어 게시판입니다.
							<div class="img">
								<img src="${pageContext.request.contextPath}/resources/img/${title1}.png"/>
							</div>
							
						</c:when>
						<c:when test="${title1 eq 'i'}">
							|&nbsp;&nbsp;${sno}번방 스터디룸&nbsp;&nbsp;|<br>Q&A 면접 게시판입니다.
							<div class="img">
								<img src="${pageContext.request.contextPath}/resources/img/${title1}.png"/>
							</div>
						</c:when>
						<c:when test="${title1 eq 's'}">
							|&nbsp;&nbsp;${sno}번방 스터디룸&nbsp;&nbsp;|<br>Q&A 스터디윗미 게시판입니다.
							<div class="img">
								<img src="${pageContext.request.contextPath}/resources/img/${title1}.png"/>
							</div>
						</c:when>
						<c:when test="${title1 eq 'a'}">
							|&nbsp;&nbsp;${sno}번방 스터디룸&nbsp;&nbsp;|<br>Q&A 대외활동 게시판입니다.
							<div class="img">
								<img src="${pageContext.request.contextPath}/resources/img/${title1}.png"/>
							</div>
						</c:when>
						<c:when test="${title1 eq 'c'}">
							|&nbsp;&nbsp;${sno}번방 스터디룸&nbsp;&nbsp;|<br>Q&A 자격증 게시판입니다.
							<div class="img">
								<img src="${pageContext.request.contextPath}/resources/img/${title1}.png"/>
							</div>
						</c:when>
						<c:when test="${title1 eq 'p'}">
							|&nbsp;&nbsp;${sno}번방 스터디룸&nbsp;&nbsp;|<br>Q&A 공무원 게시판입니다.
							<div class="img">
								<img src="${pageContext.request.contextPath}/resources/img/${title1}.png"/>
							</div>
						</c:when>
						<c:when test="${title1 eq 'e'}">
							|&nbsp;&nbsp;${sno}번방 스터디룸&nbsp;&nbsp;|<br>Q&A 기타 게시판입니다.
							<div class="img">
								<img src="${pageContext.request.contextPath}/resources/img/${title1}.png"/>
							</div>
						</c:when>
						<c:when test="${board_name eq 'gb'}">
							|&nbsp;&nbsp;Q&A&nbsp;&nbsp;|<br>자유 게시판입니다.
						</c:when>
					</c:choose>
					
					</p>
			</header>
			
			<div id="board_write">
				<form name="readForm" role="form" method="post">
				  <input type="hidden" id="bno" name="bno" value="${boardView.bno}" />
				  <input type="hidden" id="b_name" name="b_name" value="${board_name}" />
				  <input type="hidden" id="page" name="page" value="${scri.page}"> 
				  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
				  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
				  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
				  <input type="hidden" id="file_no" name="file_no" value=""> 
				  <input type="hidden" id="gongzi" name="gongzi" value="n" />
				</form>
		
				<div class="board_view_wrap">
					<div class="board_view">
						<div class="title">
							${boardView.title}
						</div>
						
						<div class="info">
							<dl>
								<dt>번호</dt>
								<dd>${boardView.bno}</dd>
							</dl>
							<dl>
								<dt>글쓴이</dt>
								<dd>${boardView.writer}</dd>
							</dl>
							<dl>
								<dt>작성일</dt>
								<dd>
									<fmt:formatDate value="${boardView.regdate}" pattern="yyyy-MM-dd" />
									<!--24시간 new  -->
									<jsp:useBean id="toDay" class="java.util.Date" /> 
									<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd HH" var="today" />  
									<fmt:parseDate value="${today}" pattern="yyyy-MM-dd HH" var="today1" /> 
							 	    <fmt:parseNumber value="${today1.time / (1000*60*60)}" integerOnly="true" var="strDate"></fmt:parseNumber>
									<fmt:parseDate value="${boardView.regdate}" pattern="yyyy-MM-dd HH" var="writeDay" /> 
							 	    <fmt:parseNumber value="${writeDay.time /(1000*60*60)}" integerOnly="true" var="writeDate"></fmt:parseNumber>
									<c:if test="${strDate - writeDate < 24}">
									   <span id="new">&nbsp;N&nbsp;</span>
									</c:if> 
								</dd>
							</dl>
							<dl>
								<dt>조회수</dt>
								<dd>${boardView.hit}</dd>
							</dl>
							<dl>
								<dt>추천수</dt>
								<dd>${boardView.likecount}
							</dl>
								
						</div>
						<div class="form-group" style="font-size:13px;border-bottom: 1px solid #999; padding: 4px 15px;">
							첨부파일
							<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
						</div>
						<div class="cont">
								${boardView.content}
								<br>
								<div class="likeWrap">
									<input type="hidden" id="likecount1" value="${boardView.likecount}"/> 
									<span id="likecount">${boardView.likecount}</span><br>
									<button id = "like2" class="like">
										<img src="${pageContext.request.contextPath}/resources/img/like2.png"/>
									</button>
									
								</div>
						</div>
					</div>			
				
					<div class="btns">
						<c:if test="${member.userid == boardView.writer}">
							<button type="submit" class="delete_btn">삭제</button>
						</c:if>
						<button type="submit" class="list_btn">목록</button>	
					</div>
				
				</div>
			<form name="replyForm" method="post">
				  <input type="hidden" id="bno" name="bno" value="${boardView.bno}" />
				  <input type="hidden" id="rb_name" name="rb_name" value="${board_name}" />
				  <input type="hidden" id="userid" name="userid" value="${member.userid}" />  
				  <input type="hidden" id="page" name="page" value="${scri.page}"> 
				  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
				  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
				  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
				
				<p style="font-size:13px;font-weight:bold;">댓글&nbsp;<span style="color:red;">${boardView.recnt}</span></p>
					
				<div class="replyWrite">
				   	<div class="reply_writer">
			   			<dl>
			   				<dt style="font-weight:bold;color:#3c3a3a;">글쓴이</dt>
			   				<dd>
			   				<input type="hidden" id="writer" name="writer" placeholder="글쓴이를 입력해 주세요" value="${member.userid}" />
			   				${member.userid}
			   				</dd>
			   			</dl>
				   	</div>
				    <div class="reply_content">
				    	<textarea id="content" name="content" placeholder="여러분의 소중한 댓글을 남겨주세요" title="내용을 입력하세요."></textarea>
				    </div>
			  </div>
				 
				 <div class="replyWbtn">
				 	 <button type="button" class="replyWriteBtn">댓글등록</button>
				 </div> 
		
					<p style="font-size:13px; font-weight:bold;margin-top:17px;"><span style="color:red;">${boardView.recnt}</span> Comment(s)</p>
					<!-- 댓글 -->
					<div class="replyViewWrap">
					    <c:forEach items="${replyList}" var="replyList">
					      <div class="replyView">
		       				<div class="info">
		       				 	<dl>
		       				 		<dt></dt>
		       				 		<dd style="color:black;font-weight:bold;font-size:13px;">${replyList.writer}</dd>
		       				 	</dl> 
		       				 	<dl>
		       				 		<dt></dt>
		       				 		<dd><fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd" />
		       				 		<!--24시간 new  -->
								<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd HH" var="today" />  
								<fmt:parseDate value="${today}" pattern="yyyy-MM-dd HH" var="today1" /> 
						 	    <fmt:parseNumber value="${today1.time / (1000*60*60)}" integerOnly="true" var="strDate"></fmt:parseNumber>
								<fmt:parseDate value="${boardView.regdate}" pattern="yyyy-MM-dd HH" var="writeDay" /> 
						 	    <fmt:parseNumber value="${writeDay.time /(1000*60*60)}" integerOnly="true" var="writeDate"></fmt:parseNumber>
								<c:if test="${strDate - writeDate < 24}">
								   <span id="new">&nbsp;N&nbsp;</span>
								</c:if> 
		       				 		</dd>
		       				 	</dl> 				         
		       					<dl>
		       				 		<dt></dt>
		       				 		<dd>	
			       				 		<div class="replyView_btn">
										  <c:if test="${member.userid == replyList.writer}">
										  <button type="button" class="replyUpdateBtn" data-rno="${replyList.rno}" >수정</button>
										  <button type="button" class="replyDeleteBtn" data-rno="${replyList.rno}" >삭제</button>
											</c:if>
										</div>
									</dd>
		       				 	</dl> 				         
		       				</div>
					        <div class="replyViewContent">					   
							   ${replyList.content}
							</div>
					     </div>
					    </c:forEach>   
					</div>
				</form>
			</div>
		</div>
</body>
</html>

<script type="text/javascript">
		
		$(document).ready(function(){
			
			//추천
			$("#like2").click(function(){
			
				$.ajax({
					url : "board_like.do",
					type : "POST",
					data : {
						b_name : $("#b_name").val(),
						bno : $("#bno").val(),
						writer : $("#writer").val()
					},
				 	success : function(result){
				 		if(result == 1){
				 			alert("추천은 1회만 가능합니다.");
				 		}else if(result == 0){
				 			var likecount = Number($("#likecount1").val()) + 1;
				 			console.log(likecount);
				 			$("#likecount").text("");  
				 		 	$("#likecount").text(likecount);  
				 		
						}
					} 
				})
			});
			
			
			
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
			
			//댓글
			$(".replyWriteBtn").on("click", function(){
				  var formObj = $("form[name='replyForm']");
				  formObj.attr("action", "replyWrite.do");
				  formObj.submit();
			});
			
			//댓글 수정 View
			$(".replyUpdateBtn").on("click", function(){
				location.href = "replyUpdateView.do?bno=${boardView.bno}"								
								+ "&rb_name=${board_name}"
								+ "&page=${scri.page}"
								+ "&perPageNum=${scri.perPageNum}"
								+ "&searchType=${scri.searchType}"
								+ "&keyword=${scri.keyword}"
								+ "&rno="+$(this).attr("data-rno");
			});
					
			//댓글 삭제 View
			$(".replyDeleteBtn").on("click", function(){
				location.href = "replyDeleteView.do?bno=${boardView.bno}"
					+ "&rb_name=${board_name}"
					+ "&page=${scri.page}"
					+ "&perPageNum=${scri.perPageNum}"
					+ "&searchType=${scri.searchType}"
					+ "&keyword=${scri.keyword}"
					+ "&rno="+$(this).attr("data-rno");
			});		
		})
		
		function fn_fileDown(fileNo){
			var formObj = $("form[name='readForm']");
			$("#file_no").attr("value", fileNo);
			formObj.attr("action", "fileDown.do");
			formObj.submit();
		}
		
		
	</script>