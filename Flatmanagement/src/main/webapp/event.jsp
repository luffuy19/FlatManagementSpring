<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.chainsys.model.Event"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chainsys.model.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>InamManagement</title>
</head>
<body>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Event Management</title>
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome for icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
	padding: 20px;
}

.event-card {
	margin-bottom: 20px;
	position: relative;
	/* Ensure positioning of delete icon relative to card */
}

.delete-event-icon {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 24px;
	color: #dc3545;
	cursor: pointer;
}

.add-event-icon {
	position: fixed;
	bottom: 20px;
	right: 20px;
	font-size: 40px;
	color: #007bff;
	cursor: pointer;
	z-index: 1000;
}

body {
	font-family: 'Arial', sans-serif;
	background-color: #f8f9fa;
}

h2 {
	background-color: #f8f9fa;
	color: #343a40;
	text-align: center;
}

.sidebar {
	position: fixed;
	top: 0;
	bottom: 0;
	left: 0;
	width: 280px;
	padding: 15px;
	background-color: #343a40;
	color: white;
}

.sidebar a {
	color: white;
	text-decoration: none;
}

.sidebar a:hover {
	color: #ffc107;
}

.content {
	margin-left: 280px;
	padding: 15px;
}

.sidebar .nav-item {
	margin-bottom: 0.5rem;
}

.nav-item {
	display: flex;
	align-items: center;
}

.nav-item img {
	margin-right: 10px;
}

.tenant-info {
	margin-top: 50px;
}

.tenant-info img {
	max-width: 150px;
	height: auto;
	margin-bottom: 20px;
	border-radius: 4%;
}

.tenant-info h2 {
	margin-bottom: 10px;
	color: #000000;
	font-size: 24px;
}

.info-item {
	margin-bottom: 15px;
	color: #495057;
}

.info-item strong {
	color: #000000;
}

.card {
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: box-shadow 0.3s ease-in-out;
}

.card:hover {
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.card-header {
	background-color: #000000;
	color: white;
	border-radius: 10px 10px 0 0;
	padding: 15px;
}

.card-body {
	background-color: #fff;
	padding: 15px;
}

.tenant-header {
	display: flex;
	align-items: center;
}

.tenant-header img {
	margin-right: 20px;
}
</style>
</head>
<body>
	<%
	HttpSession s = request.getSession(false);
	if (session == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setHeader("Expires", "0"); // Proxies
	User users = (User) s.getAttribute("users");
	if (users.getRole().equals("admin")) {
	%>
	<div class="sidebar">
		<img style="padding-bottom: 30px;" width="230" height="150"
			src="./img/logo.png" alt=""> <br>
		<ul class="nav flex-column">
			<li class="nav-item"><img width="30" height="30"
				src="img/search.png" alt="Profile" /> <a class="nav-link active"
				href="SearchTenantServlet" data-target="profile">View Tenant</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/addicon.png" alt="Add Tenant" /> <a class="nav-link"
				href="addTenant.jsp">Add Tenant</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/eb.png" alt="EB Bill" /> <a class="nav-link"
				href="EBbillServlet" data-target="addEBBill">Add EB-Bill</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/visitor.png" alt="Visitors" /> <a class="nav-link"
				href="VisitorServlet" data-target="visitors">Visitors</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/complain.png" alt="Complains" /> <a class="nav-link"
				href="complain.jsp" data-target="complains">Complains</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/chat.png" alt="chat" /> <a class="nav-link"
				href="chat.jsp" data-target="chat">chat</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/event.png" alt="Events" /> <a class="nav-link"
				href="EventServlet" data-target="addEvents">Add Events</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/logout.png" alt="Logout" /> <a class="nav-link"
				href="LogoutServlet">Log-Out</a></li>
		</ul>
	</div>

	<div class="content">
		<div class="container-fluid">
			<div class="row mt-3">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<h2 class="text-center">Upcoming Events</h2>
							<br>
							<div id="eventList">
								<%
								List<Event> events = (List<Event>) request.getAttribute("events");
								%>
								<%
								if (events != null) {
								%>
								<%
								for (Event event : events) {
								%>
								<div class="card event-card">
									<div class="row no-gutters">
										<div class="col-md-4">
											<img src="img/logo.png" class="card-img" alt="Event">
										</div>
										<div class="col-md-8">
											<div class="card-body">
												<h5 class="card-title"><%=event.getTitle()%></h5>
												<p class="card-text"><%=event.getDescription()%></p>
												<p class="card-text">
													<small class="text-muted">Event Date: <%=event.getDate()%></small>
												</p>
												<form action="EventServlet" method="post">
													<input type="hidden" name="action" value="delete">
													<input type="hidden" name="eventId"
														value="<%=event.getId()%>">
													<button type="submit" class="btn btn-danger">Delete</button>
												</form>
											</div>
										</div>
									</div>
								</div>
								<%
								}
								%>
								<%
								}
								%>
							</div>
						</div>
					</div>

					<!-- Button to trigger add event modal -->
					<button type="button" class="btn btn-primary add-event-btn"
						data-toggle="modal" data-target="#addEventModal">Add
						Event</button>

					<!-- Add Event Modal -->
					<div class="modal fade" id="addEventModal" tabindex="-1"
						role="dialog" aria-labelledby="addEventModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="addEventModalLabel">Add New
										Event</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form action="AddEventServlet" method="post" >
										<div class="form-group">
											<label for="eventTitle">Title</label> <input type="text"
												class="form-control" id="eventTitle" name="eventTitle"
												required>
										</div>
										<div class="form-group">
											<label for="eventDescription">Description</label>
											<textarea class="form-control" id="eventDescription"
												name="eventDescription" rows="3" required></textarea>
										</div>
										<div class="form-group">
											<label for="eventDate">Date</label> <input type="date"
												class="form-control" id="eventDate" name="eventDate"
												required>
										</div>
										<div class="form-group">
											<label for="eventLocation">Location</label> <input
												type="text" class="form-control" id="eventLocation"
												name="eventLocation">
										</div>
										<button type="submit" class="btn btn-primary">Add
											Event</button>
									</form>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<%
	} else {
	%>
	<div class="sidebar">
		<img style="padding-bottom: 30px;" width="230" height="150"
			src="img/logo.png" alt=""> <br>
		<ul class="nav flex-column">
			<li class="nav-item"><img width="30" height="30"
				src="img/search.png" alt="Profile" /> <a class="nav-link active"
				href="SearchTenantServlet" data-target="profile">Search</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/eb.png" alt="EB Bill" /> <a class="nav-link"
				href="payment.jsp" data-target="addEBBill">payment</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/complain.png" alt="Complains" /> <a class="nav-link"
				href="complain.jsp" data-target="complains">Complains</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/chat.png" alt="chat" /> <a class="nav-link"
				href="chat.jsp" data-target="chat">chat</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/event.png" alt="Events" /> <a class="nav-link"
				href="event.jsp" data-target="addEvents">Events</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/logout.png" alt="Logout" /> <a class="nav-link"
				href="LogoutServlet">Log-Out</a></li>
		</ul>
	</div>
	<div class="content">
		<div class="container-fluid">
			<div class="row mt-3">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<h2 class="text-center">Upcoming Events</h2>
							<br>
							<div id="eventList">
								<%
								List<Event> events = (List<Event>) request.getAttribute("events");
								%>
								<%
								if (events != null) {
								%>
								<%
								for (Event event : events) {
								%>
								<div class="card event-card">
									<div class="row no-gutters">
										<div class="col-md-4">
											<img src="img/logo.png" class="card-img" alt="Event">
										</div>
										<div class="col-md-8">
											<div class="card-body">
												<h5 class="card-title"><%=event.getTitle()%></h5>
												<p class="card-text"><%=event.getDescription()%></p>
												<p class="card-text">
													<small class="text-muted">Event Date: <%=event.getDate()%></small>
												</p>
												<form action="EventServlet" method="post">
													<input type="hidden" name="action" value="delete">
													<input type="hidden" name="eventId"
														value="<%=event.getId()%>">
												</form>
											</div>
										</div>
									</div>
								</div>
								<%
								}
								%>
								<%
								}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	%>

	<!-- Bootstrap and jQuery JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<!-- Font Awesome JS for icons -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
	<script>
		function showAddEventModal() {
			$('#addEventModal').modal('show');
		}

		function deleteEvent(eventId) {
			console.log('Deleting event with ID:', eventId);
			// Simulate deletion, replace with AJAX call to servlet
			// For demonstration purpose, reload the page after deletion
			window.location.reload();
		}
	</script>
</body>
</html>
