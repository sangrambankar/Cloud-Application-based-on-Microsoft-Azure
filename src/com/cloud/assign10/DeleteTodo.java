package com.cloud.assign10;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cloud.docdb.DocDbDao;
import com.cloud.docdb.TodoDbDao;

public class DeleteTodo extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		try {
		String todoid = req.getParameter("todoid");
		String todotype = req.getParameter("todotype");

		TodoDbDao tododb = new TodoDbDao();
		tododb.deleteTodoItem(todoid);
	
		HttpSession session = req.getSession();
		DocDbDao docdb = new DocDbDao();
		UserTable user = docdb.updateDeleteTodoItem(""+session.getAttribute(Constants.USERNAME),todotype);
		String noteused = user.getNoteused();
		session.setAttribute(Constants.NOTE_U, noteused);
		String photoused = user.getPhotoused();
		session.setAttribute(Constants.PHOTO_U, photoused);
		
		resp.sendRedirect("/JSPPages/Todo.jsp");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
}
