<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chainsys.model.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>InamManagement</title>
<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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

.custom-file-input-wrapper {
	position: relative;
	width: 100%;
}

.custom-file-input {
	position: relative;
	z-index: 2;
	width: 100%;
	height: 40px;
	margin: 0;
	opacity: 0;
}

.custom-file-label {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	padding: 0.375rem 0.75rem;
	font-weight: 400;
	line-height: 1.5;
	color: #495057;
	background-color: #fff;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
	display: flex;
	align-items: center;
}

.custom-file-input:focus ~ .custom-file-label {
	border-color: #80bdff;
	box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

.custom-file-input-wrapper .invalid-feedback {
	position: absolute;
	bottom: -1.5rem;
	left: 0;
	width: 100%;
	display: none;
	color: #dc3545;
}

.was-validated .custom-file-input:invalid ~ .custom-file-label {
	border-color: #dc3545;
}

.was-validated .custom-file-input:invalid ~ .custom-file-label ~ .invalid-feedback {
	display: block;
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
	User users=(User) s.getAttribute("users");
	if(users.getRole().equals("admin")) {
	%>
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
			<div class="container mt-5" id="addTenant" style="display: block;">
				<h2>Tenant Information Form</h2>
				<form class="needs-validation"  action="TenantServlet" method="post" enctype="multipart/form-data" >
					<div class="mb-3">
						<label for="name" class="form-label">Name</label> 
						<input type="text" class="form-control" id="name" name="userName" required>
						<div class="invalid-feedback">Please enter a name.</div>
					</div>

					<div class="mb-3">
						<label for="phoneno" class="form-label">Phone Number</label> 
						<input type="text" class="form-control" id="phoneno" name="phoneNo" required>
						<div class="invalid-feedback">Please enter the phone number.</div>
					</div>
					 
					<div class="mb-3">
						<label for="email" class="form-label">Email</label> 
						<input type="email" class="form-control" id="email" name="email" required>
						<div class="invalid-feedback">Please enter the registered email.</div>
					</div>
					<label for="email" class="form-label">Photo</label> 
					<div class="mb-3 custom-file-input-wrapper">
						<label for="photo" class="form-label">Photo</label> 
						<input type="file" class="form-control custom-file-input" id="photo" name="photo" required> 
						<label class="custom-file-label" for="photo">Choose file...</label>
						<div class="invalid-feedback">Please upload a photo.</div>
					</div>

					<div class="mb-3">
						<label for="familyMembers" class="form-label">Family Members</label> 
						<input type="number" class="form-control" id="familyMembers" name="familyMembers" required>
						<div class="invalid-feedback">Please enter the number of family members.</div>
					</div>

					<div class="mb-3">
						<label for="aadhaarNumber" class="form-label">Aadhaar Number</label> 
						<input type="text" class="form-control" id="aadhaarNumber" name="aadhaarNumber" pattern="\d{12}" required>
						<div class="invalid-feedback">Please enter a valid 12-digit Aadhaar number.</div>
					</div>

					<div class="mb-3">
						<label for="advanceAmount" class="form-label">Advance Amount</label> 
						<input type="number" class="form-control" id="advanceAmount" name="advanceAmount" required>
						<div class="invalid-feedback">Please enter the advance amount.</div>
					</div>

					<div class="mb-3">
						<label for="advancePaid" class="form-label">Advance Paid</label> 
						<select class="form-select" id="advancePaid" name="advanceStatus" required>
							<option value="yes">Yes</option>
							<option value="no">No</option>
						</select>
						<div class="invalid-feedback">Please select if the advance is paid.</div>
					</div>

					<div class="mb-3">
						<label for="rentAmount" class="form-label">Rent Amount</label> 
						<input type="number" class="form-control" id="rentAmount" name="rentAmount" required>
						<div class="invalid-feedback">Please enter the rent amount.</div>
					</div>

					<div class="mb-3">
						<label for="flatType" class="form-label">Flat Type</label> 
						<select class="form-select" id="flatType" name="flatType" required>
							<option value="">Choose...</option>
							<option value="2bhk">2BHK</option>
							<option value="3bhk">3BHK</option>
						</select>
						<div class="invalid-feedback">Please select the flat type.</div>
					</div>

					<div class="mb-3">
						<label for="floorNumber" class="form-label">Floor Number</label> 
						<input type="number" class="form-control" id="floorNumber" name="floorNumber" required>
						<div class="invalid-feedback">Please enter the floor number.</div>
					</div>
					<div class="mb-3">
						<label for="roomNo" class="form-label">Room Type</label> 
						<select class="form-select" id="roomNo" name="roomNo" required>
							<option value="">Choose...</option>
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
						</select>
						<div class="invalid-feedback">Please select the Room No.</div>
					</div>
					<div class="mb-3">
						<label for="dateOfJoining" class="form-label">Date of Joining</label> 
						<input type="date" class="form-control" id="dateOfJoining" name="dateOfJoining" required>
						<div class="invalid-feedback">Please select the date of joining.</div>
					</div>
					<button class="btn btn-primary" type="submit">Submit</button>
				</form>
			</div>
		</div>
	</div>
	<%} %>
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
    (function () {
        'use strict';

        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        var forms = document.querySelectorAll('.needs-validation');

        // Loop over them and prevent submission
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }

                    form.classList.add('was-validated');
                }, false);
            });

        

        // JavaScript to update the label of the custom file input
        document.querySelector('.custom-file-input').addEventListener('change', function(e) {
            var fileName = document.getElementById("photo").files[0].name;
            var nextSibling = e.target.nextElementSibling;
            nextSibling.innerText = fileName;
        });
    })();
	</script>
</body>
</html>
