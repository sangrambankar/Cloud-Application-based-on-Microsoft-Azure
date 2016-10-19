package com.cloud.assign10;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cloud.docdb.DocDbDao;
import com.cloud.docdb.DocumentClientFactory;
import com.ecyrd.speed4j.StopWatch;
import com.microsoft.azure.documentdb.DocumentClient;


public class LoginServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp){
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();

		
		try {

		StopWatch stop = new StopWatch();
	
			
		String loginusername = req.getParameter(Constants.USERNAME);
		String loginpassword = req.getParameter(Constants.PASSWORD);
		
		DocDbDao db = new DocDbDao();
		UserTable usertable = db.readUserItem(loginusername);
		
		
		System.out.println(loginusername+"U"+usertable.getUname());
		if(usertable!=null){
		String uid = usertable.getUid();
		session.setAttribute(Constants.UID, uid);
		String username = usertable.getUname();
		session.setAttribute(Constants.USERNAME, username);
		String photoused = usertable.getPhotoused();
		session.setAttribute(Constants.PHOTO_U, photoused);
		String photototal = usertable.getPhotototal();
		session.setAttribute(Constants.PHOTO_T, photototal);
		String noteused = usertable.getNoteused();
		session.setAttribute(Constants.NOTE_U, noteused);
		String notetotal = usertable.getNotetotal();
		session.setAttribute(Constants.NOTE_T, notetotal);
		String img_url = usertable.getImageurl();
		session.setAttribute(Constants.IMAGE, img_url);
		String usertype = usertable.getUsertype();
		session.setAttribute(Constants.USER_TYPE, usertype);
		}
		if(loginusername.equals("admin")){
			session.setAttribute(Constants.USER_TYPE, "admin");
			session.setAttribute(Constants.USERNAME, loginusername);
		}
	
		stop.stop();
		session.setAttribute("time", stop.getElapsedTime());
		
		resp.sendRedirect("/JSPPages/UserProfile.jsp");
	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
