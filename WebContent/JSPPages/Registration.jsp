<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cloud.assign10.Constants"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/JSPPages/stylesheet.css" />
<title>Create User Page</title>
<%
	if (session.getAttribute(Constants.USERNAME) == null
			|| session.getAttribute(Constants.USERNAME) == "") {
		response.sendRedirect("/JSPPages/Login.jsp");
	} else {
		response.setHeader("Cache-Control",
				"no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

	}
%>
</head>
<body bgcolor="Teal">

	<div id="user" class="time">User:
	</div>
	<script type="text/javascript">
	var userame = '<%=session.getAttribute(Constants.USERNAME)%>';
	var html ="";
		if(userame.length!=0){
			html +=	'<span id="timetext" style="font-size:20px;">Welcome,'+userame+'</span>'		
			document.getElementById('user').innerHTML = html;
		}else{
			document.getElementById('user').innerHTML = "";
		}
	</script>
	<div id="header">
		<marquee width="100%"><h3>Welcome to Cloud 6331&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name:Sangram Bankar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section:3:30 PM</h3></marquee>
		
		
		<% if (session.getAttribute(Constants.USER_TYPE).equals("admin")) {%>
		<div class="Menu">

			<a href="/JSPPages/Registration.jsp">Create User</a>

		</div>
		<%}%>

	
		
		<%
			if (session.getAttribute(Constants.USERNAME) == null) {
		%>
		<div class="Menu">

			<a href="/JSPPages/Login.jsp">Login</a>

		</div><% }else{%>
	
		
		<div class="Menu">
			<a href="/JSPPages/UserProfile.jsp">Profile</a>
		</div>
		
	
		
		<div class="Menu">
			<a href="/JSPPages/Todo.jsp">ToDo</a>
		</div>	
		<div class="Menu">
			<a href="/JSPPages/feedServlet.jsp">Quiz</a>
		</div>
		
		<div class="Menu">
			<a href="/logoutServlet">Logout</a>
		</div>
		<%
			}
		%>

	</div>
	
		<div class="design" style="float:left; position:relative;">
		<form action="/registrationServlet"	method="POST" enctype="multipart/form-data">
			<p>
				<br> <span>Create User Form</span>
			</p>

			<div class="design1">
				<br> <br>
				<table>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Username</td>
						<td>:<input maxlength="30" placeholder="abc123"
							name="username" size="20" type="text" id="username" value="" required></td>
					</tr>
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UserType</td>
						<td>:
							<select id="usertype" name="usertype" required>
								<option  value="admin">Admin</option>
								<option  value="user">User</option>
							</select> 
						</td>
					</tr>
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Maximum No. of Photos Allowed</td>
						<td>:<input maxlength="10" placeholder="0"
							name="photototal" size="20" type="text" id="photototal" value=""
							onblur="" ></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Maximum No. of Notes Allowed</td>
						<td>:<input maxlength="10" placeholder="0"
							name="notetotal" size="20" type="text" id="notetotal" value=""
							onblur="" ></td>
					</tr>
									
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Password</td>
						<td>:<input maxlength="10" placeholder="Abc@123" value=""
							name="password" size="20" type="password" id="password"	onblur="" required>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose Your Image File</td>
						<td>:<input class="button1" id="img_url" type="file" name="img_url" onBlur="" value=""></td>
					</tr>
				</table>
				
				<div style="height:auto;">
				<table>
					<tr>
						<td><input class="button1" style="width:auto; font-size:18px;" name="Registration" type="submit" id="register" value="Create User" ></td>
					

					</tr>
				</table>
			</div>
			</div>
			
			</form>
		</div>
	
		<div class="design" style="float:right; position:relative;">
		</div>

</body>
</html>
