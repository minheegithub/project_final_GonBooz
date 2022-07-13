package com.gb.wn.main.board.boardVO;

import java.sql.Timestamp;


public class BoardVO {

	private String b_name;
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Timestamp regdate;
	private int hit;
	private int recnt;//댓글 갯수
	private String stored_file_name = "n";//첨부파일 여부(초기값 파일이 없음을 표시하는 n값이 들어가 있다.)
	
	private int gno;//공지글 인덱스번호
	private String gongzi = "n";//공지글 여부
	
	private int likecount;
	
	public int getLikecount() {
		return likecount;
	}
	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
	public int getGno() {
		return gno;
	}
	public void setGno(int gno) {
		this.gno = gno;
	}
	public String getGongzi() {
		return gongzi;
	}
	public void setGongzi(String gongzi) {
		this.gongzi = gongzi;
	}
	public String getStored_file_name() {
		return stored_file_name;
	}
	public void setStored_file_name(String stored_file_name) {
		this.stored_file_name = stored_file_name;
	}
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	public int getRecnt() {
		return recnt;
	}
	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "BoardVO [b_name=" + b_name + ", bno=" + bno + ", title=" + title + ", content=" + content + ", writer="
				+ writer + ", regdate=" + regdate + ", hit=" + hit + ", recnt=" + recnt + ", stored_file_name="
				+ stored_file_name + ", gno=" + gno + ", gongzi=" + gongzi + ", likecount=" + likecount + "]";
	}
	
	
	
	
	
	

	
	
	
}
