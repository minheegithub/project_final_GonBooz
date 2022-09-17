<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<link href="${path}/resources/css/studyRoom/studyroomMain.css" rel="stylesheet"/>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>GongBooz-online study</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">

<!-- Link Swiper's CSS -->
<link
  rel="stylesheet"
  href="https://unpkg.com/swiper/swiper-bundle.min.css"
/>

<style>
.inner{
	margin: 30px auto;
	width:1200px;
	 text-align:center;  
	 border:1px solid #fff;
	 padding-left:30px;
	 padding-right:30px;
	 padding-top:70px;
	 border-radius:7px;
}
.swiper-slide {
	border: 1px solid #ddd;
	width: 250px;
	height: 450px;
	float: left;
	 margin: 10px; 
	padding-top: 21px;
	border-radius: 5px;
	text-align: center;
	border-radius: 4px;
	font-family: 'Poor Story', cursive;
	 box-shadow: 2px 5px 9px 0px, 5px 5px 5px 5px rgba(0, 0, 0, 0); 
}

.swiper-slide:hover {
	box-shadow: 2px 5px 9px 3px, 5px 5px 5px 5px rgba(0, 0, 0, 0); 
}

/*swiper  */
.swiper {
	width: 1100px;
	padding-top: 20px;
	padding-bottom: 50px;
}

.swiper-slide img {
	display: block;
	width: 100%;
	margin-bottom: 10px;
}

.delete_btn {
	border-radius: 2px;
	border: none;
	width: 40px;
	margin-left: 152px;
	font-size: 13px;
	height: 21px;
	margin-top: 4px;
	background-color: rgba(255, 255, 255, 0.5);
}

.delete_btn:hover {
	border-radius: 2px;
	background-color: #fff;
}

#studyTable {
	background: transparent;
	margin-bottom: 2px;
	border: 1px solid #ddd;
	border-collapse: separate;
	border-radius: 4px;
	margin-left: 4px;
	color: #fff;
	padding: 4px;
}

#studyTable tr td:first-child {
	border-right: 1px solid #fff;
}

#alert {
	border: 0;
	outline: 0;
	width: 210px;
	color: white;
	background: none;
	opacity: 0.7;
	margin-bottom: 10px;
}

#alert:hover {
	border: 1px dotted #fff;
}

@font-face {
	font-family: 'title';
	src: url("${pageContext.request.contextPath}/resources/MindFont.otf")
		format('opentype');
}

.gongbooz {
	font-family: 'title', cursive;
	font-size: 14px;
	text-align: center;
	color: #fff;
	width: 90px;
	border: none;
	margin-left: 140px;
}

#mainbox {
	width: 1200px;
	margin: auto;
	overflow: auto;
}

#photo_box {
	width: 1200px;
	/* padding: 10px; */
	margin: auto;
	overflow: auto;
}

#gallery {
	color: #fff;
	font-size:14px;
	margin-left:900px;
}

.filter2 {
	color: #353535; 
	border-radius: 3px;
	background: transparent;
	margin-right: 12px;
	border:none;
	height:34px;
	width:100px;
	background-color: rgba(255, 255, 255, 0.5);
	font-size:14px;
}

.filter2:hover {
	background-color: #fff;
	color: #353535;
	border-radius: 3px;
	border: 1px solid #fff;
	margin-right: 12px;
	font-size:14px;
}

.filter2hover {
	background-color: #fff;
	color:#353535;
	border-radius: 3px;
	border: 1px solid #fff;
	margin-right: 12px;
	height:34px;
	width:100px;
	font-size:14px;
}

.alert {
	color: #fff;
	margin-top: 70px;
	font-size: 17px;
}
</style>
</head> 
<body>
<c:if test="${member.userid == null}">
		<script>
			location.href = "${pageContext.request.contextPath}/member/login.do";
		</script>
</c:if>	  
    
<div class="outer">
<div class="inner">
	<h1>스터디 모집 게시판</h1>
	<h6 style="margin-top:20px;color:#fff;">${member.username}님 원하시는 스터디를 자유롭게 등록하시거나 참여하세요</h6>
	<hr style="border:1px dotted #eee;"> 
<!--검색 창  -->
<section class="sc-search">
	<form action="search-controller.do" method="get">
		<select name="filter" id="filter" style="height:27px;border-radius:3px;background-color:transparent;">
			<option value="study_name" style="color:black;">전체</option>
			<option value="study_name" style="color:black;">스터디명</option>
			<option value="study_tag" style="color:black;">태그</option>
			<option value="region" style="color:black;">오프라인 지역</option>
		</select>	
		<input type="text" name="search" placeholder="필터에 맞춰 검색해보세요" style="color:white;width:300px;height:27px;border-radius:3px;background-color:transparent;">
		<input type="submit" value="검색" id="search_btn">
		<input type="hidden" name="swiper" value="${swiper}">
		
	</form>
	<p></p>
	<div id="searched">${whatSearched}검색결과✔</div>
</section>

<section class ="sc-insert">
	<div id="create_btn">
	<!-- 버튼 누를 시 새로운 버튼형태로 스터디 목록을 볼 수 있다.  -->
		스터디 목록&nbsp;&nbsp;<button data-toggle="modal" id= "study_create" data-target="#modal">➕</button>	<br>
	<c:if test = "${swiper == 'y'}">
	<a href="${pageContext.request.contextPath}/studyAll.do?swiper=n" id="gallery">스터디룸 한눈에 보기&nbsp;>></a>
	</c:if>
	<c:if test = "${swiper == 'n'}">
	<a href="${pageContext.request.contextPath}/studyAll.do?swiper=y" id="gallery">이미지 갤러리 화면&nbsp;>></a>
	</c:if>
	</div>
	
	<div class="modal fade" id="modal">
	<div class="modal-dialog">
	<div class="modal-content">
	<jsp:include page="studyInsertForm.jsp">
 		<jsp:param name="swiper" value="${swiper}" />
 	</jsp:include>

	</div>
	</div>
	</div>
</section>
<section>
	<hr style="border:1px dotted #eee;"> 
	<form action="studyfilter.do">
		<input type="hidden" name="swiper" value="${swiper}">
		<c:choose>
			<c:when test="${selectTag eq 'all'}">
				<button class="filter2hover" type="submit" name="study_tag" value="all">&nbsp;전체&nbsp;</button>
			</c:when>
			<c:otherwise>
				<button class="filter2" type="submit" name="study_tag" value="all">&nbsp;전체&nbsp;</button>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${selectTag eq '외국어'}">
				<button class="filter2hover" type="submit" name="study_tag" value="외국어">&nbsp;외국어&nbsp;</button>
			</c:when>
			<c:otherwise>
				<button class="filter2" type="submit" name="study_tag" value="외국어">&nbsp;외국어&nbsp;</button>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${selectTag eq '면접'}">
				<button class="filter2hover" type="submit" name="study_tag" value="면접">&nbsp;면접&nbsp;</button>
			</c:when>
			<c:otherwise>
				<button class="filter2" type="submit" name="study_tag" value="면접">&nbsp;면접&nbsp;</button>
			</c:otherwise>
		</c:choose>
			<c:choose>
			<c:when test="${selectTag eq '스터디윗미'}">
				<button class="filter2hover" type="submit" name="study_tag" value="스터디윗미">&nbsp;스터디윗미&nbsp;</button>
			</c:when>
			<c:otherwise>
				<button class="filter2" type="submit" name="study_tag" value="스터디윗미">&nbsp;스터디윗미&nbsp;</button>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${selectTag eq '대외활동'}">
				<button class="filter2hover" type="submit" name="study_tag" value="대외활동">&nbsp;대외활동&nbsp;</button>
			</c:when>
			<c:otherwise>
				<button class="filter2" type="submit" name="study_tag" value="대외활동">&nbsp;대외활동&nbsp;</button>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${selectTag eq '자격증'}">
				<button class="filter2hover" type="submit" name="study_tag" value="자격증">&nbsp;자격증&nbsp;</button>
			</c:when>
			<c:otherwise>
				<button class="filter2" type="submit" name="study_tag" value="자격증">&nbsp;자격증&nbsp;</button>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${selectTag eq '공무원'}">
				<button class="filter2hover" type="submit" name="study_tag" value="공무원">&nbsp;공무원&nbsp;</button>
			</c:when>
			<c:otherwise>
				<button class="filter2" type="submit" name="study_tag" value="공무원">&nbsp;공무원&nbsp;</button>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${selectTag eq '기타'}">
				<button class="filter2hover" type="submit" name="study_tag" value="기타">&nbsp;기타&nbsp;</button>
			</c:when>
			<c:otherwise>
				<button class="filter2" type="submit" name="study_tag" value="기타">&nbsp;기타&nbsp;</button>
			</c:otherwise>
		</c:choose>
		</form>
		
</section>
 <hr style="border:1px dotted #eee;">
<section class ="sc_result">
	
	<c:if test = "${swiper == 'y'}">
	<div class="swiper mySwiper">
      <c:if test="${ empty alist }">
					<div align="center" class="alert">등록된 스터디룸이 없습니다.</div>
	</c:if>
      <div class="swiper-wrapper">
        <c:forEach var="imsi" items="${alist}" varStatus="status">		
					<div class="swiper-slide">
						<p class="gongbooz">GongBooZ</p> 
						<form action="studyAlert.do" method="post"> 
							<div class="alert_modal" style="margin-right:12px;margin-left:12px;">						
								<button id="alert" data-toggle="modal" data-id= "study_alert" data-target="#modal2" value="${imsi.sno}"
								type="submit" name="sno" style="color:white;"> 
								<c:choose>
									<c:when test="${imsi.study_tag eq '외국어'}">
										<img src="${pageContext.request.contextPath}/resources/img/l.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '면접'}">
										<img src="${pageContext.request.contextPath}/resources/img/i.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '스터디윗미'}">
										<img src="${pageContext.request.contextPath}/resources/img/s.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '대외활동'}">
										<img src="${pageContext.request.contextPath}/resources/img/a.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '자격증'}">
										<img src="${pageContext.request.contextPath}/resources/img/c.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '공무원'}">
										<img src="${pageContext.request.contextPath}/resources/img/p.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '기타'}">
										<img src="${pageContext.request.contextPath}/resources/img/e.png"/>
									</c:when>
								</c:choose>
								
								<b>${imsi.sno}.&nbsp;${imsi.study_name}</b>
								
								</button><br>
								<table id="studyTable">
									<tr><td style="width:70px;"><b>태그</b></td><td style="width:170px;">${imsi.study_tag}</td></tr>
									<tr><td><b>장소 </b></td><td>${imsi.region}</td></tr>
									<tr><td><b>정원 </b></td><td>${imsi.max_number}명</td></tr>
									<tr><td><b>참여 </b></td><td>${imsi.cur_number}명 참여중</td></tr>
								</table>
								<div>
								</div>
								
							</div>
						</form>
						
						<form name="deleteForm">
							<c:if test="${member.userid == imsi.open_id}">
									<button type="submit" class="delete_btn">삭제</button> 
									<input type="hidden" value="${imsi.sno}" name="sno"/>
									<input type="hidden" value="${imsi.study_tag}" name="study_tag"/>
									<input type="hidden" value="${swiper}" name="swiper"/>
							</c:if>
						</form>
					</div>
				</c:forEach>

      </div>
      <div class="swiper-pagination"></div>
    </div>
	</c:if>
    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
      var swiper = new Swiper(".mySwiper", {
          effect: "coverflow",
          grabCursor: true,
          centeredSlides: true,
          slidesPerView: "auto",
          coverflowEffect: {
          rotate: 50,
          stretch: 0,
          depth: 100,
          modifier: 1,
          slideShadows: true,
        },
        pagination: {
          el: ".swiper-pagination",
        },
      });
    </script>
    
    <c:if test = "${swiper == 'n'}">
    	 <div id="mainbox">
				<c:if test="${ empty alist }">
					<div align="center" class="alert">등록된 스터디룸이 없습니다.</div>
				</c:if>
				<div id="photo_box">
				 <c:forEach var="imsi" items="${alist}" varStatus="status">	
					<div class="swiper-slide" style="margin:17px;">
						<p class="gongbooz">GongBooZ</p>
						<form action="studyAlert.do" method="post"> 
							<div class="alert_modal" style="margin-right:12px;margin-left:12px;">						
								<button id="alert" data-toggle="modal" data-id= "study_alert" data-target="#modal2" value="${imsi.sno}"
								type="submit" name="sno" style="color:white;"> 
								<c:choose>
									<c:when test="${imsi.study_tag eq '외국어'}">
										<img src="${pageContext.request.contextPath}/resources/img/l.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '면접'}">
										<img src="${pageContext.request.contextPath}/resources/img/i.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '스터디윗미'}">
										<img src="${pageContext.request.contextPath}/resources/img/s.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '대외활동'}">
										<img src="${pageContext.request.contextPath}/resources/img/a.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '자격증'}">
										<img src="${pageContext.request.contextPath}/resources/img/c.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '공무원'}">
										<img src="${pageContext.request.contextPath}/resources/img/p.png"/>
									</c:when>
									<c:when test="${imsi.study_tag eq '기타'}">
										<img src="${pageContext.request.contextPath}/resources/img/e.png"/>
									</c:when>
								</c:choose>
								
								<b>${imsi.sno}.&nbsp;${imsi.study_name}</b>
								
								</button><br>
								
								<table id="studyTable">
									<tr><td style="width:70px;"><b>태그</b></td><td style="width:170px;">${imsi.study_tag}</td></tr>
									<tr><td><b>장소 </b></td><td>${imsi.region}</td></tr>
									<tr><td><b>정원 </b></td><td>${imsi.max_number}명</td></tr>
									<tr><td><b>참여 </b></td><td>${imsi.cur_number}명 참여중</td></tr>
								</table>
								<div>
								
								</div>
								
							</div>
						</form>
						
						<form name="deleteForm">
							<c:if test="${member.userid == imsi.open_id}">
									<button type="submit" class="delete_btn">삭제</button> 
									<input type="hidden" value="${imsi.sno}" name="sno"/>
									<input type="hidden" value="${imsi.study_tag}" name="study_tag"/>
									<input type="hidden" value="${swiper}" name="swiper"/>
							</c:if>
						</form>
								
					</div>
				</c:forEach>
			</div>
		</div>
		</c:if>
</section>


<br></br>


</div>
</div>

</body>
</html>

   <script type="text/javascript">
		
		$(document).ready(function(){
			var formObj = $("form[name='deleteForm']");

			// 삭제
			$(".delete_btn").on("click", function(){
				
				var deleteYN = confirm("삭제하시겠습니까?");
				if(deleteYN == true){
				
					formObj.attr("action", "deleteStudy.do");
					formObj.attr("method", "get");
					formObj.submit();
				
				}
			})
		
		})
		
	</script>