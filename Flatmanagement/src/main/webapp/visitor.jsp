<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.chainsys.model.Visitor"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>InamManagement</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
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

.add-button {
	position: fixed;
	bottom: 20px;
	right: 20px;
	background-color: #28a745;
	color: white;
	border: none;
	border-radius: 50%;
	width: 50px;
	height: 50px;
	font-size: 24px;
	cursor: pointer;
}

.add-button:hover {
	background-color: #218838;
}

.form-container {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: white;
	padding: 20px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
	width: 100%;
	max-width: 345px;
	z-index: 1000;
	line-height: 0.6;
}

.hidden {
	display: none;
}

.container {
	background-color: white;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.btn-group {
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<div class="sidebar">
		<img style="padding-bottom: 30px;" width="230" height="150"
			src="./img/logo.png" alt=""> <br>
		<ul class="nav flex-column">
			<li class="nav-item">
                <img width="30" height="30" src="img/search.png" alt="Profile" />
                <a class="nav-link active" href="SearchTenantServlet" data-target="profile">View Tenant</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/addicon.png" alt="Add Tenant" />
                <a class="nav-link" href="addTenant.jsp">Add Tenant</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/eb.png" alt="EB Bill" />
                <a class="nav-link" href="EBbillServlet" data-target="addEBBill">Add EB-Bill</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/visitor.png" alt="Visitors" />
                <a class="nav-link" href="VisitorServlet" data-target="visitors">Visitors</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/complain.png" alt="Complains" />
                <a class="nav-link" href="complain.jsp" data-target="complains">Complains</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/chat.png" alt="chat" />
                <a class="nav-link" href="chat.jsp" data-target="chat">chat</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/event.png" alt="Events" />
                <a class="nav-link" href="event.jsp" data-target="addEvents">Add Events</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/logout.png" alt="Logout" />
                <a class="nav-link" href="LogoutServlet">Log-Out</a>
            </li>
        </ul>
    </div>
	<div class="content">
		<div class="container-fluid">
			<div class="container mt-5">
				<form action="Visitor" method="get">
					<div class="btn-group btn-group-toggle" data-toggle="buttons">
						<label class="btn btn-primary"> <input type="radio"
							name="options" id="option3" value="1" autocomplete="off">Today
						</label> <label class="btn btn-primary"> <input type="radio"
							name="options" id="option2" value="7" autocomplete="off">
							Last 7 Days
						</label> <label class="btn btn-primary"> <input type="radio"
							name="options" id="option3" value="30" autocomplete="off">Last
							30 Days
						</label>
					</div>
				</form>
				<table class="table table-striped mt-4">
					<%
					List<Visitor> visitors = (List<Visitor>) request.getAttribute("visitor");
					if (visitors != null && !visitors.isEmpty()) {
					%>
					<thead class="thead-dark">
						<tr>
							<th>ID</th>
							<th>Visitor Name</th>
							<th>In Time</th>
							<th>Out Time</th>
							<th>In Date</th>
							<th>Out Date</th>
							<th>Visitor Floor</th>
							<th>Visitor Door No</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody id="visitorTableBody">
						<%
						for (Visitor visitor : visitors) {
						%>
						<tr>
							<td><%=visitor.getId()%></td>
							<td><%=visitor.getVisitorName()%></td>
							<td><%=visitor.getInTime()%></td>
							<td><%=visitor.getOutTime()%></td>
							<td><%=visitor.getInDate()%></td>
							<td><%=visitor.getOutDate()%></td>
							<td><%=visitor.getFlatFloor()%></td>
							<td><%=visitor.getRoomNo()%></td>
							<td class="outVisitorButton" data-id="<%=visitor.getId()%>"><a
								href="#"><img width="30" height="30" alt="Out Visitor"
									src="img/add.png"></a></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<%
				} else {
				%>
				<table class="table table-striped mt-4">
					<thead class="thead-dark">
						<tr>
							<th>ID</th>
							<th>Visitor Name</th>
							<th>In Time</th>
							<th>Out Time</th>
							<th>In Date</th>
							<th>Out Date</th>
							<th>Visitor Floor</th>
							<th>Visitor RoomNo</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody id="visitorTableBody">
						<tr>
							<td colspan="9">No Visitors</td>
						</tr>
					</tbody>
				</table>
				<%
				}
				%>
				<button id="addVisitorButton" class="add-button">+</button>
			</div>
			<div id="inVisitorFormContainer" class="form-container hidden">
				<form id="visitorForm" class="needs-validation"
					action="VisitorServlet" method="post" novalidate>
					<h2 class="text-center">Add New Visitor</h2>
					<div class="form-group">
						<label for="visitorName">Visitor Name:</label> <input type="text"
							class="form-control" id="visitorName" name="visitorName" required>
						<div class="invalid-feedback">Please enter the visitor's
							name.</div>
					</div>
					<div class="form-group">
						<label for="inTime">In Time:</label> <input type="time"
							class="form-control" id="inTime" name="inTime" required>
						<div class="invalid-feedback">Please enter the in time.</div>
					</div>
					<div class="form-group">
						<label for="inDate">In Date:</label> <input type="date"
							class="form-control" id="inDate" name="inDate" required>
						<div class="invalid-feedback">Please enter the in date.</div>
					</div>
					<div class="form-group">
						<label for="visitorFloor">Visitor Floor:</label> <input
							type="number" class="form-control" id="visitorFloor"
							name="visitorFloor" required>
						<div class="invalid-feedback">Please enter the visitor's
							floor.</div>
					</div>
					<div class="form-group">
						<label for="visitorRoomNo">Visitor Room No:</label> <select
							class="form-control" id="visitorRoomNo" name="visitorRoomNo"
							required>
							<option value="" disabled selected>Select a room</option>
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
						</select>
						<div class="invalid-feedback">Please select the visitor's
							room.</div>
					</div>
					<input type="hidden" name="checkIn" value="A">
					<button type="submit" class="btn btn-success btn-block">Add
						Visitor</button>
				</form>
			</div>
			<div id="outVisitorFormContainer" class="form-container hidden">
				<form id="outVisitorForm" class="needs-validation"
					action="VisitorServlet" method="post">
					<input type="hidden" id="visitorId" name="visitorId">
					<div class="form-group">
						<label for="outDate">Out Date:</label> <input type="date"
							class="form-control" id="outDate" name="outDate">
					</div>
					<div class="form-group">
						<label for="outTime">Out Time:</label> <input type="time"
							class="form-control" id="outTime" name="outTime">
					</div>
					<input type="hidden" name="checkIn" value="B">
					<button type="submit" class="btn btn-success btn-block">Submit</button>
				</form>
			</div>
		</div>
	</div>
	<!-- Bootstrap JS and dependencies -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
	document.addEventListener('DOMContentLoaded', () => {
	    const addVisitorButton = document.getElementById('addVisitorButton');
	    const outVisitorButtons = document.querySelectorAll('.outVisitorButton');
	    const inVisitorFormContainer = document.getElementById('inVisitorFormContainer');
	    const outVisitorFormContainer = document.getElementById('outVisitorFormContainer');
	    const visitorForm = document.getElementById('visitorForm');
	    const outVisitorForm = document.getElementById('outVisitorForm');
	    const visitorIdField = document.getElementById('visitorId');

	    addVisitorButton.addEventListener('click', () => {
	        inVisitorFormContainer.classList.toggle('hidden');
	    });

	    outVisitorButtons.forEach(button => {
	        button.addEventListener('click', () => {
	            const visitorId = button.getAttribute('data-id');
	            visitorIdField.value = visitorId;
	            outVisitorFormContainer.classList.toggle('hidden');
	        });
	    });

	    visitorForm.addEventListener('submit', (e) => {
	        if (visitorForm.checkValidity() === false) {
	            e.preventDefault();
	            e.stopPropagation();
	            visitorForm.classList.add('was-validated');
	        } else {
	            // If form is valid, allow the form to be submitted
	            visitorForm.classList.remove('was-validated');
	        }
	    });

	    outVisitorForm.addEventListener('submit', (e) => {
	        if (outVisitorForm.checkValidity() === false) {
	            e.preventDefault();
	            e.stopPropagation();
	            outVisitorForm.classList.add('was-validated');
	        } else {
	            // If form is valid, allow the form to be submitted
	            outVisitorForm.classList.remove('was-validated');
	        }
	    });
	});
	$(document).ready(function() {
        $('input[name="options"]').on('change', function() {
            var selectedOption = $(this).val();
            window.location.href = 'VisitorServlet?checkIn=C&options=' + selectedOption;
        });
    });			
    </script>
</body>
</html>
