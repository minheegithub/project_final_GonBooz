package com.gb.wn.main.board.boardVO;

public class SearchCriteria extends Criteria {

	private String board_name = "";
	private String searchType = "";
	private String keyword = "";
	 
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override
	public String toString() {
		return "SearchCriteria [board_name=" + board_name + ", searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
	
}
