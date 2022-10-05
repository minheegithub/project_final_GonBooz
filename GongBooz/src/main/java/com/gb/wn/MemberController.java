package com.gb.wn;

import java.io.PrintWriter;

import java.util.Random;
import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.gb.wn.main.Service.MemberService;
import com.gb.wn.main.member.memberVO.MemberVO;

@Controller
public class MemberController {

	@Resource(name="memberService")
	private MemberService memkaja;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;	
	
	//로그인 화면으로 
	@RequestMapping(value="member/login.do")
	public String loginView(){
		return "member/login";
	}

	@RequestMapping(value="member/myinfo.do")
	public String infoView() throws Exception{
		return "member/myinfo";
	}
	
	//회원가입 화면으로 
	@RequestMapping(value="member/join.do")
	public String joinView(){
		return "member/register";
	}
	
	// 회원가입 get
	@RequestMapping(value = "member/register.do", method = RequestMethod.GET)
	public void getRegister() throws Exception {
	}
		
	// 회원가입 post
	@RequestMapping(value = "member/register.do", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception {
		System.out.println("회원가입");
		
		int result = memkaja.idChk(vo);
		System.out.println(result);
		try {
			if(result == 1) {
//				by최민희, 아이디가 존재하면 회원가입 창으로 돌아간다.
				return "member/register";
			}else if(result == 0) {
				String inputPass = vo.getUserpass();
				//by최민희, 회원가입 요청이 들어왔을때 비밀번호를 암호호화 하여 다시 vo에넣어 준다 .그리고 다시 회원가입 서비스를 실행한다. 
				String pwd = pwdEncoder.encode(inputPass);
				vo.setUserpass(pwd);
				memkaja.register(vo);
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}
	
		return "member/login";
	}
	//로그인
	@RequestMapping(value = "member/loginOk.do", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr, Model model) throws Exception{
		String loginok = "";
		HttpSession session = req.getSession();
		MemberVO getUserInfo = memkaja.getUserInfo(vo);//by최민희,해당 아이디의 정보가 있는지 확인한다.
		if(getUserInfo != null) {
			/*
			by최민희, 해당 아이디가 있다면 입력된 비밀번호와 암호화된 비밀번호를 비교한다.
			pwdEncoder.matches(입력된 비밀번호(), 암호화된 비밀번호())
			 */
			boolean pwdMatch = pwdEncoder.matches(vo.getUserpass(), getUserInfo.getUserpass());
			if(pwdMatch == true) {
				model.addAttribute("login", getUserInfo);//by최민희, 마이페이지로 들고갈 정보를 모델에 담는다.
				session.setAttribute("member", getUserInfo);
				loginok = "member/myinfo";
			}else {
				/*
				 by최민희, 비밀번호가 일치 하지 않아 다시 로그인 화면으로 돌아간다. 
				 */
				session.setAttribute("member", null);
				rttr.addFlashAttribute("msg", false);
				loginok = "redirect:/member/login.do";
			}
		}else {
			/*
			  by최민희, 입력한 아이디 정보가 존재하지 않아 다시 로그인 화면으로 돌아간다. 
			 */
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			loginok = "redirect:/member/login.do";
		}
		
		return loginok;
	}	
	
	@RequestMapping(value = "member/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		return "member/login";
	}
	
	@RequestMapping(value="member/memberUpdateView.do", method = RequestMethod.GET)
	public String registerUpdateView() throws Exception{
		System.out.println("회원수정");
		return "member/memberUpdateView";
	}
	
	//회원정보수정 패스워드 체크
	@ResponseBody
	@RequestMapping(value="member/passChk.do", method = RequestMethod.POST)
	public int passChk(MemberVO vo) throws Exception {
		int result = 0;
		//by최민희, 유저 아이디로 회원정보를 가져온다.이때 암호화한 아이디 그대로 들고온다.
		MemberVO getUserInfo = memkaja.getUserInfo(vo);
		//by최민희, 입력받은 비밀번호화 저장되어있던 암호화된 비밀번호가 일치하는지 확인한다.
		boolean pwdMatch = pwdEncoder.matches(vo.getUserpass(), getUserInfo.getUserpass());
		//by최민희, 일치하면 result값에 1을 넣고 일치하지 않으면 초기값 0 그대로 return하도록 한다.
		if(pwdMatch == true) {
			result = 1;
		}
		System.out.println("패스워드체크/"+result);
		return result;
	}

	//회원정보 수정 
	@RequestMapping(value="member/memberUpdate.do", method = RequestMethod.POST)
	public String registerUpdate(MemberVO vo, HttpServletRequest req, @RequestParam("newpass") String newpass) throws Exception{
		HttpSession session = req.getSession();
		//by최민희, 새롭게 입력받은 비밀번호를 암호화 한뒤 vo에 재 새팅한다.
		String pwd = pwdEncoder.encode(newpass);
		vo.setUserpass(pwd);
		//by최민희, 암호화한 비밀번호와 새롭게 입력받은 유저정보를 db에 저장한다.
		memkaja.memberUpdate(vo);
		//by최민희, 유저아이디로 유저정보 가져오기
		MemberVO member = memkaja.getUserInfo(vo);
		//by최민희, 새롭게 가져온 유저정보로 새션생성
		session.setAttribute("member", member);
		return "member/myinfo";
	}
	
	//by최민희, 회원 탈퇴 화면으로 가기get
	@RequestMapping(value="member/memberDeleteView.do", method = RequestMethod.GET)
	public String memberDeleteView() throws Exception{
		return "member/memberDeleteView";
	}
	
	//by최민희, 회원 탈퇴 post
	@RequestMapping(value="member/memberDelete.do", method = RequestMethod.POST)
	public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception{
	
		// 세션에 있는 member를 가져와 member변수에 넣어줍니다.
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		System.out.println("입력한 정보 :"+vo.toString());
		System.out.println("세션정보:"+member.toString());
		
		MemberVO login = memkaja.getUserInfo(member);
		
		//by민희, 입력한 비밀번호와 암호화되어 저장되어 있던 비밀번호를 복호화하여 비교해보자
		boolean pwdMatch = pwdEncoder.matches(vo.getUserpass(), login.getUserpass());
		if(pwdMatch == true) {
			memkaja.memberDelete(member);
			session.invalidate();
			System.out.println("회원탈톼");
		
			return "member/deleteOK";
		}else {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/member/memberDeleteView.do";
		}
	
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@RequestMapping(value="member/idChk.do", method = RequestMethod.POST)
	public int idChk(MemberVO vo) throws Exception {
//		by최민희, 아이디를 파리미터로 db테이블에서 count()함수를 이용해 저장된 아이디의
//		갯수를 들고온다. 아이디가 존재하면 1반환 없으면 0반환
		int result = memkaja.idChk(vo);
		return result;
	}
	
	/* 이메일 인증 */
	@RequestMapping(value="member/mailCheck", method=RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception{
		/* 뷰(View)로부터 넘어온 데이터 확인 */
				
		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 " + checkNum);
		/* 이메일 보내기 */
		String setFrom = "minhehot@naver.com"; ///////////////////////////////////자신의 이메일 입력
		String toMail = email;
		String title = "GongBooZ 회원가입 인증 이메일 입니다.";
		String content = "";
		
		content += "<div align='center' style='width: 440px; \r\n" + 
				"	overflow: hidden;\r\n" + 
				"	padding: 30px;\r\n" + 
				"	padding-top: 50px;\r\n" + 
				"	padding-bottom: 50px;\r\n" + 
				"	text-align: center; \r\n" + 
				"	border-radius: 4px;\r\n" + 
				"	box-shadow: 2px 5px 5px 0px, 5px 5px 5px 5px rgba(0, 0, 0, 0);margin: 0px auto;'>";
		content += "<h3>GoonBooZ를 방문해주셔서 감사합니다.<br><br>";
		content += "해당 인증번호를 인증번호 확인란에 기입하여 주세요.</h3>";
		content += "<p>인증 번호 <br><br> ";
		content += checkNum + "</p></div>";

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
		
		String num = Integer.toString(checkNum);
		return num;
		
	}
	
	@RequestMapping(value="member/findPw.do")
	public String findPwView(){
		return "member/findform";
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "member/find_pw.do", method = RequestMethod.POST)
	public void find_pw(@ModelAttribute MemberVO member, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String subject = "";
		String msg = "";
		// 아이디가 없으면
		if(memkaja.idChk(member) == 0) {
			out.print("아이디가 없습니다.");
			out.close();
		}
		// 가입에 사용한 이메일이 아니면
		else if(!member.getMembermail().equals(memkaja.emailfind(member).getMembermail())) {
			out.print("잘못된 이메일 입니다.");
			out.close();
		}else {	
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			String pwd = pwdEncoder.encode(pw);
			member.setUserpass(pwd);
			// 비밀번호 변경
			memkaja.update_pw(member);
			
			subject = "GongBooZ 임시 비밀번호 입니다.";
			msg += "<div align='center' style='width: 440px; \r\n" + 
					"	overflow: hidden;\r\n" + 
					"	padding: 30px;\r\n" + 
					"	padding-top: 50px;\r\n" + 
					"	padding-bottom: 50px;\r\n" + 
					"	text-align: center; \r\n" + 
					"	border-radius: 4px;\r\n" + 
					"	box-shadow: 2px 5px 5px 0px, 5px 5px 5px 5px rgba(0, 0, 0, 0);margin: 0px auto;'>";
			msg += "<h3>GongBooZ 알림<br><br>";
			msg += member.getUserid() + "님의 임시 비밀번호 입니다.<br> 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 <br><br> ";
			msg += pw + "</p></div>";

			// 받는 사람 E-Mail 주소
			String mail = member.getMembermail();
			String setFrom = "minhehot@naver.com"; ////////////////////////자신의 이메일 입력
			// 비밀번호 변경 메일 발송
			//send_mail(member, "find_pw");
			
			try {
				
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setFrom);
				helper.setTo(mail);
				helper.setSubject(subject);
				helper.setText(msg,true);
				mailSender.send(message);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
	
	}
	
	// 아이디 찾기
	@RequestMapping(value = "member/find_id.do", method = RequestMethod.POST)
	public String find_id(HttpServletResponse response, @RequestParam("membermail") String email, Model md) throws Exception{
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (memkaja.find_id(email).isEmpty()) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		}
		
		md.addAttribute("array", memkaja.find_id(email));		
		return "member/find_id";
		
	}
	
	// 이메일 중복 검사(AJAX)
	@RequestMapping(value = "member/check_email.do", method = RequestMethod.POST)
	public void check_email(@RequestParam("membermail") String email, HttpServletResponse response) throws Exception{
		PrintWriter out = response.getWriter();
		out.println(memkaja.check_email(email));
		out.close();
	}
	
}