package com.gb.wn.main.study.studyVO;

public class StudyVO {
	
	private int sno;
	private String open_id;
	private String study_member;
	private String study_name; //스터디 모임 이름
	private String study_tag; //스터디 종류 태그
	private String region; //오프라인 장소
	private int max_number; //인원 제한수 
	private int cur_number; //현재 참여인원
	private String study_email;//개설자 이메일
	
	public StudyVO() {};

	public String getStudy_email() {
		return study_email;
	}

	public void setStudy_email(String study_email) {
		this.study_email = study_email;
	}

	public StudyVO(int sno, String open_id, String study_member, String study_name, String study_tag, String region,
		int max_number, int cur_number, String study_email) {
		super();
		this.sno = sno;
		this.open_id = open_id;
		this.study_member = study_member;
		this.study_name = study_name;
		this.study_tag = study_tag;
		this.region = region;
		this.max_number = max_number;
		this.cur_number = cur_number;
		this.study_email = study_email;
	}

	public int getSno() {
		return sno;
	}

	public void setSno(int sno) {
		this.sno = sno;
	}


	public String getOpen_id() {
		return open_id;
	}


	public void setOpen_id(String open_id) {
		this.open_id = open_id;
	}


	public String getStudy_member() {
		return study_member;
	}


	public void setStudy_member(String study_member) {
		this.study_member = study_member;
	}


	public String getStudy_name() {
		return study_name;
	}


	public void setStudy_name(String study_name) {
		this.study_name = study_name;
	}


	public String getStudy_tag() {
		return study_tag;
	}


	public void setStudy_tag(String study_tag) {
		this.study_tag = study_tag;
	}


	public String getRegion() {
		return region;
	}


	public void setRegion(String region) {
		this.region = region;
	}


	public int getMax_number() {
		return max_number;
	}


	public void setMax_number(int max_number) {
		this.max_number = max_number;
	}


	public int getCur_number() {
		return cur_number;
	}


	public void setCur_number(int cur_number) {
		this.cur_number = cur_number;
	}

	@Override
	public String toString() {
		return "StudyVO [sno=" + sno + ", open_id=" + open_id + ", study_member=" + study_member + ", study_name="
				+ study_name + ", study_tag=" + study_tag + ", region=" + region + ", max_number=" + max_number
				+ ", cur_number=" + cur_number + ", study_email=" + study_email + "]";
	}

	
	
	
	
}
