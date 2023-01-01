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
		// 로그인이 true
		if (request.getSession().getAttribute("login")!=null?(boolean)request.getSession().getAttribute("login"):false) {
			String view = new LmsService(request,response).service();
			if (view != null)
				getServletContext().getRequestDispatcher(view).forward(request,response);
		}
		// 관리자 로그인이 true
		else if (request.getSession().getAttribute("adminLogin")!=null?(boolean)request.getSession().getAttribute("adminLogin"):false) {
			String view = new LmsService(request,response).adminService();
			if (view != null)
				getServletContext().getRequestDispatcher(view).forward(request,response);
		}
		else {
			getServletContext().getRequestDispatcher("/lmsLogin").forward(request, response);
		}
	}
}
