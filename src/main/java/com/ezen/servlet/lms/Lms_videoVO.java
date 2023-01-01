package com.ezen.servlet.lms;

import java.util.Objects;

public class Lms_videoVO
{
	private String lms_num;
	private int lvl_code;
	private String fname;
	private String duration;
	private String description;
	
	public Lms_videoVO() {}

	public Lms_videoVO(String lms_num, int lvl_code, String fname, String duration, String description) {
		super();
		this.lms_num = lms_num;
		this.lvl_code = lvl_code;
		this.fname = fname;
		this.duration = duration;
		this.description = description;
	}

	@Override
	public String toString() {
		return "Lms_videoVO [lms_num=" + lms_num + ", lvl_code=" + lvl_code + ", fname=" + fname + ", duration="
				+ duration + ", description=" + description + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(description, duration, fname, lms_num, lvl_code);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Lms_videoVO other = (Lms_videoVO) obj;
		return Objects.equals(description, other.description) && Objects.equals(duration, other.duration)
				&& Objects.equals(fname, other.fname) && Objects.equals(lms_num, other.lms_num)
				&& lvl_code == other.lvl_code;
	}

	public String getLms_num() {
		return lms_num;
	}

	public void setLms_num(String lms_num) {
		this.lms_num = lms_num;
	}

	public int getLvl_code() {
		return lvl_code;
	}

	public void setLvl_code(int lvl_code) {
		this.lvl_code = lvl_code;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}