package com.gb.wn.main.DAO;

import java.util.List;

import com.gb.wn.main.board.boardVO.BoardVO;
import com.gb.wn.main.board.boardVO.ReplyVO;


public interface ReplyDAO {

	public List<ReplyVO> readReply(BoardVO boardVO) throws Exception;
	
	public void writeReply(ReplyVO vo) throws Exception;
	
	public void updateReply(ReplyVO vo) throws Exception;
	
	public void deleteReply(ReplyVO vo) throws Exception;
	
	public ReplyVO selectReply(ReplyVO vo) throws Exception;
	
	public void replyCnt(ReplyVO vo) throws Exception;
	
	
}
