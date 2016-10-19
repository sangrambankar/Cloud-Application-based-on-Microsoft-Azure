package com.cloud.assign10;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class LogoutServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws IOException {

		res.setContentType("text/html");
		HttpSession session = req.getSession(true);
		session.invalidate();
		res.sendRedirect("JSPPages/Login.jsp");
	}
}