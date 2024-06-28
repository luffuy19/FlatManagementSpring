<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.chainsys.model.*"%>
<%@ page import="com.chainsys.dto.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment Page</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f8f9fa;
	overflow: hidden;
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

h1 {
	text-align: center;
	margin-top: 30px;
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

.payment-options {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100vh;
}

.payment-form {
	width: 100%;
	max-width: 400px;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.payment-title {
	text-align: center;
	margin-bottom: 20px;
}

.payment-buttons {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

.payment-buttons button {
	margin-right: 10px;
}

.payment-options form {
	margin-top: 20px;
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

.payment-form {
	width: 100%;
	max-width: 400px;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	position: absolute;
	top: 116px;
	left: 600px;
}

.payment-form1 {
	width: 100%;
	max-width: 400px;
	padding: 20px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	position: absolute;
	top: 230px;
}

.h3, h3 {
	font-size: 1.75rem;
	text-align: center;
}

.message-container {
	position: absolute;
	top: 201px; /* Adjust this value to position the message as desired */
	left: 60%;
	transform: translateX(-50%);
	text-align: center;
}

.message-title {
	color: #007bff;
}

.message-text {
	color: #6c757d;
}
</style>
</head>
<body>
	<%
	HttpSession s = request.getSession(false);
	if (session == null || s.getAttribute("users") == null) {
		response.sendRedirect("index.jsp");
	}
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setHeader("Expires", "0"); // Proxies
	User users = (User) s.getAttribute("users");

	TrancistionDto trancistionDto = new TrancistionDto();
	System.out.print(users.getId());
	Tenant tenant = (Tenant) trancistionDto.getSpecficTenants(users.getId());
	System.out.print(tenant);
	int rent = tenant.getEbBill() + tenant.getRentAmount();
	String hadPay = request.getParameter("payment");
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
				href="EventServlet" data-target="addEvents">Events</a></li>
			<li class="nav-item"><img width="30" height="30"
				src="img/logout.png" alt="Logout" /> <a class="nav-link"
				href="LogoutServlet">Log-Out</a></li>
		</ul>
	</div>

	<%
	if (hadPay.equals("1")) {
	%>
	<div class="content">
		<div class="container">
			<div class="payment-options">
				<div class="payment-form1" id="paymentRentButtons">
					<h3>Select Payment</h3>
					<div class="payment-buttons">
						<button type="button" class="btn btn-primary"
							onclick="showRentPaymentOptions()">
							Pay
							<%=rent%></button>
					</div>
				</div>
			</div>
			<div class="payment-form" id="paymentOptions" style="display: none;">
				<h3 id="paymentTitle">.</h3>
				<form id="paymentMethodForm">
					<div class="form-check">
						<input class="form-check-input" type="radio" name="paymentMethod"
							id="debitCardOption" value="debit" checked> <label
							class="form-check-label" for="debitCardOption"> Debit
							Card </label>
					</div>
					<div class="form-check">
						<input class="form-check-input" type="radio" name="paymentMethod"
							id="creditCardOption" value="credit"> <label
							class="form-check-label" for="creditCardOption"> Credit
							Card </label>
					</div>
					<button type="button" class="btn btn-primary mt-3"
						onclick="submitPaymentMethod()">Next</button>
				</form>
			</div>

			<div class="payment-form" id="cardDetailsSection"
				style="display: none;">
				<h3 id="paymentMethodLabel">Debit Card Details</h3>
				<form id="paymentDetailsForm">
					<div class="form-group">
						<label for="cardNumber">Card Number</label> <input type="text"
							class="form-control" id="cardNumber" name="cardNumber" required>
					</div>
					<div class="form-group">
						<label for="expiryDate">Expiry Date</label> <input type="text"
							class="form-control" id="expiryDate" name="expiryDate"
							placeholder="MM/YY" required>
					</div>
					<div class="form-group">
						<label for="cvv">CVV</label> <input type="text"
							class="form-control" id="cvv" name="cvv" required>
					</div>
					<button type="button" class="btn btn-success"
						onclick="processPayment()">Pay Now</button>
				</form>
			</div>
		</div>
	</div>
	<%
	} else {
	%>
	<div class="container message-container">
		<h1 class="message-title">No Due Payments</h1>
		<p class="lead message-text">There are currently no payments due.</p>
	</div>
	<%
	}
	%>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		function submitPaymentMethod() {
			var paymentMethod = $("input[name='paymentMethod']:checked").val();
			if (paymentMethod === 'debit') {
				$("#paymentMethodLabel").text("Debit Card Details");
			} else {
				$("#paymentMethodLabel").text("Credit Card Details");
			}
			$("#paymentMethodForm").hide();
			$("#cardDetailsSection").show();
		}
		function showRentPaymentOptions() {
			$("#paymentRentButtons").hide();
			$("#paymentEbButtons").hide();
			$("#paymentTitle").text("Rent");
			$("#paymentOptions").show();
			$("#cardDetailsSection").hide();
			$("#paymentResultSection").hide();
		}
		function showEbPaymentOptions() {
			$("#paymentRentButtons").hide();
			$("#paymentEbButtons").hide();
			$("#paymentTitle").text("EB Bill");
			$("#paymentOptions").show();
			$("#cardDetailsSection").hide();
			$("#paymentResultSection").hide();
		}
		function submitPaymentMethod() {
			var paymentMethod = $("input[name='paymentMethod']:checked").val();
			if (paymentMethod === 'debit') {
				$("#paymentMethodLabel").text("Debit Card Details");
			} else {
				$("#paymentMethodLabel").text("Credit Card Details");
			}
			$("#paymentMethodForm").hide();
			$("#cardDetailsSection").show();
		}
		var $j = jQuery.noConflict();
		function processPayment() {
			$j.ajax({
				url : "checkPayment",
				type : "POST",
				data : {
					payment : "ebill"
				},
				success : function(response) {
					if (response.success) {
						alert("Payment successful!");
					} else {
						alert("Payment failed. Please try again.");
					}
				},
				error : function() {
					alert("An error occurred. Please try again.");
				}
			});
		}
	</script>
	<!-- Bootstrap JS and dependencies -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>



</body>
</html>
