package com.gb.wn.main.Service;

import java.util.ArrayList;

import com.gb.wn.main.study.studyVO.StudyVO;

//service에 선언한 것은 mapper를 도와주기 위해
public interface StudyService {	
	ArrayList <StudyVO> getAllStudy() throws Exception;
	void insertStudy(StudyVO studyVO);
	ArrayList <StudyVO> getStudy_region(StudyVO studyVO); //지역으로 스터디 찾기
	ArrayList <StudyVO> getStudy_tag(StudyVO studyVO); //태그로 스터디 찾기
	ArrayList <StudyVO> getStudy_name(StudyVO studyVO); //이름으로 스터디 찾기
	void deleteStudy(StudyVO studyVO);
	void updateStudy(StudyVO stuyVO); //잔여 인원 업데이트.
	void outStudy(StudyVO stuyVO); //잔여 인원 업데이트.
	StudyVO getStudyRoom(StudyVO studyVO);
	
	
	//service와 dao가 내용이 같다.
   
}
