package com.chainsys.flatmanagement.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.flatmanagement.model.Employee;

public class EmployeeRowMapper implements RowMapper<Employee> {
	public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Employee(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("phone_number"),
                rs.getString("department")
        );
    }
}
