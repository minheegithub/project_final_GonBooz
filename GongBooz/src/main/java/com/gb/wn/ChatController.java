package com.gb.wn;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ChatController {
	

	
	@RequestMapping(value="chat/chat.do")
	public String chat() {
		
		return "chat/chat";	
	}
/*	@RequestMapping(value="member/myinfo.do")
	public String calendar() {
		
		return "member/myinfo";
	}*/
	}
