package com.gb.wn.main.DAO;

import java.util.List;

import com.gb.wn.main.member.memberVO.MemberVO;

public interface MemberDAO {

	// 회원가입
		public void register(MemberVO vo) throws Exception;
		
		//로그인// xml에서 조회한 데이터들을 MemberVO에 담는다.
		public MemberVO getUserInfo(MemberVO vo) throws Exception;
		
		//회원정보 수정 
		public void memberUpdate(MemberVO vo) throws Exception;
		
		// 회원 탈퇴
		public void memberDelete(MemberVO vo)throws Exception;
		
		// 패스워드 체크
		public int passChk(MemberVO vo) throws Exception;
		
		// 아이디 중복체크
		public int idChk(MemberVO vo) throws Exception;
		
		
		// 비밀번호 변경
			
		public int update_pw(MemberVO vo) throws Exception;
		
		//이메일확인
		public MemberVO emailfind(MemberVO vo) throws Exception;
		
		// 아이디 찾기
		//public String find_id(String email) throws Exception;
		public List<MemberVO> find_id(String email) throws Exception;
		
		// 이메일 중복 검사
		public int check_email(String email) throws Exception;
	
		
}
