<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>InamManagement</title>
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
/* Custom CSS for the background image */
body {
	background-image: url('img/e.jpg'); /* Replace with your image URL */
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	background-attachment: fixed;
}
/* Custom CSS for login and register forms */
.form-container {
	max-width: 400px;
	margin: 50px auto;
	padding: 15px;
	border: 1px solid #ccc;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	background-color: rgba(255, 255, 255, 0.9);
	/* Slightly transparent background */
}

.form-container h2 {
	margin-bottom: 20px;
}

.form-container .form-group {
	margin-bottom: 15px;
}

.form-container .btn-primary {
	width: 100%;
}
/* Custom navbar color */
.navbar-custom {
	background-color: #373A40;
}

.navbar-custom .navbar-brand, .navbar-custom .nav-link, .navbar-custom .navbar-toggler-icon
	{
	color: #fff;
}

.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	align-items: center;
	justify-content: center;
}

.modal-content {
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-custom">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Inam Maintenance</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="navbarNav">
				<ul class="navbar-nav">
					<!-- Links or other navbar items go here -->
				</ul>
				<form class="form-inline my-2 my-lg-0 ml-auto">
					<button class="btn btn-outline-light" type="button"
						onclick="showModal('loginModal')">Login</button>
					<button class="btn btn-outline-light ml-2" type="button"
						onclick="showModal('registerModal')">Register</button>
				</form>
			</div>
		</div>
	</nav>


	<div id="loginModal" class="modal">
		<div class="modal-content form-container">
			<h2>Login</h2>
			<form action="LoginServlet" method="post">
				<div class="form-group">
					<label for="loginEmail">Email address</label> <input type="email"
						class="form-control" id="loginEmail" name="loginEmail"
						placeholder="Enter email">
				</div>
				<div class="form-group">
					<label for="loginPassword">Password</label> <input type="password"
						class="form-control" id="loginPassword" name="loginPassword"
						placeholder="Password">
				</div>
				<!-- Error Message -->
				<%
				String error = request.getParameter("error");
				%>
				<%
				if (error != null && error.equals("1")) {
				%>
				<div class="alert alert-danger" role="alert">Invalid email or
					password. Please try again.</div>
				<%
				}
				%>
				<button type="submit" class="btn btn-primary">Login</button>
				<button type="button" class="btn btn-secondary mt-2"
					onclick="hideModal('loginModal')">Back</button>
			</form>
		</div>
	</div>

	<div id="registerModal" class="modal">
		<div class="modal-content form-container">
			<h2>Register</h2>
			<form action="Registeration" method="post">
				<div class="form-group">
					<label for="registerEmail">Email address</label> <input
						type="email" class="form-control" id="registerEmail"
						name="registerEmail" placeholder="Enter email">
				</div>
				<div class="form-group">
					<label for="registerPassword">Password</label> <input
						type="password" class="form-control" id="registerPassword"
						name="registerPassword" placeholder="Password">
				</div>
				<div class="form-group">
					<label for="registerConfirmPassword">Confirm Password</label> <input
						type="password" class="form-control" id="registerConfirmPassword"
						name="registerConfirmPassword" placeholder="Confirm Password">
				</div>
				<button type="submit" class="btn btn-primary">Register</button>
				<button type="button" class="btn btn-secondary mt-2"
					onclick="hideModal('registerModal')">Back</button>
			</form>
		</div>
	</div>
	<!-- Bootstrap JS and Popper.js -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		function showModal(id) {
			document.getElementById(id).style.display = 'flex';
		}

		function hideModal(id) {
			document.getElementById(id).style.display = 'none';
		}
		// Show the login modal if there's an error parameter
		window.onload = function() {
			const params = new URLSearchParams(window.location.search);
			if (params.has('error')) {
				showModal('loginModal');
			}
		}
	</script>
</body>
</html>
