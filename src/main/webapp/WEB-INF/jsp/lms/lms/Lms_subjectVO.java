package com.ezen.servlet.lms;

import java.util.Objects;

public class Lms_subjectVO {
	private int lvl_code;
	private String subject_name;
	private String subject_description;
	public Lms_subjectVO() {
	}
	public Lms_subjectVO(int lvl_code, String subject_name, String subject_description) {
		super();
		this.lvl_code = lvl_code;
		this.subject_name = subject_name;
		this.subject_description = subject_description;
	}
	@Override
	public int hashCode() {
		return Objects.hash(lvl_code, subject_description, subject_name);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Lms_subjectVO other = (Lms_subjectVO) obj;
		return lvl_code == other.lvl_code && Objects.equals(subject_description, other.subject_description)
				&& Objects.equals(subject_name, other.subject_name);
	}
	@Override
	public String toString() {
		return "Lms_subjectVO [lvl_code=" + lvl_code + ", subject_name=" + subject_name + ", subject_description="
				+ subject_description + "]";
	}
	public int getLvl_code() {
		return lvl_code;
	}
	public void setLvl_code(int lvl_code) {
		this.lvl_code = lvl_code;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public String getSubject_description() {
		return subject_description;
	}
	public void setSubject_description(String subject_description) {
		this.subject_description = subject_description;
	}
}
