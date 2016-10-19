package com.cloud.assign10;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cloud.docdb.DocumentClientFactory;

/**
 * Servlet implementation class SaveText
 */
@WebServlet("/SaveText")
public class SaveTextServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		String textcontent = request.getParameter("textarea");
		String txtname = request.getParameter("txtname");
		FileOutputStream fop = null;
		File file;
		
		try {
			
			file = new File("newfile.txt");
			fop = new FileOutputStream(file);
			// if file doesnt exists, then create it
			if (!file.exists()) {
				file.createNewFile();
			}
			// get the content in bytes
			byte[] contentInBytes = textcontent.getBytes();

			fop.write(contentInBytes);
			fop.flush();
			fop.close();

			String todourl = DocumentClientFactory.getUploadUrl(file,txtname);

			response.sendRedirect("/JSPPages/Todo.jsp");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		}


}
