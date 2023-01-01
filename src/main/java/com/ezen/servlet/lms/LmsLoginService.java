package com.ezen.servlet.lms;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LmsLoginService {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private String path = "/WEB-INF/jsp/lms/";

	public LmsLoginService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	public String service() {
		String view = null;
		String cmd = request.getParameter("cmd");
		System.out.println("service() cmd:"+cmd);
		if (cmd == null) {
			view = path + "lmsLogin.jsp";
		} else if (cmd.equals("login")) {
			out(json("result",login()));
		} else if (cmd.equals("join")) {
			view = path + "lmsJoin.jsp";
		} else if (cmd.equals("joinUser")) {
			out(json("result",join()));
		} else if (cmd.equals("logout")) {
			out(json("result",logout()));
		} else if (cmd.equals("adminLogout")) {
			adminLogout();
			view = path + "lmsLogin.jsp";
		}
		return view;
	}

	private String login() {
		String result = "로그인 실패";
		String id = request.getParameter("id")!=null?request.getParameter("id"):"";
		String pwd = request.getParameter("pwd")!=null?request.getParameter("pwd"):"";
		String who = request.getParameter("who")!=null?request.getParameter("who"):"";
		if (who.equals("user")) {
			List<LmsUserVO> list = new LmsLoginDAO().getListUser();
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getUserid().equals(id) && list.get(i).getPwd().equals(pwd)) {
					request.getSession().setAttribute("login", true);
					request.getSession().setAttribute("id", list.get(i).getUserid());
					result = "사용자 로그인 성공";
					break;
				} else {
					result = "사용자 로그인 실패";
				}
			}
		} else if (who.equals("admin")) {
			List<LmsUserVO> list = new LmsLoginDAO().getListAdmin();
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getUserid().equals(id) && list.get(i).getPwd().equals(pwd)) {
					request.getSession().setAttribute("adminLogin", true);
					request.getSession().setAttribute("adminId", list.get(i).getUserid());
					result = "관리자 로그인 성공";
					break;
				} else {
					result = "관리자 로그인 실패";
				}
			}
		} else {
			result = "잘못된 로그인 접근";
		}
		return result;
	}
	private void out(String s) {
		try {
			response.getWriter().print(s);
			response.flushBuffer();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	private String json(String key, String value) {
		return "{\""+key+"\":\""+value+"\"}";
	}
	private String json(String key, int value) {
		return "{\""+key+"\":\""+value+"\"}";
	}
	private String join() {
		String result = "회원가입 실패";
		String id = request.getParameter("id")!=null?request.getParameter("id"):"";
		String pwd = request.getParameter("pwd")!=null?request.getParameter("pwd"):"";
		String phone = request.getParameter("phone")!=null?request.getParameter("phone"):"";
		String email = request.getParameter("email")!=null?request.getParameter("email"):"";
		LmsUserVO user = new LmsUserVO(id,pwd,phone,email);
		System.out.println("join() user:"+user);
		// user가 중복되지 않았을 때
		boolean b = new LmsLoginDAO().addUser(user);
		if (b) {
			result = "회원가입 성공";
		}
		return result;
	}
	private String logout() {
		String result = "로그아웃 실패";
		if (request.getSession().getAttribute("login")!=null) {
			request.getSession().setAttribute("login", false);
			result = "로그아웃 성공";
		}
		return result;
	}
	private void adminLogout() {
		if (request.getSession().getAttribute("adminLogin")!=null) {
			request.getSession().setAttribute("adminLogin", false);
		}
	}
}