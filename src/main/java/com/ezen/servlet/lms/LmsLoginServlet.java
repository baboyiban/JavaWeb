package com.ezen.servlet.lms;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/lmsLogin")
public class LmsLoginServlet extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		String view = new LmsLoginService(request,response).service();
		if (view != null) {
			getServletContext().getRequestDispatcher(view).forward(request, response);
		}
	}
}
