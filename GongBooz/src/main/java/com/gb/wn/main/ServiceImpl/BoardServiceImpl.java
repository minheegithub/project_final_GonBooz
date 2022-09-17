package com.gb.wn.main.ServiceImpl;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gb.wn.boardUtil.FileUtils;
import com.gb.wn.main.DAO.BoardDAO;
import com.gb.wn.main.Service.BoardService;
import com.gb.wn.main.board.boardVO.BoardVO;
import com.gb.wn.main.board.boardVO.LikeVO;
import com.gb.wn.main.board.boardVO.SearchCriteria;

/*
 by최민희
 로직처리 : 내부에서 자바 로직을 처리함 
@Component 기능이 포함되어 있다.(빈객체 생성)
 */
@Service("boardService")
public class BoardServiceImpl implements BoardService {
		/*
		 by최민희
		 @Autowired 주입하려고 하는 객체의 타입이 일치하는지를 찾고 객체를 자동으로 주입한다. 
		 타입으로 연결안되면 이름
		 */
		@Autowired
		private BoardDAO bdao;

		/*
		by최민희, @Resource(name = 이름)과 같이 특정 이름을 지정하면 필드명이 아닌 지정한 이름의 빈을 찾아 자동 주입한다.
		지정한 이름의 컴포넌트를 자동주입하였다.
		이름으로 연결 안되면 타입
		*/
		@Resource(name="fileUtils")
		private FileUtils fileUtils;

		@Override
		public void boardWrite(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
			Map<String,Object> list = fileUtils.parseInsertFileInfo(boardVO, mpRequest); 
			
			if(list.isEmpty()){
				//by최민희, 파일이 넘어오지 않았을 경우 초기값 n이 db로 넘어간다.
				bdao.boardWrite(boardVO);
			}else {
				//by최민희, 파일 정보를 db에 저장
				bdao.insertFile(list);
				//by최민희, 파일 랜덤명을 vo에 저장
				boardVO.setStored_file_name((String)list.get("stored_file_name"));
				//by최민희, 게시글 저장(파일 랜덤명포함)
				bdao.boardWrite(boardVO);
				//by최민희, 방금 저장한 파일 랜덤명으로 위에서 생성된 게시글의 인덱스 번호를 들고온다.
				int bno = bdao.selectBno(boardVO);
				//by최민희, 인덱스 번호 vo에 세팅
				boardVO.setBno(bno);
				//by최민희, 인덱스번호를 파일 정보에 저장
				bdao.updateFile(boardVO);
				//by최민희, 인덱스 번호가 파일정보에 저장이 되어야 게시글을 조회할때 파일을 불러올 수 있다.
			}
			
		}
		
		@Override
		public List<BoardVO> boardList(SearchCriteria scri) throws Exception {
			return bdao.boardList(scri);
		}
		
		@Override
		public int listCount(SearchCriteria scri) throws Exception {
			return bdao.listCount(scri);
		}

		// 게시물 조회
		@Transactional(isolation = Isolation.READ_COMMITTED)
		@Override
		public BoardVO boardView(BoardVO boardVO) throws Exception {
			bdao.boardHit(boardVO);
			return bdao.boardView(boardVO);
		}

		@Override
		public void boardDelete(BoardVO boardVO) throws Exception {
			bdao.boardDelete(boardVO);
		}

		@Override
		public HashMap<String, Object> selectFileList(BoardVO boardVO) throws Exception {
			return bdao.selectFileList(boardVO);
		}

		// 첨부파일 다운로드
		@Override
		public HashMap<String, Object> selectFileInfo(HashMap<String, Object> map) throws Exception {
			return bdao.selectFileInfo(map);
		}

		@Override
		public void gongziWrite(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
			bdao.gongziWrite(boardVO);
			
		}

		@Override
		public List<BoardVO> listGongzi() throws Exception {
			return bdao.listGongzi();
		}

		@Override
		public BoardVO gongziView(BoardVO boardVO) throws Exception {
			bdao.gongziHit(boardVO);
			return bdao.gongziView(boardVO);
		}

		@Override
		public void gzDelete(BoardVO boardVO) throws Exception {
			bdao.gzDelete(boardVO);
			
		}

		@Override
		public int findlike(LikeVO likeVO) throws Exception  {
			return bdao.findLike(likeVO);
		}

		@Override
		public int likeInsert(LikeVO likeVO) throws Exception  {
			
			bdao.likeInsert(likeVO);
			bdao.UpdatelikeCnt(likeVO);
			return 0;
		}
		//스터디룸에서 해당 스터디게시판 최신글 3개 목록 미리보기
		@Override
		public List<BoardVO> getThreeList(BoardVO boardVO) throws Exception {
			return bdao.getThreeList(boardVO);
		}

}
