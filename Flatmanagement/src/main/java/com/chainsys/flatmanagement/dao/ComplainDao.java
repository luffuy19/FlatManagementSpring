package com.chainsys.flatmanagement.dao;

import java.sql.SQLException;
import java.util.List;

import com.chainsys.flatmanagement.model.Complain;
import com.chainsys.flatmanagement.model.Employee;

public interface ComplainDao {
	public List<Employee> getAllEmployees() throws SQLException;
	public int addEmployee(Employee employee) throws SQLException;
	public boolean deleteEmployee(int employeeId) throws SQLException;
	public void addTask(int workerId, int complaintId) throws SQLException;
	public void deleteTasksByComplaintId(int complaintId) throws SQLException;
	public void deleteComplaint(int complaintId) throws SQLException;
	public void addComplaint(Complain complain) throws SQLException;	
}