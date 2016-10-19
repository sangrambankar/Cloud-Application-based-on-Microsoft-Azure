<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.cloud.assign10.Constants"
		import="com.cloud.docdb.ToDo"
		import="com.cloud.docdb.TodoDbDao"
		import="java.util.List"%>
		

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Cp1252" />
<link type="text/css" rel="stylesheet" href="/JSPPages/stylesheet.css" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.3.js" /></script>
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js " /></script>
	<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" type="text/css" rel="stylesheet">
<title>ToDo</title>
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
<script type="text/javascript">

//binds to onchange event of the input field
function uploadEnable() {
		var input = document.getElementById("fileurl").value;
		var myFile = document.getElementById("fileurl");
		myFile.addEventListener('change', function() {
		  //this.files[0].size gets the size of your file.
		 // alert(this.files[0].size);

		var max_img_size=1000;
		          
		
		if (this.files[0].size > max_img_size*1024) 
		{
			document.getElementById("addTodo").disabled = true;
			alert("The file must be less than " + (max_img_size) + "KB");
			return false;
		}else{
			document.getElementById("addTodo").disabled = false;
			//return true;
		}
		
		var e = document.getElementById("todotype");
		var strUser = e.options[e.selectedIndex].text;
		if(strUser == 'Picture'){			
			var used = <%=session.getAttribute(Constants.PHOTO_U)%>
			var max = <%=session.getAttribute(Constants.PHOTO_T)%>
			if (used < max) {
				document.getElementById("addTodo").disabled = false;
				return true;
			}else{
				alert("Maximum Photo Limit reached!");
				document.getElementById("addTodo").disabled = true;
				return false;
			}
		}else{
			var used = <%=session.getAttribute(Constants.NOTE_U)%>
			var max = <%=session.getAttribute(Constants.NOTE_T)%>
			if (used < max) {
				document.getElementById("addTodo").disabled = false;
				return true;
			}else{
				alert("Maximum Note Limit reached!");
				document.getElementById("addTodo").disabled = true;
				return false;
			}
		}
		
		
		});

}

function ondeletephoto(pid,todotype){
	
	alert("Your post is being deleted, cant be undone");
	if (window.XMLHttpRequest) {
		request = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		request = new ActiveXObject("MicroSoft.XMLHTTP");
	}
	var parameters = "todoid="+pid+"&todotype="+todotype;
	try {
		request.open("POST", '/deletetodoServlet' , true);
		request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		request.send(parameters);
	} catch (e) {
		alert(e)
		alert("Unable to connect server");
	}
}

</script>

<script type="text/javascript">

	$(document).ready(function() {
		$('#example').DataTable( {
			"order": [[ 4, "desc" ]]
		} );
		
		 $('#example tfoot th').each( function () {
		var title = $(this).text();
			$(this).html( '<input type="text" style="width:100%;" placeholder=" '+title+'" />' );
		} );
	 
		// DataTable
		var table = $('#example').DataTable();
	 
		// Apply the search
		table.columns().every( function () {
			var that = this;
	 
			$( 'input', this.footer() ).on( 'keyup change', function () {
				if ( that.search() !== this.value ) {
					that
						.search( this.value )
						.draw();
				}
			} );
		} );
		} );
	function onComment(pid){
		
		if (window.XMLHttpRequest) {
			request = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			request = new ActiveXObject("MicroSoft.XMLHTTP");
		}
		var parameters = "pid="+pid;
		try {
			request.open("POST", '/commentServlet' , true);
			request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			request.send(parameters);
		} catch (e) {
			alert(e)
			alert("Unable to connect server");
		}
	}
	
	function ShowEditDialog(id,subject,type,name,url,priority){
		$("#overlay").show();
		$("#dialog").fadeIn(300);
		$("#result").hide();
		$("#textedt").hide();

		$("#editdisplay").show();

		document.getElementById("todoid").value =id ;
		document.getElementById("oldtodotype").value =type ;
		document.getElementById("oldtodourl").value =url ;
		alert(id);
		document.getElementById("editsubject").value =subject ;
		document.getElementById("edittodotype").value=type;
		document.getElementById("editfilename").value =name;
		document.getElementById("editpriority").value = priority ;
			
		$("#overlay").click(function (e)
		{
			HideDialog();
		});
		$("#btnClose").click(function (e)
		{
			HideDialog();
		});
		$("#cancelEditTodo").click(function (e)
		{
			HideDialog();
		});
		
		
		return false;
	}
	
	function ShowDialog(furl,fname,ttype)
	{
		$("#editdisplay").hide();
		//document.getElementById("info").innerHTML = "";
		//document.getElementById("info").innerHTML = pid;
		if(ttype=='Text'){
			if (window.XMLHttpRequest) {
				request = new XMLHttpRequest();
			} else if (window.ActiveXObject) {
				request = new ActiveXObject("MicroSoft.XMLHTTP");
			}
			var parameters = "fname="+fname;
			try {
				request.open("POST", '/downloadServlet' , true);
				request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				request.send(parameters);
				alert(response);
				var response = request.responseText;
				var html = "<textarea name='textarea' rows='25' cols='59'>"+response+"</textarea>"
				$("#result").html(html);
				document.getElementById("txtname").value = fname;

			} catch (e) {
				alert(e)
				alert("Unable to connect server");
			}
		}else{
			var html = "<img style='margin-top: 2px; margin-left: 2px;'	class='feedimage' src='"+ furl +"'/>";
			$("#result").html(html);
		}
		
		
		$("#overlay").show();
		$("#dialog").fadeIn(300);
	
		$("#overlay").click(function (e)
		{
			HideDialog();
		});
	
		$("#btnClose").click(function (e)
		{
			HideDialog();
		});
	
	}

	function HideDialog()
	{
		$("#overlay").hide();
		$("#dialog").fadeOut(300);
		$("#editdisplay").hide();
	} 

        
</script>
<body>
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
			if (session.getAttribute(Constants.USERNAME) != null) {
		%>
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
		<div class="design" style="float:left; position:relative; width:40%;">
			<p>
			<span style="color:#ffffff;">Add Todo</span>
			<p class="Menu" style="width: auto; padding:2px; positon:absolute; z-index:99999; float:right; margin-right:79px;"> 
					Photo:<%=session.getAttribute(Constants.PHOTO_U)%>/<%=session.getAttribute(Constants.PHOTO_T)%>
			</p>
			<p class="Menu" style="width: auto; padding:2px; positon:absolute; z-index:99999; float:right; margin-right:79px;"> 
					Notes: <%=session.getAttribute(Constants.NOTE_U)%>/<%=session.getAttribute(Constants.NOTE_T)%>
			</p>

			</p>
		<form action="/todoServlet"	method="POST" enctype="multipart/form-data">

			<div class="design1"style="width:auto;padding-bottom:15px">
				<br> <br>
				<table>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subject</td>
						<td>:<input maxlength="30" placeholder="abc123"
							name="subject" size="20" type="text" id="subject" value="" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type</td>
						<td>:
							<select id="todotype" name="todotype" required>
								<option  value="Picture">Picture</option>
								<option  value="Text" selected="selected">Text</option>
							</select> 
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose File</td>
						<td>:<input style="padding:10px 10px;" class="button1" id="fileurl" type="file" onclick="uploadEnable()" name="fileurl" onBlur="" value="" required></td>
					</tr>
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Priority</td>
						<td>:
							<select id="priority" name="priority" required>
								<option  value="1">1</option>
								<option  value="2">2</option>
								<option  value="3">3</option>
								<option  value="4">4</option>
								<option  value="5">5</option>
								<option  value="6">6</option>
								<option  value="7">7</option>
								<option  value="8">8</option>
								<option  value="9">9</option>
								<option  value="10">10</option>
							</select> 
						</td>
					</tr>
					
										
				</table>
				
				<div style="height:auto;">
					<input class="button1" style="width:auto; font-size:18px;" name="addTodo" type="submit" id="addTodo" value="Add Todo" disabled></td>
				</div>
			</div>
			
			</form>
		</div>
	
		<div class="design" style="float:right; position:relative;width:60%; height:auto;">
			
		
				<table id="example" class="display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>Subject</th>
							<th>Name</th>
							<th>Priority</th>
							<th>Type</th>
							<th>Date</th>
							<th>Function</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>Subject</th>
							<th>Name</th>
							<th>Priority</th>
							<th>Type</th>
							<th>Date</th>
							<th>Function</th>
						</tr>
					</tfoot>
					 <tbody>
				<% 
				TodoDbDao tododb = new TodoDbDao();
				List<ToDo> list = tododb.readAllTodoItems();
				if(list.size()>0){
					for(ToDo todo : list) {
						String todoid = todo.getTodoid();
						String subject = todo.getSubject();
						String name = todo.getTodoname();
						String priority = todo.getPriority();
						String ttype = todo.getTodotype();
						String todourl = todo.getTodourl();
						String tdate = todo.getDate();				
				%>
				<tr name="pid" value="<%= todoid %>" id="<%= todoid %>">
						<td><%= subject %></td>
						<td><a onClick="ShowDialog('<%= todourl %>','<%= name %>','<%= ttype %>')" href="#" ><%= name %></a></td>
						<td><%= priority %></td>
						<td><%= ttype %></td>
						<td><%= tdate %></td>
						
						<td>
						<a class="edit" onclick="ShowEditDialog('<%= todoid %>','<%= subject %>','<%= ttype %>','<%= name %>','<%= todourl %>','<%= priority %>')" style="font-size:1.5em;"></a>
						<a href="" onclick="ondeletephoto('<%= todoid %>','<%= ttype %>')" class="delete" style="font-size:1.5em;"></a >
						</td>
				</tr>
				<% } 
				}else{
				%>
				
				<%
				}
				%>	
					
					
					
				 </tbody>
				</table>
		
		</div>

	<div id="overlay" class="web_dialog_overlay"></div>
   
	<div id="dialog" class="web_dialog">
		<table style="width: 100%; border: 0px;" cellpadding="3" cellspacing="0">
		  <tr>
			 <td class="web_dialog_title">Result</td>
			 <td class="web_dialog_title align_right">
				<a href="#" id="btnClose">Close</a>
			 </td>
		  </tr>
		</table>
		<div id="textedt" style="height:100%; background-color:#ffffff;">
		<form action="/saveText"	method="GET" enctype="multipart/form-data">
			<span id="result" ></span>
			<input id="txtname" name="txtname" style = "display:none;"></input>
			<div style="height:auto; background-color:#ffffff;">
						<input class="button1" style="width:auto; font-size:18px;" name="editTodotext" type="submit" id="editTodotext" value="Save Changes">&nbsp;&nbsp;
			</div>
		</form>
		</div>

		<div id="editdisplay" class="design" style="width:100%;">
			<form action="/edittodoServlet"	method="POST" enctype="multipart/form-data">

			<div class="design1"style="width:auto;padding-bottom:15px">
				<table>
					<input style="display:none;" type="text" id="todoid" name="todoid"></input>
					<input style="display:none;" type="text"  id="oldtodourl" name="oldtodourl"></input>
					<input style="display:none;" type="text"  id="oldtodotype" name="oldtodotype"></input>
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subject</td>
						<td>:<input maxlength="30" placeholder="abc123"
							name="editsubject" size="20" type="text" id="editsubject" value="" required></td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type</td>
						<td>:
							<select id="edittodotype" name="edittodotype" required>
								<option  value="Picture">Picture</option>
								<option  value="Text" selected="selected">Text</option>
							</select> 
						</td>
					</tr>
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Uploaded File Name</td>
						<td>:<input style="padding:10px 10px;" id="editfilename" type="text" onclick="" name="editfilename" onBlur="" value="" required ></td>
					</tr>
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Change File</td>
						<td>:<input style="padding:10px 10px;" class="button1" id="editfileurl" type="file" onclick="uploadEnable()" name="editfileurl" onBlur="" value="" ></td>
					</tr>
					
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Priority</td>
						<td>:
							<select id="editpriority" name="editpriority" required>
								<option  value="1">1</option>
								<option  value="2">2</option>
								<option  value="3">3</option>
								<option  value="4">4</option>
								<option  value="5">5</option>
								<option  value="6">6</option>
								<option  value="7">7</option>
								<option  value="8">8</option>
								<option  value="9">9</option>
								<option  value="10">10</option>
							</select> 
						</td>
					</tr>
					
										
				</table>
				
				<div style="height:auto;">
					<input class="button1" style="width:auto; font-size:18px;" name="editaddTodo" type="submit" id="editaddTodo" value="Save Changes">
					<input class="button1" style="width:auto; font-size:18px;" name="cancelEditTodo" type="submit" id="cancelEditTodo" value="Cancel">
				</div>
			</div>
			
			</form>
		</div>
	</div>
		
    
</body>
</html>