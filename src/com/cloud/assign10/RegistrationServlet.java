package com.cloud.assign10;

import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.cloud.docdb.DocDbDao;
import com.cloud.docdb.DocumentClientFactory;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

public class RegistrationServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub

		
		try {
		String username = null,password = null,photototal = null,notetotal = null,usertype = null,input_file = null,url = null;

		 List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(req);
		 for(FileItem item : multiparts){
			if(!item.isFormField()){
				input_file = FilenameUtils.getName(item.getName());
				InputStream file_content = item.getInputStream();
				File get_file = new File(input_file);
				FileUtils.copyInputStreamToFile(file_content,get_file);
				url = DocumentClientFactory.getUploadUrl(get_file,null);
				System.out.println("url"+url);

			}else{
				String fieldName = item.getFieldName();
				String fieldValue = item.getString();
				
				if(fieldName.equals(Constants.USERNAME)){
					username = fieldValue;
				}else if(fieldName.equals(Constants.PASSWORD)){
					 password= fieldValue;
				}else if(fieldName.equals(Constants.PHOTO_T)){
					photototal = fieldValue;
				}else if(fieldName.equals(Constants.NOTE_T)){
					notetotal = fieldValue;
				}else if(fieldName.equals(Constants.USER_TYPE)){
					usertype = fieldValue;
				}
				
			}
		 }

		 
		
		UserTable user = new UserTable();
		UUID uid = UUID.randomUUID();
		user.setUid(uid+"");
		user.setUname(username);
		user.setPassword(password);
		user.setPhotototal(photototal);
		user.setPhotoused("0");
		user.setNotetotal(notetotal);
		user.setNoteused("0");
		user.setImageurl(url);
		user.setUsertype(usertype);
		
		
	

		DocDbDao db = new DocDbDao();
		db.createUserItem(user);

		resp.sendRedirect("/JSPPages/Registration.jsp");

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	
	
	
	
	}

	
	
}
