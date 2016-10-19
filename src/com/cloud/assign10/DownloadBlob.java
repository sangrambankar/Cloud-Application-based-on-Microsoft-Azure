package com.cloud.assign10;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cloud.docdb.DocumentClientFactory;

public class DownloadBlob extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		resp.setContentType("text/html;charset=UTF-8");

		try {
			PrintWriter out = resp.getWriter();
			String fname = req.getParameter("fname");
			String path = DocumentClientFactory.getDownloadFile(req, fname);
			String contents = new String(Files.readAllBytes(Paths.get(path)));
			out.println(contents);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	
}
