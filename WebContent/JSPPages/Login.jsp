<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cloud.assign10.Constants"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/JSPPages/stylesheet.css" />
<title>Login Page</title>
<%
	if (session.getAttribute(Constants.USERNAME) == null
			|| session.getAttribute(Constants.USERNAME) == "") {
		
	} else {
		response.sendRedirect("/JSPPages/UserProfile.jsp");
		response.setHeader("Cache-Control",
				"no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
	}
%>
</head>

<body bgcolor="">
	<div id="header">		
		<marquee width="100%"><h3>Welcome to Cloud 6331&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name:Sangram Bankar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section:3:30 PM</h3></marquee>
		
		<% if (session.getAttribute(Constants.USER_TYPE) != null && session.getAttribute(Constants.USER_TYPE).equals("admin")) {%>
		<div class="Menu">

			<a href="/JSPPages/Registration.jsp">Create User</a>

		</div>
		<%}%>
		
		<% if (session.getAttribute(Constants.USERNAME) == null) {
		 }else{%>

		<div class="Menu" style="width: 200px;">
			<a href="/JSPPages/UserProfile.jsp">Profile</a>
		</div>
	
		<div class="Menu">
			<a href="/logoutServlet">Logout</a>
		</div>
		<div class="Menu">
			<a href="/JSPPages/Todo.jsp">ToDo</a>
		</div>	
		<div class="Menu">
			<a href="/JSPPages/feedServlet.jsp">Quiz</a>
		</div>
		<%
			}
		%>

	</div>
	
	<form name="Login" action="/loginServlet" method="GET">

		<div class="design">
			<p>
				 <span>Login Form</span>
			</p>

			<div class="design1">
				
				<table>
					<tr>
						<td>Username</td>
						<td>:<input maxlength="30" name="username" size="20"
							type="text"></td>
					</tr>
	
					<tr>
						<td>Password</td>
						<td>:<input maxlength="10" name="password" size="20"
							type="password"></td>
					</tr>
				</table><br>
					<table style="height: 70px; width: 60%">
						<tr style="height: 50px; width: 450px">
								
						<td  align="right" style="height: 40px;"><input  class="button1" name="Login"type="submit" value="Login"></td>
					
					</tr></table>
				</div>
			</div>
	</form>

</body>
</html>


