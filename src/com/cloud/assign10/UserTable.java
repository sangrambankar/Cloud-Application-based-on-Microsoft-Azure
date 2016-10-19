package com.cloud.assign10;

import com.microsoft.azure.storage.table.TableServiceEntity;


public class UserTable {

	
	private String uid;
	private String uname;
	private String firstname;
	private String password;
	private String photoused;
	private String photototal;
	private String noteused;
	private String notetotal;
	private String usertype;
	private String imageurl;
	private String date;
      
	
	
	
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getPhotoused() {
		return photoused;
	}
	public void setPhotoused(String photoused) {
		this.photoused = photoused;
	}
	public String getPhotototal() {
		return photototal;
	}
	public void setPhotototal(String photototal) {
		this.photototal = photototal;
	}
	public String getNoteused() {
		return noteused;
	}
	public void setNoteused(String noteused) {
		this.noteused = noteused;
	}
	public String getNotetotal() {
		return notetotal;
	}
	public void setNotetotal(String notetotal) {
		this.notetotal = notetotal;
	}
	public String getImageurl() {
		return imageurl;
	}
	public void setImageurl(String imageurl) {
		this.imageurl = imageurl;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
 
	
	
	
	
}
