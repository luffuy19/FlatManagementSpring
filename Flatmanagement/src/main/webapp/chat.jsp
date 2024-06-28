<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.chainsys.model.User"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chat</title>
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
	if (session == null || s.getAttribute("users") == null) {
		response.sendRedirect("index.jsp");
	}
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setHeader("Expires", "0"); // Proxies
	User users=(User) s.getAttribute("users");
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
			<div class="container mt-5 chat-container">
				<div id="chatBox" class="chat-box-container mb-3"></div>
				<form id="chatForm" class="mb-3">
					<div class="form-group">
						<input type="hidden" id="username" name="username" value="<%= users.getEmail() %>"
							class="form-control" placeholder="Username" required>
					</div>
					<div class="form-group">
						<input type="text" id="message" name="message"
							class="form-control" placeholder="Message" required>
					</div>
					<button type="submit" class="btn btn-primary btn-block">Send</button>
				</form>
			</div>
		</div>
	</div>

	<script>
    	
        let lastMessageId = 0;

        async function fetchMessages() {
            const response = await fetch('chatServlet?lastMessageId=' + lastMessageId);
            const text = await response.text();
            const lines = text.split('\n');
            const chatBox = document.getElementById('chatBox');
            let shouldScroll = chatBox.scrollTop + chatBox.clientHeight === chatBox.scrollHeight;

            lines.forEach(line => {
                if (line.startsWith("LAST_ID=")) {
                    lastMessageId = parseInt(line.replace("LAST_ID=", ""));
                } else if (line.trim().length > 0) {
                    const div = document.createElement('div');
                    div.classList.add('border', 'rounded', 'p-2', 'mb-2', 'bg-white');
                    div.textContent = line;
                    chatBox.appendChild(div);
                }
            });

            if (shouldScroll) {
                chatBox.scrollTop = chatBox.scrollHeight;
            }
        }

        document.getElementById('chatForm').onsubmit = async function(event) {
            event.preventDefault();
            const username = document.getElementById('username').value;
            const message = document.getElementById('message').value;
            await fetch('chatServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ username, message })
            });
            document.getElementById('message').value = '';
            fetchMessages().then(() => {
                const chatBox = document.getElementById('chatBox');
                chatBox.scrollTop = chatBox.scrollHeight;
            });
        }

        setInterval(fetchMessages, 1000); // Refresh chat messages every second
        fetchMessages(); // Initial fetch
    </script>
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

</body>
</html>
