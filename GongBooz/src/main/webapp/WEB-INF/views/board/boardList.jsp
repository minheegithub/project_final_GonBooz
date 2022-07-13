<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>게시판 목록</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
   
<!-- Link Swiper's CSS -->
<link
  rel="stylesheet"
  href="https://unpkg.com/swiper/swiper-bundle.min.css"
/>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/board/boardList.css" rel="stylesheet"/>
<style type="text/css">
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
		
	<div id="root">
			<div class="boardlist_wrap">
				<div class="head">	
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
				</div>	
				<!--검색  -->
				<!--by최민희, 키워드와 해당 테이블 이름을 파리미터로 가지로 검색을 한다.   -->
				<div class="search">
				    <select class="searchT" name="searchType">
				      <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>전체</option>
				      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
				      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
				      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
				      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
				    </select>
					
				    <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}"/>
				    <input type="hidden" name="board_name" id="board_name" value="${board_name}"/>
				
				    <button id="searchBtn" type="button">검색</button>
				    <script>
					      $(function(){
					        $('#searchBtn').click(function(){
//					        	self.location = "boardList.do" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val())+"&board_name="+encodeURIComponent($('#board_name').val());
					        	self.location = "boardList.do?searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val())+"&board_name="+encodeURIComponent($('#board_name').val());
					        });
					      });   
					</script>
				    
				 </div>	<!--검색  -->
				
				<form role="form" method="get">
					<table class="board_list">
						<tr>
							<th width=49>번호</th>
							<th width=389>제목</th>
							<th width=109>작성자</th>
							<th width=109>등록일</th>
							<th width=40>추천수</th>
							<th width=40>조회수</th>
						</tr>
						<c:forEach items="${gongzi}" var = "gzlist">
							<tr>
								<td style="border-bottom:1px solid #ddd;">
									<img src="${pageContext.request.contextPath}/resources/img/gongzi.png"/>&nbsp;
								</td>
								<td class="tit" style="border-bottom:1px solid #ddd;">
								<a href="boardView.do?b_name=${board_name}&gongzi=y&gno=${gzlist.gno}">								
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
								</a>
								</td>
								<td style="border-bottom:1px solid #ddd;">${gzlist.writer}</td>
								<td style="border-bottom:1px solid #ddd;"><fmt:formatDate value="${gzlist.regdate}" pattern="yyyy-MM-dd" /></td>
								<td style="border-bottom:1px solid #ddd;">-</td>
								<td style="border-bottom:1px solid #ddd;">${gzlist.hit}</td>
							</tr>
						</c:forEach>
						<c:forEach items="${boardList}" var = "list">
							 <tr>
								<!--글번호  -->
								<td ><c:out value="${list.bno}"/></td>
								<!--글제목  -->
								<td class="tit">
									<a href="boardView.do?bno=${list.bno}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&b_name=${board_name}&gongzi=n">
									<c:out value="${list.title}" /> 
									<!--댓글갯수  -->
									<c:if test="${list.recnt > 0}">
										<span class="rep"> (${list.recnt})</span>
									</c:if>  
									</a>
									
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
					</table>
			
					<table class="btn_bottom">
						<tr>
							<td class="btn_list"><a class="btn1" href="boardList.do?board_name=${board_name}">목록</a></td>
							<td class="btn_write"><a class="btn2" href="boardInsert.do?b_name=${board_name}">글쓰기</a></td>
						</tr>
					</table>
					
				 	 <div class="paging" >
					  <ul>
					    <li><a href="#"> << </a></li> 
					    <!--prev가 true일 경우  -->
					    <c:if test="${pageMaker.prev}">
					    	<li><a href="boardList.do${pageMaker.makeSearch(pageMaker.startPage - 1)}&board_name=${board_name}"><</a></li> 
					    </c:if> 
					    	<!-- by최민희, 
					    	makeSearch() return값 문자열 : 
					    	?page=1&perPageNum=10&searchType=w&keyword=spring
					    	여기서 파라미터값 page와 perPageNum은 SearchCriteria의 부모인 Criteria의 필드값이다.
					    	 -->
					    	
					    	<!--startPage endPage은 PageMaker클래스의 속성이다.  -->
						
					    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					    	<li><a href="boardList.do${pageMaker.makeSearch(idx)}&board_name=${board_name}">${idx}</a></li>
					    </c:forEach>
						
					    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					    	<li><a href="boardList.do${pageMaker.makeSearch(pageMaker.endPage + 1)}&board_name=${board_name}">></a></li>
					    </c:if> 
					  	<li><a href="#"> >> </a></li> 
					  </ul>
					</div> 
				</form>
		</div>
		</div>
</body>

</html>