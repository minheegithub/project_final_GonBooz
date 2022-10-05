package com.gb.wn;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gb.wn.main.Service.BoardService;
import com.gb.wn.main.Service.StudyService;
import com.gb.wn.main.board.boardVO.BoardVO;
import com.gb.wn.main.study.studyVO.StudyVO;

@Controller
public class StudyController {
	
//	private static final int HashMap = 0;
	@Resource(name="StudyService")
	private StudyService studyService;
	
	@Resource(name="boardService")
	private BoardService boardkaja;
	
	@Autowired
	private JavaMailSender mailSender;

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

	@RequestMapping(value="/studyInsert.do", method = RequestMethod.GET)
	public String studyInsert(StudyVO studyVO, Model model, HttpServletRequest req) throws Exception {
		String swiper = req.getParameter("swiper");
		
		System.out.println("방개설 : "+studyVO.toString());
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
		
		studyService.updateStudy(studyVO);
		StudyVO aa=studyService.getStudyRoom(studyVO);
		
		/* 이메일 보내기 */
		String setFrom = "minhehot@naver.com"; ///////////////////////////////////자신의 이메일 입력
		String toMail = aa.getStudy_email();
		String title = "[GongBooZ] 개설하신 스터디 룸에 새로운 멤버가 등록했습니다.";
		String content = "";
		
		content += "<div align='center' style='width: 440px; \r\n" + 
				"	overflow: hidden;\r\n" + 
				"	padding: 30px;\r\n" + 
				"	padding-top: 50px;\r\n" + 
				"	padding-bottom: 50px;\r\n" + 
				"	text-align: center; \r\n" + 
				"	border-radius: 4px;\r\n" + 
				"	box-shadow: 2px 5px 5px 0px, 5px 5px 5px 5px rgba(0, 0, 0, 0);margin: 0px auto;'>";
		content += "<h3>GoonBooZ 스터디룸 개설자를 위한 발송 이메일 입니다.<br><br>";
		content += "개설하신 스터디룸 ["+aa.getStudy_name()+"] 방에  <br>새로운 멤버가 등록했습니다.</h3>";
		content += "<p>등록 멤버 아이디 <br><br> ";
		content += aa.getStudy_member().substring(1) + "</p></div>";

		try {
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		String study_tag = aa.getStudy_tag();
		int sno = aa.getSno();
		String b_name = "";
		if(study_tag.equals("외국어")){
			b_name = "l";
		}else if(study_tag.equals("면접")){
			b_name = "i";
		}else if(study_tag.equals("스터디윗미")){
			b_name = "s";
		}else if(study_tag.equals("대외활동")){
			b_name = "a";
		}else if(study_tag.equals("자격증")){
			b_name = "c";
		}else if(study_tag.equals("공무원")){
			b_name = "p";
		}else {
			b_name = "e";
		}
		
		BoardVO bvo = new BoardVO();
		bvo.setB_name(b_name+sno);
		//스터디룸에서 해당 스터디게시판 최신글 3개 목록 미리보기
		model.addAttribute("getThreeList", boardkaja.getThreeList(bvo));
		model.addAttribute("studyVO", aa);
		model.addAttribute("gongziList", boardkaja.listGongzi());
		
		return "studyRoom";
	}
	
	//by최민희, studyalert창에서 기존 멤버가 입장할때 들어오는 메소드
	@RequestMapping(value="/enterRoom.do", method = RequestMethod.POST)
	public String enterRoom(StudyVO studyVO, Model model) throws Exception{
		System.out.println("입장!");
		StudyVO aa = studyService.getStudyRoom(studyVO);
		System.out.println(aa.toString());
		
		String study_tag = aa.getStudy_tag();
		int sno = aa.getSno();
		String b_name = "";
		if(study_tag.equals("외국어")){
			b_name = "l";
		}else if(study_tag.equals("면접")){
			b_name = "i";
		}else if(study_tag.equals("스터디윗미")){
			b_name = "s";
		}else if(study_tag.equals("대외활동")){
			b_name = "a";
		}else if(study_tag.equals("자격증")){
			b_name = "c";
		}else if(study_tag.equals("공무원")){
			b_name = "p";
		}else {
			b_name = "e";
		}
		
		BoardVO bvo = new BoardVO();
		bvo.setB_name(b_name+sno);
		//스터디룸에서 해당 스터디게시판 최신글 3개 목록 미리보기
		model.addAttribute("getThreeList", boardkaja.getThreeList(bvo));
		model.addAttribute("studyVO", aa);
		model.addAttribute("gongziList", boardkaja.listGongzi());
		
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
