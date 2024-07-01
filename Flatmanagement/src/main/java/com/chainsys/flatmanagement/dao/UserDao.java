package com.chainsys.flatmanagement.dao;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.model.User;
@Repository
public class UserDao {
	@Autowired
    private JdbcTemplate jdbcTemplate;

    @SuppressWarnings("deprecation")
	public User loginDetails(String email) {
        String query = "SELECT id, email, password, role FROM users WHERE email = ?";
        return jdbcTemplate.queryForObject(query, new Object[]{email}, new BeanPropertyRowMapper<>(User.class));
    }
    public int registerDao(User user) throws SQLException {
        String sql = "INSERT INTO users (email, password) VALUES (?, ?)";
        return jdbcTemplate.update(sql, user.getEmail(), user.getPassword());
    }
}
