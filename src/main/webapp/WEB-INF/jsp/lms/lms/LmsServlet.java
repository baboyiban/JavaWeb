package com.ezen.servlet.lms;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/lms")
public class LmsServlet extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		// 로그인이 true이고 cmd가 로그아웃이 아닐 때
		if (request.getSession().getAttribute("login")!=null?(boolean)request.getSession().getAttribute("login"):false) {
			String view = new LmsService(request,response).service();
			if (view != null)
				getServletContext().getRequestDispatcher(view).forward(request,response);
		} else {
			getServletContext().getRequestDispatcher("/lmsLogin").forward(request, response);
		}
	}
}
