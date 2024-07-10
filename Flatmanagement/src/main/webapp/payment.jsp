<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.chainsys.flatmanagement.model.*"%>
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

.transaction-sidebar {
	position: fixed;
	top: 0;
	right: -300px; /* Initially hidden off the screen */
	width: 300px;
	height: 100%;
	background-color: #343a40;
	color: white;
	overflow-y: auto;
	padding: 15px;
	transition: right 0.3s ease;
	z-index: 1050;
}

.transaction-sidebar h3 {
	text-align: center;
	margin-bottom: 20px;
	color: #ffc107;
}

.transaction-list {
	list-style-type: none;
	padding: 0;
}

.transaction-list li {
	border-bottom: 1px solid #dee2e6;
	padding: 10px 0;
	display: flex;
	justify-content: space-between;
	color: white;
}

.transaction-list li:last-child {
	border-bottom: none;
}

.transaction-list .date {
	color: #6c757d;
}

.transaction-list .amount {
	color: lightgreen;
}

.transaction-toggle-btn {
	position: fixed;
	bottom: 20px;
	right: 20px;
	font-size: 24px;
	cursor: pointer;
	z-index: 1100;
	color: #007bff;
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
	User user = (User) session.getAttribute("user");
	Tenant tenant = (Tenant) request.getAttribute("tenant");
	int totalRent = 0;
	if (request.getAttribute("rent") != null) {
		totalRent = (int) request.getAttribute("rent");
	}
	List<PaymentReceipt> payments = (List<PaymentReceipt>) request.getAttribute("payement");
	boolean hasPaid = (Boolean) request.getAttribute("hasPaid");
	%>
	<div class="sidebar">
		<img src="img/logo.png" alt="Logo" style="padding-bottom: 30px;"
			width="230" height="150">
		<ul class="nav flex-column">
			<li class="nav-item"><img src="img/search.png" alt="Profile"
				width="30" height="30"> <a class="nav-link active"
				href="SearchTenantServlet">Search</a></li>
			<li class="nav-item"><img src="img/eb.png" alt="EB Bill"
				width="30" height="30"> <a class="nav-link" href="payment.jsp">Payment</a>
			</li>
			<li class="nav-item"><img src="img/complain.png" alt="Complains"
				width="30" height="30"> <a class="nav-link"
				href="complain.jsp">Complains</a></li>
			<li class="nav-item"><img src="img/chat.png" alt="Chat"
				width="30" height="30"> <a class="nav-link" href="chat.jsp">Chat</a>
			</li>
			<li class="nav-item"><img src="img/event.png" alt="Events"
				width="30" height="30"> <a class="nav-link"
				href="EventServlet">Events</a></li>
			<li class="nav-item"><img src="img/logout.png" alt="Logout"
				width="30" height="30"> <a class="nav-link"
				href="LogoutServlet">Log-Out</a></li>
		</ul>
	</div>

	<%
	if (!hasPaid) {
	%>
	<div class="content">
		<div class="container">
			<div class="payment-options">
				<div class="payment-form1" id="paymentRentButtons">
					<h3>Select Payment</h3>
					<div class="payment-buttons">
						<button type="button" class="btn btn-primary"
							onclick="showRentPaymentOptions()">
							Pay Rent:
							<%=totalRent%></button>
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
				<form id="paymentDetailsForm"
					action="/submitPayment?amount=<%=totalRent%>" method="post">
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
					<button type="submit" class="btn btn-success">Pay Now</button>
				</form>

			</div>
		</div>
	</div>
	<%
	} else {
	%>
	<div class="message-container">
		<h3 class="message-title">Payment Completed</h3>
		<p class="message-text">You have already completed the payment.</p>
	</div>
	<%
	}
	%>

	<!-- Transaction Side bar -->
	<div class="transaction-sidebar" id="transactionSidebar">
		<h3>Transaction History</h3>
		<ul class="transaction-list">
			<!-- Sample transactions, replace with dynamic data -->
			<%
			for (PaymentReceipt payment : payments) {
			%>
			<li><span class="date"><%=payment.getPaymentDate()%></span> <span
				class="amount">+<%=payment.getAmount()%></span></li>
			<%
			}
			%>
		</ul>
	</div>

	<!-- Toggle Button -->
	<div class="transaction-toggle-btn"
		onclick="toggleTransactionSidebar()">
		<i class="fas fa-history"></i> Transaction History
	</div>

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
			$("#paymentTitle").text("Rent");
			$("#paymentOptions").show();
			$("#cardDetailsSection").hide();
			$("#paymentResultSection").hide();
		}

		function toggleTransactionSidebar() {
			var sidebar = $("#transactionSidebar");
			if (sidebar.css("right") === "0px") {
				sidebar.css("right", "-300px");
			} else {
				sidebar.css("right", "0");
			}
		}

		function fetchTransactions() {
			$.ajax({
				url: '/getTransactions', // Your backend endpoint to fetch transactions
				method: 'GET',
				success: function(data) {
					var transactionList = $('#transactionSidebar .transaction-list');
					transactionList.empty(); // Clear existing transactions

					data.forEach(function(transaction) {
						var listItem = `
							<li>
								<span class="date">${transaction.date}</span>
								<span class="amount">${transaction.amount}</span>
							</li>
						`;
						transactionList.append(listItem);
					});
				},
				error: function(err) {
					console.error('Error fetching transactions:', err);
				}
			});
		}
	</script>
</body>
</html>
