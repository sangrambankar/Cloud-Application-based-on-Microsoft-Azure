<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cloud.assign10.Constants"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/JSPPages/stylesheet.css" />
<title>Welcome Page</title>

</head>
<body >
	

		<div id="header">		
		<marquee width="100%"><h3>Welcome to Cloud 6331&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name:Sangram Bankar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section:3:30 PM</h3></marquee>
		
		
		<% if (session.getAttribute(Constants.USER_TYPE).equals("admin")) {%>
		<div class="Menu">

			<a href="/JSPPages/Registration.jsp">Create User</a>

		</div>
		<%}%>
		
		<% if (session.getAttribute(Constants.USERNAME) == null) {
		 }else{%>
		<div class="Menu">

			<a href="Index.jsp">Home</a>

		</div>
		<div class="Menu">
			<a href="/JSPPages/UserProfile.jsp">Profile</a>
		</div>
	
		<div class="Menu">
			<a href="/logoutServlet.jsp">Logout</a>
		</div>
		<div class="Menu">
			<a href="/JSPPages/Todo.jsp">ToDo</a>
		</div>	
		<div class="Menu">
			<a href="/JSPPages/feedServlet.jsp">Feeds</a>
		</div>
		<%
			}
		%>

	</div>

	

</body>
</html>
