package com.gb.wn;

import java.util.ArrayList;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gb.wn.boardUtil.CreateTable;
import com.gb.wn.main.Service.StudyService;
import com.gb.wn.main.study.studyVO.StudyVO;

@Controller
public class StudyController {
	
//	private static final int HashMap = 0;
	@Resource(name="StudyService")
	private StudyService studyService;

	//전체 스터디 목록 조회
/*	@RequestMapping(value="/studyAll.do")
	public String studyAll(Model model) throws Exception{
		ArrayList <StudyVO> alist = studyService.getAllStudy();
		model.addAttribute("alist",alist);
		return "studyAll"; //studyAll.jsp에서 전부 출력
	}*/
	@RequestMapping(value="/studyAll.do", method = RequestMethod.GET)
	public String studyAll(Model model, HttpServletRequest req) throws Exception{
		String swiper = req.getParameter("swiper");
		ArrayList <StudyVO> alist = studyService.getAllStudy();
		model.addAttribute("alist",alist);
		//by최민희,js스와이퍼와면인가 일반 이미지 갤러리로 넘어가는 화면인가의 여부를 물어보는 값 넘기기
		model.addAttribute("swiper", swiper);
		model.addAttribute("selectTag","all");
		return "studyAll"; //studyAll.jsp에서 전부 출력
	}
	
//	@RequestMapping(value="/studyInsertForm.do")
//	public String studyInsertForm() throws Exception{
//		
//		System.out.println("방 개설하러 왔니?");
//		return "studyInsertForm";
//	}
	
	@RequestMapping(value="/studyInsert.do", method = RequestMethod.GET)
	public String studyInsert(StudyVO studyVO, Model model, HttpServletRequest req) throws Exception {
		String swiper = req.getParameter("swiper");
		studyService.insertStudy(studyVO);		
		model.addAttribute("swiper", swiper);
		return "redirect:/studyAll.do";
	}
	@RequestMapping(value="/studyfilter.do", method = RequestMethod.GET)
	public String studyfilter(StudyVO studyVO, Model model, @ModelAttribute("swiper") String swiper) throws Exception {
		System.out.println(studyVO.toString());
		if(studyVO.getStudy_tag().equals("all")) {
			ArrayList <StudyVO> alist = studyService.getAllStudy();
			model.addAttribute("alist",alist);
		}else {
			
			ArrayList <StudyVO> svo_tag = studyService.getStudy_tag(studyVO);
			model.addAttribute("alist",svo_tag);
		}
		model.addAttribute("selectTag",studyVO.getStudy_tag());
		return "studyAll";
	}
	
	@RequestMapping(value="/search-controller.do", method = RequestMethod.GET)
	public String studySearch(@ModelAttribute("studyVO") StudyVO studyVO, Model model, HttpServletRequest req) throws Exception {
		String filter = req.getParameter("filter");
		String search = req.getParameter("search");	
		String swiper = req.getParameter("swiper");
		System.out.println(swiper);
		
		String whatSearched = filter+"|"+search;
		model.addAttribute("whatSearched", whatSearched);
		model.addAttribute("swiper", swiper);
		
		if(filter.equals("study_name")) {
			studyVO.setStudy_name(search);
			ArrayList <StudyVO> svo_name = studyService.getStudy_name(studyVO);
			model.addAttribute("alist",svo_name);
			req.setAttribute("alist", svo_name);
			return "studyAll";
		}
		else if(filter.equals("study_tag")) {
			studyVO.setStudy_tag(search);
			ArrayList <StudyVO> svo_tag = studyService.getStudy_tag(studyVO);
			model.addAttribute("alist",svo_tag);
			req.setAttribute("alist", svo_tag);
			return "studyAll";
		}
		else if(filter.equals("region")) {
			studyVO.setRegion(search);
			ArrayList <StudyVO> svo_region = studyService.getStudy_region(studyVO);
			model.addAttribute("alist",svo_region);
			req.setAttribute("alist", svo_region);
			return "studyAll";
		}
		studyService.getAllStudy();	
		return "redirect:/studyAll";
		
	}
	//by최민희 studyalert창에서 새롭게 등록할때 들어오는 메소드
	@RequestMapping(value="/studyRoom.do", method = RequestMethod.POST)
	public String studyRoom(StudyVO studyVO, Model model) throws Exception{
		System.out.println("등록!");
		studyService.updateStudy(studyVO);
		StudyVO aa=studyService.getStudyRoom(studyVO);
		model.addAttribute("studyVO", aa);
		return "studyRoom";
	}
	
	//by최민희, studyalert창에서 기존 멤버가 입장할때 들어오는 메소드
	@RequestMapping(value="/enterRoom.do", method = RequestMethod.POST)
	public String enterRoom(StudyVO studyVO, Model model) throws Exception{
		System.out.println("입장!");
		StudyVO aa=studyService.getStudyRoom(studyVO);
		model.addAttribute("studyVO", aa);
		
		return "studyRoom";
	}
	
	//by최민희, 스터디멤버 강퇴, 퇴장
	@RequestMapping(value="/outStudy.do", method = RequestMethod.POST)
	public String outStudy(StudyVO studyVO, Model model, HttpServletRequest req) throws Exception{
		
		String userId = req.getParameter("user_id");
		System.out.println("유저아이디 : "+userId);
		//by최민희, 파라미터는 sno와 나갈 멤머인 studymember가 들어온다.
		String outMem = studyVO.getStudy_member();
		StudyVO aa = studyService.getStudyRoom(studyVO);//by최민희 파라미터 sno
		String bea[] = aa.getStudy_member().split("/");
		String saveMem = "";
		//by최민희, 나갈멤버를 제외하고 기존멤버 다시 저장
		for (int i = 1; i < bea.length; i++) {
			if(!outMem.equals(bea[i])) {
				saveMem += "/"+bea[i];
			}
		}
		System.out.println("saveMem : "+saveMem);
		
		//by최민희, 아웃된 스터디멤버를 제외한 나머지 멤버를 DB에 다시 저장한다.
		StudyVO reSave = new StudyVO();
		reSave.setSno(studyVO.getSno());
		reSave.setStudy_member(saveMem);
		
		studyService.outStudy(reSave);
		if(userId.equals(aa.getOpen_id())) {
			aa = studyService.getStudyRoom(studyVO);//by최민희, 파라미터 sno
			model.addAttribute("studyVO", aa);
			//by최민희, 강퇴일경우 스터디 방으로 다시 돌아감
			return "studyRoom";
		}else {
			System.out.println("탈퇴하러 옴");
			model.addAttribute("swiper", "y");
			//by최민희, 탈퇴일 경우 스터디개설방으로 간다.
			return "redirect:/studyAll.do";
		}
	}
	
	
	//진짜로 참여할 것인지 묻는다.
	@RequestMapping(value="/studyAlert.do",method = RequestMethod.POST)
	public String studyAlert(StudyVO studyVO, Model model) throws Exception{
		
		StudyVO aa=studyService.getStudyRoom(studyVO);
		model.addAttribute("studyVO",aa);
		return "studyAlert";
	}
	
	//by최민희, 스터디방 삭제
	@RequestMapping(value="/deleteStudy.do",method = RequestMethod.GET)
	public String deleteStudy(StudyVO studyVO, Model model, HttpServletRequest req) throws Exception{
		System.out.println("게시판 삭제 : "+studyVO.toString());
		String swiper = req.getParameter("swiper");
		studyService.deleteStudy(studyVO);
		model.addAttribute("swiper", swiper);
		return "redirect:/studyAll.do";
	}

	
}
