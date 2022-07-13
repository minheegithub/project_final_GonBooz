package com.gb.wn.main.board.boardVO;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	
	private int totalCount;
	
	//by최민희, startPage, endPage, prev, next 필드값은 클래스 내부에서 계산한다.
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int displayPageNum = 10;
	private Criteria cri;
	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	//게시글 총 갯수
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public boolean isPrev() {
		return prev;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	
	public Criteria getCri() {
		return cri;
	}
	 
	//by최민희, startPage, endPage, prev, next 필드값 계산하는 메소드
	private void calcData() {
		//by최민희, Math.ceil(10.6) --> 10.6보다 크거나 같은 정수값 :  11
		/*
		 3page의 경우 0.3이므로 endPage가  크거나 같은 정수값 1이 나온다.
		 cri.getPage() / (double)displayPageNum --> 1.1 
		 Math.ceil(cri.getPage() / (double)displayPageNum) --> 2.0 --> endPage는 20이 되는 것이다.
		 */
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
	  
		int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		//by최민희,tempEndPage는 11 enePage는 20 일때 endPage에 11이 들어간다.
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		//by최민희,110 >= 104 ---> false
		//by최민희,100 >= 104 ---> true
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
		
	}
	//by최민희,검색할때 사용하는 메소드
	public String makeQuery(int page) {
		UriComponents uriComponents =
		UriComponentsBuilder.newInstance()
						    .queryParam("page", page)
							.queryParam("perPageNum", cri.getPerPageNum())//by최민희, 기본값 10세팅되어 있다. 
							.build();
		//by최민희,  URI값 문자열값 "?page=1&perPageNum=10" 을 리턴
//		System.out.println(uriComponents.toUriString()+"페이지메이커");
		return uriComponents.toUriString();
	}
	//by최민희,리스트 하단 페이징버튼에 사용되는 메소드, uri문자열을 리턴한다.
	public String makeSearch(int page){
		 UriComponents uriComponents =
		            UriComponentsBuilder.newInstance()
		            .queryParam("page", page)
		            .queryParam("perPageNum", cri.getPerPageNum())
		            .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
		            .queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))
		            .build(); 
		 
//		 by최민희,  ?page=1&perPageNum=10&searchType=w&keyword=spring
		 return uriComponents.toUriString();  
	}

	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) { 
			return "";
		}
		 
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch(UnsupportedEncodingException e) { 
			return ""; 
		}
	}
	
	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", cri=" + cri + "]";
	}
	
	
	
	
}
