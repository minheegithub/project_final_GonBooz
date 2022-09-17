package com.gb.wn.main.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.gb.wn.main.board.boardVO.BoardVO;
import com.gb.wn.main.board.boardVO.LikeVO;
import com.gb.wn.main.board.boardVO.SearchCriteria;
/*
 담당:최민희
SQL문을 사용하는 방식중 XML만을 이용하는 방식을 사용.
 XML만을 이용해서 SQL문을 설정한다. DAO에서는 XML을 찾아서 실행하는 코드를 작성한다.
 장점은 SQL문이 별도의 XML로 작성되기 때문에 SQL문의 수정이나 유지보수에 적합하다.
 단점은 개발시 코드의 양이 많아지고 복잡성이 증가.
 */
public interface BoardDAO {

		// 게시글 작성
		public void boardWrite(BoardVO boardVO) throws Exception;
		
		// 게시물 목록 
		public List<BoardVO> boardList(SearchCriteria scri) throws Exception;
		
		//게시물 총 갯수
		public int listCount(SearchCriteria scri) throws Exception;
		
		// 게시물 조회
		public BoardVO boardView(BoardVO boardVO) throws Exception;
		
		// 게시물 삭제
		public void boardDelete(BoardVO boardVO) throws Exception;
		
		// 첨부파일 업로드
//		public void insertFile(List<Map<String, Object>> map) throws Exception;
		public void insertFile(Map<String, Object> map) throws Exception;

		// 첨부파일 조회
		public HashMap<String, Object> selectFileList(BoardVO boardVO) throws Exception;
		
		// 첨부파일 다운
		public HashMap<String, Object> selectFileInfo(HashMap<String, Object> map) throws Exception;
		
		// 게시판 조회수
		public void boardHit(BoardVO boardVO) throws Exception;

		public int selectBno(BoardVO boardVO) throws Exception;

		public void updateFile(BoardVO boardVO) throws Exception;

		public void gongziWrite(BoardVO boardVO) throws Exception;

		public List<BoardVO> listGongzi() throws Exception;

		public BoardVO gongziView(BoardVO boardVO) throws Exception;

		public void gongziHit(BoardVO boardVO) throws Exception;

		public void gzDelete(BoardVO boardVO) throws Exception;

		public int findLike(LikeVO likeVO) throws Exception;

		public void likeInsert(LikeVO likeVO) throws Exception;

		public void UpdatelikeCnt(LikeVO likeVO) throws Exception;
		
		// 스터디룸에서 게시물 목록 미리보기
		public List<BoardVO> getThreeList(BoardVO boardVO) throws Exception;

}
