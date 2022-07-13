package com.gb.wn;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice//Controller에서 발생하는 Exception을 전문적으로 처리하는 클래스임을 알려준다.
public class CommonExceptionAdvice {

	@ExceptionHandler(Exception.class)
	private ModelAndView errMAV(Exception e) {
		System.out.println("예외처리");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/err_exception");
		mav.addObject("exception", e);
		return mav;
	}
	
}
