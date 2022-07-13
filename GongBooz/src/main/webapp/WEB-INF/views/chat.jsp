<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
	type="text/css" rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
	type="text/css" rel="stylesheet">
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style>
<%@ include file="/resources/css/chatting.css"%>
</style>
<title>Insert title here</title>

</head>
<body>
	<div class="container">
		<div class="messaging">
			<div class="inbox_msg">
				<div class="inbox_people">
					<div class="headind_srch">
						<div class="recent_heading">
							<h4>Recent</h4>
						</div>
						<div class="srch_bar">
							<div class="stylish-input-group">
								<input type="text" class="search-bar" placeholder="Search">
								<span class="input-group-addon">
									<button type="button">
										<i class="fa fa-search" aria-hidden="true"></i>
									</button>
								</span>
							</div>
						</div>
					</div>
					<div class="inbox_chat">
						<div class="chat_list active_chat">
							<div class="chat_people">
								<div class="chat_img">
									<img src="https://ptetutorials.com/images/user-profile.png"
										alt="sunil">
								</div>
								<div class="chat_ib">
									<h5>
										마이페이지
									</h5>
									 <a href="${pageContext.request.contextPath}/member/login.do">마이페이지</a>  
								</div>
							</div>
						</div>
						<div class="chat_list">
							<div class="chat_people">
								<div class="chat_img">
									<img src="https://ptetutorials.com/images/user-profile.png"
										alt="sunil">
								</div>
								<div class="chat_ib">
									<h5>
										스터디 게시판
									</h5>
									<a href="${pageContext.request.contextPath}/studyAll.do?swiper=y">스터디 게시판</a>
								</div>
							</div>
						</div>
						<div class="chat_list">
							<div class="chat_people">
								<div class="chat_img">
									<img src="https://ptetutorials.com/images/user-profile.png"
										alt="sunil">
								</div>
								<div class="chat_ib">
									<h5>
										자유 게시판
									</h5>
									<a href="${pageContext.request.contextPath}/board/boardList.do">자유 게시판</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="mesgs">
					<div class="msg_history">
						<div class="incoming_msg">
							<div class="incoming_msg_img">
								<img src="https://ptetutorials.com/images/user-profile.png"
									alt="sunil">
							</div>
							<div class="received_msg">
								<div class="received_withd_msg">
									<p>GongBooZ 입니다.</p>
									<span class="time_date"> 11:01 AM | June 9</span>
								</div>
							</div>
						</div>
						<div class="outgoing_msg">
							<div class="sent_msg">
								<p>정보 교환/만날 장소 지정 등을 위한 채팅방입니다.</p>
								<span class="time_date"> 11:01 AM | June 9</span>
							</div>
						</div>
					<div id = "messageArea">
					
					</div>
					<input type="hidden" value="${member.userid}" id="sessionuserid">

					</div>
	
					<div class="type_msg">
						<div class="input_msg_write">
							<input type="text" id="message" class="write_msg" placeholder="Type a message" />
							<button class="msg_send_btn" id="sendBtn" type="button">
								<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</body>

<script type="text/javascript">
$(document).ready(function() {
	$('#message').keypress(function(event){
		var keycode = (event.keyCode ? event.keyCode : event.which);
		
		if(keycode == '13'){
			sendMessage();
			$('#message').val('')
			$('#message').focus();
			
			return false;
		}
		event.stopPropagation();
	})
})
$("#sendBtn").click(function() {
	sendMessage();
	$('#message').val('')
	$('#message').focus();
	
	return false;
});

let sock = new SockJS("http://localhost:9191/wn/echo/");
sock.onmessage = onMessage;
sock.onclose = onClose;

$(function(){
});
// 메시지 전송
function sendMessage() {
	
	var msg = {
			user : '${member.userid}',
			message : $("#message").val()
	};
	sock.send(JSON.stringify(msg));
	
}
// 서버로부터 메시지를 받았을 때
function onMessage(evt) {
	var data = evt.data;
	
	var msgData = JSON.parse(data);

	
	var currentuser_session = $('#sessionuserid').val();
	console.log('current session id: '+currentuser_session);
			
	
	var curDate = new Date();
	var curTime = curDate.getHours();

	if(msgData.user == currentuser_session){
	
	var Exmsg =	"<div class='outgoing_msg'>";
		Exmsg += "<div class='sent_msg'>";
		Exmsg += "<p>"+msgData.message+"</p>";
		Exmsg += "<span class='time_date'>"+msgData.user+ "</span>";
		Exmsg += "</div></div>";

	$("#messageArea").append(Exmsg);
	}else {
	var Exmsg ="<div class='received_msg'>";
		Exmsg += "<div class='received_withd_msg'>";
		Exmsg += "<p>"+msgData.message+"</p>";
		Exmsg += "<span class='time_date'>"+msgData.user+ "</span>";
		Exmsg += "</div></div>";
	
	$("#messageArea").append(Exmsg);
	}
	console.log('chatting data: '+msgData);
	
}




// 서버와 연결을 끊었을 때
function onClose(evt) {
	$("#messageArea").append("연결 끊김");
}
</script>
</html>