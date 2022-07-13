package com.gb.wn.main.board.boardVO;

public class LikeVO {
	
	String b_name;
	int bno;
	String writer;
	 
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	@Override
	public String toString() {
		return "LikeVO [b_name=" + b_name + ", bno=" + bno + ", writer=" + writer + "]";
	}


	
	
	
	
}
