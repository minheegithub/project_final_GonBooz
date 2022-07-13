package com.gb.wn.main.member.memberVO;

import java.util.Date;

public class MemberVO {
	
	private String membermail;
	private String userid;
	private String userpass;
	private String username;
	private Date regdate;
	
	
	
	public String getMembermail() {
		return membermail;
	}
	public void setMembermail(String membermail) {
		this.membermail = membermail;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpass() {
		return userpass;
	}
	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "MemberVO [userid=" + userid + ", userpass=" + userpass + ", username=" + username + ", regdate="
				+ regdate + "]";
	}
	
	
	
}
