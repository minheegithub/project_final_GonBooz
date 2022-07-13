package com.gb.wn.main.Service;




import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gb.wn.main.board.boardVO.BoardVO;
import com.gb.wn.main.board.boardVO.LikeVO;
import com.gb.wn.main.board.boardVO.SearchCriteria;

public interface BoardService {

		// 게시글 작성
		public void boardWrite(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception;

		// 게시물 목록 조회
		public List<BoardVO> boardList(SearchCriteria scri) throws Exception;
		
		//게시물 총 갯수
		public int listCount(SearchCriteria scri) throws Exception;
		
		// 게시물 조회
		public BoardVO boardView(BoardVO boardVO) throws Exception;
		
		// 게시물 삭제
		public void boardDelete(BoardVO boardVO) throws Exception;
		
		// 첨부파일 조회
		public HashMap<String, Object> selectFileList(BoardVO boardVO) throws Exception;
		
		// 첨부파일 다운
		public HashMap<String, Object> selectFileInfo(HashMap<String, Object> map) throws Exception;
		
		//공지글
		public void gongziWrite(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception;

		public List<BoardVO> listGongzi() throws Exception;

		public BoardVO gongziView(BoardVO boardVO) throws Exception;

		public void gzDelete(BoardVO boardVO) throws Exception;
		
		//by최민희, 내아이디로 추천했는지 확인
		public int findlike(LikeVO likeVO);
		
		public int likeInsert(LikeVO likeVO);
		
}
