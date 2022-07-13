package com.gb.wn;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.gb.wn.chat.vo.Message;
import com.google.gson.Gson;

@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	
	
	
	private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) {
		
		sessionList.add(session);
		logger.info("{} 연결됨", session.getId());
		
		
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws IOException {
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		
		Gson gson = new Gson();
		
		Message msg = gson.fromJson(message.getPayload(), Message.class);
		
		
		
		TextMessage sendMsg = new TextMessage(gson.toJson(msg));
		
		System.out.println(sendMsg);
		
		for(WebSocketSession sess : sessionList) {
			sess.sendMessage(sendMsg);
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	     sessionList.remove(session);
	       logger.info("{} 연결 끊김.", session.getId());
	    }


}
