<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> 
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "boardWrite.do");
				formObj.attr("method", "post");
				formObj.submit();
			});
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
		function fn_addFile(){
			var fileIndex = 1;
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
			});
		}	
	</script>
	<!--섬머노트  -->
  <script>
    $(document).ready(function() {
        $('#content').summernote({
        		  placeholder: '내용을 넣어주세요',
        	        tabsize: 2,
        	        height: 300       	    	
        });
    });
  </script>
<link href="${pageContext.request.contextPath}/resources/css/board/boardWrite.css" rel="stylesheet"/> 
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
		<div class="board_wrap">
			<header>
				<p class="gongbooz" style="font-family: 'title', cursive;">GongBooZ</p>
				<p class="board_name">
					
					<c:set var="title" value="${boardVO.b_name}" />
					<c:set var="title1" value="${fn:substring(boardVO.b_name,0,1)}" />
					<c:set var="title2" value="${fn:split(boardVO.b_name,'_')[0]}"/>
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
							</div></c:when>
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
						<c:when test="${boardVO.b_name eq 'gb'}">
							|&nbsp;&nbsp;Q&A&nbsp;&nbsp;|<br>자유 게시판입니다.
						</c:when>
					</c:choose>
					
					</p>
				
			</header>
			<c:if test="${member.userid == null}">
				<script>
					location.href="${pageContext.request.contextPath}/member/login.do";
				</script>
			</c:if>
			<!--
				by최민희, 파일 업로드를 위해 Form의 인코딩타입을 multipart/form-data로 변경
				업로드할 파일을 선택할 수 있도록 file타입이 input태그를 작성.
			  -->
			<form name="writeForm" method="post" action="boardWrite.do" enctype="multipart/form-data">
					<div class="board_write_wrap">
						<div class="board_write">
							 <div class="title">
								<dl>
									<dt>제목</dt>
									<dd><input  type="text" id="title" name="title" class="chk" title="제목을 입력하세요." placeholder="제목을 입력하세요."/></dd>
									
								</dl>
							 </div>
							<input type="hidden" id="b_name" name="b_name" class="chk" value="${boardVO.b_name}" />  
							 <div class="write">
									<dl>
										<dt>작성자</dt>
										<dd>
										${member.userid}
										<input type="hidden" id="writer" name="writer"class="chk" value="${member.userid}" />  
										</dd>
									</dl>
							 </div>
							
							<c:choose>
								<c:when test="${member.userid eq 'admin'}">
									<div class="write">
										<dl>
											<dt>공지사항</dt>
											<dd>
											<input type="checkbox" id="gongzi" name="gongzi" class="chk" value="y" />  
											</dd>
										</dl>
									</div>
								</c:when>
								<c:otherwise>
									 <div class="fileup">
										<dl>
											<dt>첨부파일</dt>
											<dd><input type="file" name="file" ></dd>
										</dl>						
								 	</div>
								</c:otherwise>
							</c:choose>
								
							<div class="cont">
									<textarea id="content" name="content" class="chk" title="내용을 입력하세요."></textarea>
							</div>
							<div class="bt_wrap">
									<a class="btn1" href="boardList.do?board_name=${boardVO.b_name}" class="on">목록</a>
									<a class="btn2" href="boardInsert.do?b_name=${boardVO.b_name}">취소</a>
									<button class="write_btn" type="submit">작성</button>
							</div>							
						</div>			
					</div>
			</form>		
		</div>		
</body>
</html>