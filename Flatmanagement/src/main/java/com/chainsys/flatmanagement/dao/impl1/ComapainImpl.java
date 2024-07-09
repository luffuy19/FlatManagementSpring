package com.chainsys.flatmanagement.dao.impl1;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.dao.ComplainDao;
import com.chainsys.flatmanagement.mapper.EmployeeRowMapper;
import com.chainsys.flatmanagement.model.Complain;
import com.chainsys.flatmanagement.model.Employee;
import com.chainsys.flatmanagement.model.Task;

@Repository("complainDao")
public class ComapainImpl implements ComplainDao {
	
	
	private final JdbcTemplate jdbcTemplate;
	
	@Autowired
    public ComapainImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Employee> getAllEmployees() throws SQLException {
        String query = "SELECT id, name, phone_number, department FROM employee";
        return jdbcTemplate.query(query, new EmployeeRowMapper());
    }

    public int addEmployee(Employee employee) throws SQLException {
        String query = "INSERT INTO employee (name, phone_number, department) VALUES (?, ?, ?)";
        return jdbcTemplate.update(query, employee.getName(), employee.getPhoneNumber(), employee.getDepartment());
    }

    public boolean deleteEmployee(int employeeId) throws SQLException {
        String query = "DELETE FROM employee WHERE id = ?";
        return jdbcTemplate.update(query, employeeId) > 0;
    }

    public void addTask(int workerId, int complaintId) throws SQLException {
        String query = "INSERT INTO task (employee_id, complain_id) VALUES (?, ?)";
        jdbcTemplate.update(query, workerId, complaintId);
    }

    public void deleteTasksByComplaintId(int complaintId) throws SQLException {
        String query = "DELETE FROM task WHERE complain_id = ?";
        jdbcTemplate.update(query, complaintId);
    }

    public void deleteComplaint(int complaintId) throws SQLException {
        String query = "DELETE FROM complain WHERE id = ?";
        jdbcTemplate.update(query, complaintId);
    }

    public void addComplaint(Complain complain) throws SQLException {
        String query = "INSERT INTO complain (complain_type, comments, complain_date, user_id) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(query, complain.getComplainType(), complain.getComments(), complain.getComplainDate(), complain.getUserId());
    }
    public List<Complain> getAllComplaints() {
        String query = "SELECT c.id, c.complain_type, c.comments, c.complain_date, c.complain_status, c.user_id, u.room_no, u.flat_floor "
                + "FROM complain c JOIN users_details u ON c.user_id = u.id";

        return jdbcTemplate.query(query, (ResultSet rs, int rowNum) -> new Complain(
                rs.getInt("id"),
                rs.getString("complain_type"),
                rs.getString("comments"),
                rs.getString("complain_date"),
                rs.getString("complain_status"),
                rs.getInt("user_id"),
                rs.getString("room_no"),
                rs.getString("flat_floor")
        ));
    }
    public List<Task> getAllTasks() throws Exception {
        String sql = "SELECT t.id, t.employee_id, t.complain_id, c.complain_type, c.comments, c.complain_date, c.complain_status, c.user_id "
                   + "FROM task t JOIN complain c ON t.complain_id = c.id";

        return jdbcTemplate.query(sql, (ResultSet rs, int rowNum) -> new Task(
                rs.getInt("id"),
                rs.getInt("employee_id"),
                rs.getInt("complain_id"),
                rs.getString("complain_type"),
                rs.getString("comments"),
                rs.getString("complain_date"),
                rs.getString("complain_status"),
                rs.getInt("user_id")
        ));
    }
}
