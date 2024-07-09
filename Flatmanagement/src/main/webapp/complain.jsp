<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chainsys.flatmanagement.model.*"%>
<%@ page import="com.chainsys.flatmanagement.dao.impl1.*"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%
ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
ComapainImpl complainImpl = (ComapainImpl) context.getBean("complainDao");
List<Complain> complaints = (List<Complain>) complainImpl.getAllComplaints();
List<Employee> employees = (List<Employee>) complainImpl.getAllEmployees();
List<Task> tasks = (List<Task>) complainImpl.getAllTasks();
%>
<!DOCTYPE html>
<html lang="en" >
<head>
<meta charset="ISO-8859-1">
<title>InamManagement</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
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

.employee-table, .task-table {
	margin-top: 1rem;
}
</style>
</head>
<body>
	<%
	HttpSession s = request.getSession(false);
	if (s == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	response.setHeader("Expires", "0"); // Proxies
	User users=(User) s.getAttribute("user");
	if (users.getRole().equals("admin")) {
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
			<div class="container mt-5">
				<%
				if (complaints == null || complaints.isEmpty()) {
				%>
				<div class="alert alert-info" role="alert">No complaints
					found.</div>
				<%
				} else {
				%>
				<table class="table table-bordered">
					<thead class="thead-dark">
						<tr>
							<th>Complaint Type</th>
							<th>Comments</th>
							<th>Complaint Date</th>
							<th>Status</th>
							<th>Floor No</th>
							<th>Door No</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Complain complaint : complaints) {
						%>
						<tr>
							<td><%=complaint.getComplainType()%></td>
							<td><%=complaint.getComments()%></td>
							<td><%=complaint.getComplainDate()%></td>
							<td><%=complaint.getComplainStatus()%></td>
							<td><%=complaint.getFloorNo()%></td>
							<td><%=complaint.getDoorNo()%></td>
							<td>
								<button class="btn btn-primary btn-sm"
									onclick="showAssignWorkerModal(<%=complaint.getId()%>)">Assign
									Worker</button>
								<button class="btn btn-success btn-sm"
									onclick="updateComplaintStatus(<%=complaint.getId()%>, 'Completed','deleteTask')">Mark
									as Completed</button>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<%
				}
				%>
				<!-- Modal for assigning worker -->
				<div class="modal fade" id="assignWorkerModal" tabindex="-1"
					aria-labelledby="assignWorkerModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="assignWorkerModalLabel">Assign
									Worker</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form action="/assignWork" method="post">
									<div class="form-group">
										<label for="workerSelect">Select Worker</label> <select
											class="form-control" id="workerSelect" name="workerId"
											required>
											<option value="" disabled selected>Select a worker</option>
											<%
											for (Employee employee : employees) {
											%>
											<option value="<%=employee.getId()%>"><%=employee.getName()%>(<%=employee.getDepartment()%>)
											</option>
											<%
											}
											%>
										</select>
									</div>
									<input type="hidden" id="currentComplaintId" name="complaintId">
									<input type="hidden" name="action" value="assignWork">
									<button type="submit" class="btn btn-primary">Assign</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Button to toggle employee table -->
			<button class="btn btn-secondary btn-sm corner-toggle"
				onclick="toggleEmployeeTable()">
				<i class="fas fa-users"></i> Manage Employees
			</button>
			<!-- Employee Management Section -->
			<div class="corner bg-light border rounded" id="employeeSection"
				style="display: none;">
				<div class="container p-3">
					<h4 class="mb-3">Employee Management</h4>
					<button class="btn btn-primary btn-sm corner-btn"
						onclick="showAddEmployeeModal()">Add Employee</button>
					<div class="employee-table">
						<%
						if (employees == null || employees.isEmpty()) {
						%>
						<div class="alert alert-info" role="alert">No employees
							found.</div>
						<%
						} else {
						%>
						<table class="table table-sm">
							<thead class="thead-dark">
								<tr>
									<th>Name</th>
									<th>Phone</th>
									<th>Dept</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (Employee employee : employees) {
								%>
								<tr>
									<td><%=employee.getName()%></td>
									<td><%=employee.getPhoneNumber()%></td>
									<td><%=employee.getDepartment()%></td>
									<td>
										<button class="btn btn-danger btn-sm"
											onclick="deleteEmployee(<%=employee.getId()%>,'deleteEmployee')">Delete</button>
									</td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
						<%
						}
						%>
					</div>
				</div>
			</div>
			<!-- Button to toggle task table -->
			<button class="btn btn-secondary btn-sm corner-toggle"
				onclick="toggleTaskTable()">
				<i class="fas fa-tasks"></i> Manage Tasks
			</button>
			<!-- Task Management Section -->
			<div class="corner bg-light border rounded" id="taskSection"
				style="display: none;">
				<div class="container p-3">
					<h4 class="mb-3">Task Management</h4>
					<button class="btn btn-primary btn-sm corner-btn"
						onclick="showAddTaskModal()">Add Task</button>
					<div class="task-table">
						<%
						if (tasks == null || tasks.isEmpty()) {
						%>
						<div class="alert alert-info" role="alert">No tasks found.</div>
						<%
						} else {
						%>
						<table class="table table-sm">
							<thead class="thead-dark">
								<tr>
									<th>ID</th>
									<th>Description</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (Task task : tasks) {
								%>
								<tr>
									<td><%=task.getId()%></td>
									<td><%=task.getComments()%></td>
									<td><%=task.getComplainStatus()%></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
						<%
						}
						%>
					</div>
				</div>
			</div>

			<!-- Modal for adding employee -->
			<div class="modal fade" id="addEmployeeModal" tabindex="-1"
				aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="addEmployeeModalLabel">Add
								Employee</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form action="addEmployee" method="post">
								<div class="form-group">
									<label for="employeeName">Name</label> <input type="text"
										class="form-control" id="employeeName" name="name" required>
								</div>
								<div class="form-group">
									<label for="employeePhone">Phone</label> <input type="text"
										class="form-control" id="employeePhone" name="phonenumber"
										required>
								</div>
								<div class="form-group">
									<label for="employeeDepartment">Department</label> <input
										type="text" class="form-control" id="employeeDepartment"
										name="department" required>
								</div>
								<input type="hidden" value="addEmployee" name="action">
								<button type="submit" class="btn btn-primary">Add</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal for adding task -->
	<div class="modal fade" id="addTaskModal" tabindex="-1"
		aria-labelledby="addTaskModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addTaskModalLabel">Add Task</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="AddTaskServlet" method="post">
						<div class="form-group">
							<label for="taskDescription">Description</label> <input
								type="text" class="form-control" id="taskDescription"
								name="description" required>
						</div>
						<div class="form-group">
							<label for="taskStatus">Status</label> <input type="text"
								class="form-control" id="taskStatus" name="status" required>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%
	} else {
	%>
	<div class="sidebar">
        <img style="padding-bottom: 30px;" width="230" height="150" src="img/logo.png" alt=""> <br>
        <ul class="nav flex-column">
            <li class="nav-item">
                <img width="30" height="30" src="img/search.png" alt="Profile" />
                <a class="nav-link active" href="SearchTenantServlet" data-target="profile">Search</a>
            </li>
            <li class="nav-item">
                <img width="30" height="30" src="img/eb.png" alt="EB Bill" />
                <a class="nav-link" href="payment.jsp" data-target="addEBBill">payment</a>
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
                <a class="nav-link" href="event.jsp" data-target="addEvents">Events</a>
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
				<div class="container">
					<h2 class="form-title text-primary">Raise a Complaint</h2>
					<form id="complaintForm" action="/addComplaint" method="post">
						<div class="form-group">
							<label for="complainType">Complain Type</label> <select
								class="form-control" id="complainType" name="complainType"
								required>
								<option value="" disabled selected>Select complain type</option>
								<option value="Plumbing">Plumbing</option>
								<option value="Electrical">Electrical</option>
								<option value="HVAC">HVAC</option>
								<option value="Cleaning">Cleaning</option>
								<!-- Add more options as needed -->
							</select>
						</div>
						<div class="form-group">
							<label for="comments">Comments</label>
							<textarea class="form-control" id="comments" name="comments"
								rows="3" placeholder="Describe your complaint..." required></textarea>
						</div>
						<div class="form-group">
							<label for="complainDate">Complain Date</label> <input
								type="date" class="form-control" id="complainDate"
								name="complainDate" required>
						</div>
						<input type="hidden" value="addTask" name="action">
						<button type="submit" class="btn btn-primary btn-block">Submit
							Complaint</button>
					</form>

					<div class="complaint-status">
						<button class="btn btn-secondary btn-block mt-4"
							onclick="toggleComplaintStatus()">View Complaint Status</button>
						<div id="complaintStatusTable" style="display: none;">
							<%
							if (complaints == null || complaints.isEmpty()) {
							%>
							<div class="alert alert-info" role="alert">No complaints
								found.</div>
							<%
							} else {
							%>
							<table class="table table-bordered">
								<thead class="thead-dark">
									<tr>
										<th>Complaint Type</th>
										<th>Comments</th>
										<th>Complaint Date</th>
										<th>Status</th>
										<th>Floor No</th>
										<th>Door No</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (Complain complaint : complaints) {
									%>
									<tr>
										<td><%=complaint.getComplainType()%></td>
										<td><%=complaint.getComments()%></td>
										<td><%=complaint.getComplainDate()%></td>
										<td><%=complaint.getComplainStatus()%></td>
										<td><%=complaint.getFloorNo()%></td>
										<td><%=complaint.getDoorNo()%></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	%>

	<!-- Scripts -->
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


	<script>
	function toggleComplaintStatus() {
        const complaintStatusTable = document.getElementById('complaintStatusTable');
        if (complaintStatusTable.style.display === "none") {
            complaintStatusTable.style.display = "block";
        } else {
            complaintStatusTable.style.display = "none";
        }
    }
        function toggleEmployeeTable() {
            const employeeSection = document.getElementById('employeeSection');
            employeeSection.style.display = (employeeSection.style.display === 'none' || employeeSection.style.display === '') ? 'block' : 'none';
        }

        function showAddEmployeeModal() {
            $('#addEmployeeModal').modal('show');
        }

        function showEditEmployeeModal(employeeId) {
            // Logic to populate edit form with employee data
            $('#editEmployeeModal').modal('show');
        }

        function deleteEmployee(employeeId) {
            // Logic to delete employee
            // Repopulate the employee table with updated data
        }

        function showAssignWorkerModal(complaintId) {
            document.getElementById('currentComplaintId').value = complaintId;
            $('#assignWorkerModal').modal('show');
        }

        function updateComplaintStatus(complaintId, status,action) {
        	$.ajax({
                url: '/deleteTask',
                type: 'POST',
                data: { complaintId: complaintId,status: status,action: action },
                success: function(response) {
                    alert('Task deleted successfully');
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert('Failed to delete Task: ' + error);
                }
            });
        }

        function toggleTaskTable() {
            const taskSection = document.getElementById('taskSection');
            taskSection.style.display = (taskSection.style.display === 'none' || taskSection.style.display === '') ? 'block' : 'none';
        }

        function showAddTaskModal() {
            $('#addTaskModal').modal('show');
        }

        function showEditTaskModal(taskId) {
            // Logic to populate edit form with task data
            $('#editTaskModal').modal('show');
        }

        function deleteEmployee(employeeId, action) {
            if (confirm('Are you sure you want to delete this employee?')) {
                $.ajax({
                    url: '/deleteEmployee',
                    type: 'POST',
                    data: { employeeId: employeeId, action: action },
                    success: function(response) {
                        alert('Employee deleted successfully');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('Failed to delete employee: ' + error);
                    }
                });
            }
        }

    </script>
</body>
</html>
