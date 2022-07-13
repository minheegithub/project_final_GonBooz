package com.gb.wn.main.board.boardVO;

public class Criteria {

	private int page;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	//setter
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPage() {
		return page;
	}
	
	//getter
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public int getRowStart() {
		//by최민희, page=2 rowStart=11
		rowStart = ((page - 1) * perPageNum) + 1;
		return rowStart;
	}
	
	public int getRowEnd() {
		//by최민희, rowStart=11 rowEnd=20
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}
	
	//??????????????????????
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}
	

	public String toString1() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}


}
