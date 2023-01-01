package com.ezen.servlet.lms;

import java.util.Objects;

public class LmsUserVO {
	private String userid;
	private String pwd;
	private String phone;
	private String email;
	public LmsUserVO() {}
	public LmsUserVO(String userid, String pwd, String phone, String email) {
		this.userid = userid;
		this.pwd = pwd;
		this.phone = phone;
		this.email = email;
	}
	@Override
	public String toString() {
		return "LmsUserVO [userid=" + userid + ", phone=" + phone + ", email=" + email + "]";
	}
	@Override
	public int hashCode() {
		return Objects.hash(email, phone, userid);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LmsUserVO other = (LmsUserVO) obj;
		return Objects.equals(email, other.email) && Objects.equals(phone, other.phone)
				&& Objects.equals(userid, other.userid);
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
