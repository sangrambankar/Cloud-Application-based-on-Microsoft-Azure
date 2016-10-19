<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cloud.assign10.Constants"%>

<html style="height: 570px;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/JSPPages/stylesheet.css" />
<title>UserProfile Page</title>
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
	var time = <%=session.getAttribute("time")%>;

	var html ="";
		if(userame.length!=0){
			html +=	'<span id="timetext" style="font-size:20px;">Welcome,'+userame+'</span></br>'
			html +=	'<span>Time(in milli-seconds)taken for the operation: </span></br>'
			html +=	'<span id="timetext" style="font-size:20px;">'+time+'</span>'			
			document.getElementById('user').innerHTML = html;
		}else{
			document.getElementById('user').innerHTML = "";
		}
	</script>
		

	<div id="header">
		<marquee width="100%"><h3>Welcome to Cloud 6331&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name:Sangram Bankar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section:3:30 PM</h3></marquee>
		
		
		<% if (session.getAttribute(Constants.USER_TYPE) != null && session.getAttribute(Constants.USER_TYPE).equals("admin")) {%>
		<div class="Menu">

			<a href="/JSPPages/Registration.jsp">Create User</a>

		</div>
		<%}%>

		<%
			if (session.getAttribute(Constants.USERNAME) == null) {
		%>
		
		<div class="Menu">

			<a href="/JSPPages/Login.jsp">Login</a>

		</div>
		<%
			} else {
		%>
		<div class="Menu">
			<a href="/JSPPages/UserProfile.jsp">Profile</a>
		</div>
	
	
		
		<div class="Menu">
			<a href="/JSPPages/Todo.jsp">ToDo</a>
		</div>	
	
		<div class="Menu">
			<a href="/JSPPages/quiz.jsp">Quiz</a>
		</div>
		
		<div class="Menu">
			<a href="/logoutServlet">Logout</a>
		</div>
		<%
			}
		%>

		
		
	</div>
	

	<div style="height:100%;" class="design">
		
		<div style="border-radius:80px; width:100%"class="design1">
			<div class="profileimages">
				<img style="margin-top: 0px; padding:10px; border-radius:80px" src="<%=session.getAttribute(Constants.IMAGE)%>" />
			</div>
			<div class="details" style="height:auto;">
				<div class="designtable"
					style="margin-top: 10px; text-align: center; color:blue; margin-left: 5px;"><h1><%=session.getAttribute(Constants.USERNAME)%></h1></div>
				<table style="margin-top: 10px;"><%if(session.getAttribute(Constants.USER_TYPE)!=null){ %><tr><td>
					<h4>User Type</h4></td><td><h4>:<%=session.getAttribute(Constants.USER_TYPE)%></h4>
				</td></tr>
				<%} if(session.getAttribute(Constants.PHOTO_U)!=null){ %>
				<tr><td>
					<h4>Photo Used</h4></td><td><h4>:<%=session.getAttribute(Constants.PHOTO_U)%></h4>
				</td></tr>
				<%} if(session.getAttribute(Constants.PHOTO_T)!=null){ %>
				<tr><td>
					<h4>Photo Allowed</h4></td><td><h4>:<%=session.getAttribute(Constants.PHOTO_T)%></h4>
				</td></tr>
				<%} if(session.getAttribute(Constants.NOTE_U)!=null){ %>
				<tr><td>
					<h4>Note Used</h4></td><td><h4>:<%=session.getAttribute(Constants.NOTE_U)%></h4>
				</td></tr>
				<%} if(session.getAttribute(Constants.NOTE_T)!=null){ %>
				<tr>
				<td>
					<h4>Max. note allowed</h4></td><td><h4>:<%=session.getAttribute(Constants.NOTE_T)%></h4>
				</td>
				</tr><%}%>
			</table>
			
			<div class="">
				<table><tr><td><a href="/JSPPages/Retrieve.jsp"><input name="Update"
					type="submit"  class="button1"  value="Update"></a></td><td><a href="/deleteServlet"><input name="Delete"
					type="submit"  class="button1"  value="Delete"></a></td></tr>
				</table>
			</div>
			
			</div>
			
		</div>
	</div>
</body>
</html>
