package com.gb.wn.boardUtil;

import java.util.HashMap;

import org.springframework.stereotype.Component;

@Component("drop_table")
public class DropTable {
	
	public HashMap<String,String> drop_like(String table_name) {
		
		String drop_like = "drop table "+table_name+"_like";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("drop_like",drop_like);
		return map;
		
	}

	public HashMap<String,String> drop_fsequence(String table_name) {
		
		String drop_fsequence = "drop sequence seq_"+table_name+"_file_no";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("drop_fsequence",drop_fsequence);
		return map;
	
	}
	
	public HashMap<String,String> drop_fTable(String table_name) {
		
		String drop_fTable = "drop table "+table_name+"_file";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("drop_fTable",drop_fTable);
		return map;
	
	}
	
	public HashMap<String,String> drop_rSequence(String table_name) {
		
		String drop_rSequence = "drop sequence "+table_name+"_reply_seq";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("drop_rSequence",drop_rSequence);
		return map;
	}
	
	public HashMap<String,String> drop_rTable(String table_name) {
		
		String drop_rTable = "drop table "+table_name+"_reply";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("drop_rTable",drop_rTable);
		return map;
	}
	
	public HashMap<String,String> drop_bSequence(String table_name) {
		
		String drop_bSequence = "drop sequence "+table_name+"_board_seq";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("drop_bSequence",drop_bSequence);
		return map;
	}
	
	public HashMap<String,String> drop_bTable(String table_name) {
		
		String drop_bTable = "drop table "+table_name+"_board";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("drop_bTable",drop_bTable);
		return map;
	
	}
	

}
