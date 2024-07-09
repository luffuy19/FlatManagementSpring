<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.chainsys.flatmanagement.model.User"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
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

#chatBox {
    height: 400px;
    overflow-y: scroll;
    border: 1px solid #dee2e6;
    padding: 10px;
    background-color: #f8f9fa;
}

#message, #username {
    width: 100%;
}

.chat-container {
    display: flex;
    flex-direction: column;
    height: 500px;
}

.chat-box-container {
    flex-grow: 1;
    overflow-y: auto;
}
</style>
</head>
<body>
	<%
	HttpSession s = request.getSession(false);
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setHeader("Expires", "0"); // Proxies
	User users=(User) s.getAttribute("user");
	if (users.getRole().equals("admin")) {
	%>
    <div class="sidebar">
        <img style="padding-bottom: 30px;" width="230" height="150" src="img/logo.png" alt=""> <br>
        <ul class="nav flex-column">
            <li class="nav-item">
                <img width="30" height="30" src="img/search.png" alt="Profile" />
                <a class="nav-link active" href="/search?type=1" data-target="profile">View Tenant</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/addicon.png" alt="Add Tenant" />
                <a class="nav-link" href="addTenant.jsp">Add Tenant</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/eb.png" alt="EB Bill" />
                <a class="nav-link" href="/search?type=2" data-target="addEBBill">Add EB-Bill</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/visitor.png" alt="Visitors" />
                <a class="nav-link" href="/viewVisitor" data-target="visitors">Visitors</a>
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
                <a class="nav-link" href="/events" data-target="addEvents">Add Events</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/logout.png" alt="Logout" />
                <a class="nav-link" href="LogoutServlet">Log-Out</a>
            </li>
        </ul>
    </div>
    <% }
    else { %>
    	<div class="sidebar">
        <img style="padding-bottom: 30px;" width="230" height="150" src="img/logo.png" alt=""> <br>
        <ul class="nav flex-column">
            <li class="nav-item">
                <img width="30" height="30" src="img/profileicon.png" alt="Profile" />
                <a class="nav-link active" href="/tenant/search" data-target="profile">Profile</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/eb.png" alt="EB Bill" />
                <a class="nav-link" href="checkPayment" data-target="addEBBill">payment</a>
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
                <a class="nav-link" href="/events" data-target="addEvents">Events</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/logout.png" alt="Logout" />
                <a class="nav-link" href="LogoutServlet">Log-Out</a>
            </li>
        </ul>
    </div>
    <%}  %>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
