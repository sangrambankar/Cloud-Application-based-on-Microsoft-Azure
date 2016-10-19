package com.cloud.assign10;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

import com.cloud.docdb.DocDbDao;
import com.cloud.docdb.DocumentClientFactory;
import com.cloud.docdb.ToDo;
import com.cloud.docdb.TodoDbDao;

public class EditTodoServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
		String todoname = null;
		String uid = null;
		String input_file=null;
		String todotype = null;
		String subject = null;
		String todourl = null;
		String priority = null;
		String date = null;
		String oldtodotype = null;
		String oldtodourl = null;
		String todoid = null;
		String oldtodoname = null;

		
		 List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
		 for(FileItem item : multiparts){
			if(!item.isFormField()){
				if(!item.getName().equals("")){
					input_file = FilenameUtils.getName(item.getName());
					InputStream file_content = item.getInputStream();
					File get_file = new File(input_file);
					FileUtils.copyInputStreamToFile(file_content,get_file);
					todoname = item.getName();
					todourl = DocumentClientFactory.getUploadUrl(get_file,null);
					System.out.println("url"+todourl);
				}else{
					todoname = null;
				}

			}else{
				String fieldName = item.getFieldName();
				String fieldValue = item.getString();
				
				if(fieldName.equals("editsubject")){
					subject = fieldValue;
				}else if(fieldName.equals("edittodotype")){
					todotype= fieldValue;
				}else if(fieldName.equals("editpriority")){
					priority = fieldValue;
				}else if(fieldName.equals("todoid")){
					todoid = fieldValue;
				}else if(fieldName.equals("oldtodotype")){
					oldtodotype = fieldValue;
				}else if(fieldName.equals("oldtodourl")){
					oldtodourl = fieldValue;
				}else if(fieldName.equals("editfilename")){
					oldtodoname = fieldValue;
				}
				
			}
		 }


		HttpSession session = req.getSession();
		ToDo todo = new ToDo();
		todo.setTodoid(todoid);	
		todo.setUid(""+session.getAttribute(Constants.UID));
		todo.setSubject(subject);
		todo.setTodotype(todotype);
	
		if(todoname==null){
			todo.setTodoname(oldtodoname);	
			todo.setTodourl(oldtodourl);
		}else{
			todo.setTodoname(todoname);
			todo.setTodourl(todourl);
		}
		System.out.println(oldtodoname+"url"+todoname);

		todo.setPriority(priority);
		todo.setDate(getCurrentTimeStamp());
		
		TodoDbDao db = new TodoDbDao();
		db.editTodo(todoid, todo);

		if(!todotype.equals(oldtodotype)){
			DocDbDao docdb = new DocDbDao();
			UserTable use = docdb.updateDeleteTodoItem(""+session.getAttribute(Constants.USERNAME),oldtodotype);
			UserTable user = docdb.updateTodoItem(""+session.getAttribute(Constants.USERNAME),todotype);
			String noteused = user.getNoteused();
			session.setAttribute(Constants.NOTE_U, noteused);
			String photoused = user.getPhotoused();
			session.setAttribute(Constants.PHOTO_U, photoused);
		}
		
		
		resp.sendRedirect("/JSPPages/Todo.jsp");

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		
		
	}


	public static String getCurrentTimeStamp() {
	    SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//dd/MM/yyyy
	    Date now = new Date();
	    String strDate = sdfDate.format(now);
	    return strDate;
	}
	
}
