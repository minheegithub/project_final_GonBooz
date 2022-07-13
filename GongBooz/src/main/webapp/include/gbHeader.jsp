<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css"/> <!-- 슬라이더 css -->
<link rel="stylesheet" href="resources/css/header1.css"></link> <!-- css -->
<script src="//code.jquery.com/jquery-3.4.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>	<!-- 슬라이더 플러그인 -->

<script>

	var src="";
	var audio = new Audio();

	window.addEventListener( 'message', receiveMsgFromParent );
	//부모로부터 메시지 수신
	function receiveMsgFromParent( e ) {
	 audio.pause();
	 audio.currentTime=0;
	 // e.data가 전달받은 메시지
	 console.log('여기는 gbHeader :', e.data );
	 var src = e.data;
	 console.log ('src/receiveMsgFromParent안에 : ' +src);
	
	audio = new Audio(src);
	audio.play();
	};
	

	//재생버튼
	var play = function (){
		audio.play();
	}
	//일시정지
	var pause = function (){
		audio.pause();
	}
	//정지
	var stop = function(){
		if(audio.played){
			audio.pause();
			auido.currentTime=0;
		}
	}
	
	$(document).ready(function (){		
		$('svg').hover(function(){
	        $(this).animate({opacity:"80%"}, 200);
	    	}, function() {
	        $(this).animate({opacity:"100%"}, 200);
		   });
	
		$('#volumeslider').slider({
			min: 0,
			max: 1,
			step: 0.01,
			value: 0.5,
			change: function(e, ui){ audio.volume = ui.value;}
		});
		
		//메뉴탭 클릭시 css 스타일 변경
		$('#music').click(function(){
			$('#mainifr').attr('src', './gbMusic.jsp');
			$('#free').removeClass('box').addClass('underline');
			$('#study').removeClass('box').addClass('underline');
			$('#login').removeClass('box').addClass('underline');
			$('#logout').removeClass('box').addClass('underline');
			$(this).removeClass('underline').addClass('box');
		});

		$('#free').click(function(){
			$('#mainifr').attr('src', '${pageContext.request.contextPath}/board/boardList.do?board_name=gb');
			$('#music').removeClass('box').addClass('underline');
			$('#study').removeClass('box').addClass('underline');
			$('#login').removeClass('box').addClass('underline');
			$('#logout').removeClass('box').addClass('underline');
			$(this).removeClass('underline').addClass('box');
		});
		
		$('#study').click(function(){
			$('#mainifr').attr('src', '${pageContext.request.contextPath}/studyAll.do?swiper=y');
			$('#music').removeClass('box').addClass('underline');
			$('#free').removeClass('box').addClass('underline');
			$('#login').removeClass('box').addClass('underline');
			$('#logout').removeClass('box').addClass('underline');
			$(this).removeClass('underline').addClass('box');
		});
		
		$('#login').click(function(){
			//$('#mainifr').attr('src', './login.jsp');
			$('#mainifr').attr('src', '${pageContext.request.contextPath}/member/login.do');
			$('#music').removeClass('box').addClass('underline');
			$('#free').removeClass('box').addClass('underline');
			$('#study').removeClass('box').addClass('underline');
			$('#logout').removeClass('box').addClass('underline');
			$(this).removeClass('underline').addClass('box');
		});
		$('#logout').click(function(){
			//$('#mainifr').attr('src', './login.jsp');
			$('#mainifr').attr('src', '${pageContext.request.contextPath}/member/logout.do');
			$('#music').removeClass('box').addClass('underline');
			$('#free').removeClass('box').addClass('underline');
			$('#study').removeClass('box').addClass('underline');
			$('#login').removeClass('box').addClass('underline');
			$(this).removeClass('underline').addClass('box');
		});
	

	});
</script>
<nav>

	 	<div id="headericon">
         <button id="playbtn" onclick="play()"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
            <path d="M3 22v-20l18 10-18 10z"/>
         </svg></button>
         <button id="pausebtn" onclick="pause()"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
            <path d="M10 24h-6v-24h6v24zm10-24h-6v24h6v-24z"/>
         </svg></button>
         <button id="stopbtn" onclick="stop()"> <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24">
            <path d="M2 2h20v20h-20z"/>
         </svg></button>
         <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path d="M5 17h-5v-10h5v10zm2-10v10l9 5v-20l-9 5zm11.008 2.093c.742.743 1.2 1.77 1.198 2.903-.002 
            1.133-.462 2.158-1.205 2.9l1.219 1.223c1.057-1.053 1.712-2.511 1.715-4.121.002-1.611-.648-3.068-1.702-4.125l-1.225
             1.22zm2.142-2.135c1.288 1.292 2.082 3.073 2.079 5.041s-.804 3.75-2.096 5.039l1.25 1.254c1.612-1.608 2.613-3.834
              2.616-6.291.005-2.457-.986-4.681-2.595-6.293l-1.254 1.25z"/>
         </svg>
			<div id="volumeslider"></div>
		</div>
		<div class="menu2">
			<div id="music" class="default box">음악</div>
			<div id="free" class="default underline">자유게시판</div>
			<div id="study" class="default underline">스터디</div>
			<div id="login" class="default underline">로그인</div>
			<div id="logout" class="default underline">로그아웃</div>
		</div> 
		<div id="title">GongBooZ</div>

</nav>
</html>