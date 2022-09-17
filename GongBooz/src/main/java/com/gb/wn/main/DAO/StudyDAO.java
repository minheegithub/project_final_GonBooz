package com.gb.wn.main.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.gb.wn.main.board.boardVO.BoardVO;
import com.gb.wn.main.study.studyVO.StudyVO;

//mapper interface 참조. dao에 선언한 것은 controller를 도와주기 위해.
public interface StudyDAO {
	ArrayList <StudyVO> getAllStudy();
	void insertStudy(StudyVO studyVO); //스터디 입력
	ArrayList <StudyVO> getStudy_region(StudyVO studyVO); //지역으로 스터디 찾기
	ArrayList <StudyVO> getStudy_tag(StudyVO studyVO); //태그로 스터디 찾기
	ArrayList <StudyVO> getStudy_name(StudyVO studyVO); //이름으로 스터디 찾기
		
	void deleteStudy(StudyVO studyVO); //스터디를 삭제한다.
	void updateStudy(StudyVO stuyVO); //참가인원이 변동될수록 수행된다.참여하시겠습니까? 탈퇴하시겠습니까?
	void outStudy(StudyVO stuyVO); //참가인원이 변동될수록 수행된다.참여하시겠습니까? 탈퇴하시겠습니까?
	
	StudyVO getStudyRoom(StudyVO studyVO);
	
	//7개의 테이블 생성(동적 테이블 생성) 
	void create_bTable(HashMap<String, String> map);
	void create_bSequence(HashMap<String, String> map);
	void create_rTable(HashMap<String, String> map);
	void create_rSequence(HashMap<String, String> map);
	void create_fTable(HashMap<String, String> map);
	void create_fsequence(HashMap<String, String> map);
	void create_like(HashMap<String, String> map);
	
	//스터디네임을 파라미터로 스터디룸 정보 가져오기
	StudyVO getStudyRoom1(StudyVO studyVO1);
	
	void drop_fsequence(HashMap<String, String> map);
	void drop_fTable(HashMap<String, String> map);
	void drop_rSequence(HashMap<String, String> map);
	void drop_rTable(HashMap<String, String> map);
	void drop_bSequence(HashMap<String, String> map);
	void drop_bTable(HashMap<String, String> map);
	void drop_like(HashMap<String, String> map);
	

	
}
//+ mybatis는 sqlsession 등 객체가 무조건 중요
