package com.gb.wn.main.ServiceImpl;

import java.util.ArrayList;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gb.wn.boardUtil.CreateTable;
import com.gb.wn.boardUtil.DropTable;
import com.gb.wn.main.DAO.StudyDAO;
import com.gb.wn.main.Service.StudyService;
import com.gb.wn.main.study.studyVO.StudyVO;

//business logic 상세 작업 . @Controller나 dao의 내용을 service가 맡아서 한다. impl 확장성,유연성
@Service("StudyService")
public class StudyServiceImpl implements StudyService{
	
	@Autowired //StudyDAO를 스프링에 등록.객체 인자전달한 효과.
	private StudyDAO studyroom;
	
	@Resource(name="create_table")
	private CreateTable create_table;
	
	@Resource(name="drop_table")
	private DropTable drop_table;

	//등록된 모든 스터디 목록 조회
	@Override
	@Transactional
	public ArrayList<StudyVO> getAllStudy() throws Exception {
		//dao의 메소드를 찾아간다.
		return studyroom.getAllStudy();
	}

	@Override
	public void insertStudy(StudyVO studyVO1) {
		
		//스터디방 개설
		studyroom.insertStudy(studyVO1);	
		
		//개설한 방의 정보를 가져온다. (인덱스 번호를 알아오기 위해)
		StudyVO studyVO = studyroom.getStudyRoom1(studyVO1);
		
		//동적 테이블 생성
		String study_tag = studyVO.getStudy_tag();
		String sno = ""+studyVO.getSno();
		
		if(study_tag.equals("외국어")) {
			study_tag = "l";
		}else if(study_tag.equals("면접")) {
			study_tag = "i";
		}else if(study_tag.equals("스터디윗미")) {
			study_tag = "s";
		}else if(study_tag.equals("대외활동")) {
			study_tag = "a";
		}else if(study_tag.equals("자격증")) {
			study_tag = "c";
		}else if(study_tag.equals("공무원")) {
			study_tag = "p";
		}else if(study_tag.equals("기타")) {
			study_tag = "e";
		}
	
		String table_name = study_tag+sno;
		
		HashMap<String,String> map = null;
		map = create_table.create_bTable(table_name);
		studyroom.create_bTable(map);
		map = create_table.create_bSequence(table_name);
		studyroom.create_bSequence(map);
		map = create_table.create_rTable(table_name);
		studyroom.create_rTable(map);
		map = create_table.create_rSequence(table_name);
		studyroom.create_rSequence(map);//
		map = create_table.create_fTable(table_name);
		studyroom.create_fTable(map);
		map = create_table.create_fsequence(table_name);
		studyroom.create_fsequence(map);
		map = create_table.create_like(table_name);
		studyroom.create_like(map);
		
			
	}

	@Override
	public ArrayList <StudyVO> getStudy_region(StudyVO studyVO) {
		return studyroom.getStudy_region(studyVO);
	}

	@Override
	public ArrayList <StudyVO> getStudy_tag(StudyVO studyVO) {
		return studyroom.getStudy_tag(studyVO);
	}

	@Override
	public ArrayList <StudyVO> getStudy_name(StudyVO studyVO) {
		return studyroom.getStudy_name(studyVO);
	}
	
	//스터디룸 삭제
	@Override
	public void deleteStudy(StudyVO studyVO) {
		
		String study_tag = studyVO.getStudy_tag();
		String sno = ""+studyVO.getSno();
		
		if(study_tag.equals("외국어")) {
			study_tag = "l";
		}else if(study_tag.equals("면접")) {
			study_tag = "i";
		}else if(study_tag.equals("스터디윗미")) {
			study_tag = "s";
		}else if(study_tag.equals("대외활동")) {
			study_tag = "a";
		}else if(study_tag.equals("자격증")) {
			study_tag = "c";
		}else if(study_tag.equals("공무원")) {
			study_tag = "p";
		}else if(study_tag.equals("기타")) {
			study_tag = "e";
		}
	
		String table_name = study_tag+sno;
		
		HashMap<String,String> map = null;
		
		
		map = drop_table.drop_like(table_name);
		studyroom.drop_like(map);
		
		map = drop_table.drop_fsequence(table_name);
		studyroom.drop_fsequence(map);
		
		map = drop_table.drop_fTable(table_name);
		studyroom.drop_fTable(map);
		
		map = drop_table.drop_rSequence(table_name);
		studyroom.drop_rSequence(map);//
		
		map = drop_table.drop_rTable(table_name);
		studyroom.drop_rTable(map);
		
		map = drop_table.drop_bSequence(table_name);
		studyroom.drop_bSequence(map);
		
		map = drop_table.drop_bTable(table_name);
		studyroom.drop_bTable(map);
	
		studyroom.deleteStudy(studyVO);		
	}
	//select *가 mapper에 있다.
	//전부 가져와서 종이상자 = resultSet에 넣고 이것을 객체 단위로 해서 넘겨줄 것이다.

	@Override
	public void updateStudy(StudyVO studyVO) {
		studyroom.updateStudy(studyVO);
		
	}
	@Override
	public void outStudy(StudyVO studyVO) {
		studyroom.outStudy(studyVO);
		
	}

	@Override
	public StudyVO getStudyRoom(StudyVO studyVO) {	
		System.out.println("service impl"+studyVO.getSno());
		return studyroom.getStudyRoom(studyVO);
	}



	
	
}
