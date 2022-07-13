package com.gb.wn.boardUtil;

import java.util.HashMap;

import org.springframework.stereotype.Component;

@Component("create_table")
public class CreateTable {

	public CreateTable() {
	
	}
	
	public HashMap<String,String> create_bTable(String table_name) {
		
		//게시판 테이블 쿼리문
		String create_bTable = "create table "+table_name+"_board("
				+ "bno number not null," + 
				" title varchar2(100) not null," + 
				" content clob not null," + 
				" writer varchar2(100) not null," + 
				" regdate date default sysdate," + 
				" primary key(bno)," + 
				" HIT NUMBER DEFAULT 0," + 
				" recnt number default 0 not null," + 
				" stored_file_name varchar2(100)," + 
				" likecount number default 0 not null" + 
				")";
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("create_bTable",create_bTable);
		return map;
		
	}
	
	public HashMap<String,String> create_bSequence(String table_name) {
		//by최민희, 게시판 인덱스 시퀀스 쿼리문
		String create_bSequence = "create sequence "+table_name+"_board_seq start with 1 " + 
				"increment by 1";
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("create_bSequence",create_bSequence);
		return map;
		
	}
	
	public HashMap<String,String> create_rTable(String table_name) {
		
		//by최민희,게시판 댓글 테이블 쿼리문
		String create_rTable = "create table "+table_name+"_reply("
				+ "bno number not null," + 
				"    rno number not null," + 
				"    content varchar2(1000) not null," + 
				"    writer varchar2(50) not null," + 
				"    regdate date default sysdate," + 
				"    primary key(rno)," + 
				"    constraint "+table_name+"_reply_bno foreign key(bno) references "+table_name+"_board(bno) on delete cascade" + 
				")";
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("create_rTable",create_rTable);
		return map;
	}
	
	public HashMap<String,String> create_rSequence(String table_name) {
		
		//by최민희, 게시판 댓글 인덱스 시퀀스 쿼리문
		String create_rSequence = "create sequence "+table_name+"_reply_seq start with 1 minvalue 0";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("create_rSequence",create_rSequence);
		return map;
	}
	
	public HashMap<String,String> create_fTable(String table_name) {
		//by최민희, 게시판 파일 테이블 쿼리문
		String create_fTable = "create table "+table_name+"_file" + 
				"(" + 
				"    file_no number," + 
				"    bno number not null," + 
				"    org_file_name varchar2(260) not null," + 
				"    stored_file_name varchar2(36) not null," + 
				"    file_size number," + 
				"    regdate date default sysdate not null," + 
				"    primary key(file_no)" + 
				")";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("create_fTable",create_fTable);
		return map;

	}
	
	public HashMap<String,String> create_fsequence(String table_name) {
		//by최민희, 게시판 파일 시퀀스 
		String create_fsequence = "create sequence seq_"+table_name+"_file_no " + 
				"start with 1 " + 
				"increment by 1 " + 
				"nomaxvalue nocache";
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("create_fsequence",create_fsequence);
		return map;
		
	}
	public HashMap<String,String> create_like(String table_name) {
		//by최민희, 게시판 파일 시퀀스 
		String create_like = "create table "+table_name+"_like(" + 
				"    bno number not null," + 
				"    writer varchar2(100) not null," + 
				"    constraint "+table_name+"_like_bno foreign key(bno) references "+table_name+"_board(bno) on delete cascade" + 
				")";
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("create_like",create_like);
		return map;
		
	}
}
