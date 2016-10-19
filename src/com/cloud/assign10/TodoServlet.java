package com.cloud.assign10;

import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

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

public class TodoServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub

		
		try {
		String todoname = null,uid = null,input_file=null,todotype = null,subject = null,todourl = null,priority = null,date = null;

		 List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
		 for(FileItem item : multiparts){
			if(!item.isFormField()){
				input_file = FilenameUtils.getName(item.getName());
				InputStream file_content = item.getInputStream();
				File get_file = new File(input_file);
				FileUtils.copyInputStreamToFile(file_content,get_file);
				todoname = item.getName();
				todourl = DocumentClientFactory.getUploadUrl(get_file,null);
				System.out.println("url"+todourl);

			}else{
				String fieldName = item.getFieldName();
				String fieldValue = item.getString();
				
				if(fieldName.equals("subject")){
					subject = fieldValue;
				}else if(fieldName.equals("todotype")){
					todotype= fieldValue;
				}else if(fieldName.equals("priority")){
					priority = fieldValue;
				}
				
			}
		 }

		
		HttpSession session = req.getSession();
		ToDo todo = new ToDo();
		UUID toid = UUID.randomUUID();
		todo.setTodoid(toid+"");	
		todo.setUid(""+session.getAttribute(Constants.UID));
		todo.setSubject(subject);
		todo.setTodotype(todotype);
		todo.setTodoname(todoname);
		todo.setTodourl(todourl);
		todo.setPriority(priority);
		todo.setDate(getCurrentTimeStamp());
		
		TodoDbDao db = new TodoDbDao();
		db.createTodoItem(todo);

		DocDbDao docdb = new DocDbDao();
		UserTable user = docdb.updateTodoItem(""+session.getAttribute(Constants.USERNAME),todotype);
		String noteused = user.getNoteused();
		session.setAttribute(Constants.NOTE_U, noteused);
		String photoused = user.getPhotoused();
		session.setAttribute(Constants.PHOTO_U, photoused);
		
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
