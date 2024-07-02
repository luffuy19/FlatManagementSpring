package com.chainsys.flatmanagement.dao.impl1;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.dao.UserDao;
import com.chainsys.flatmanagement.model.User;
@Repository
public class UserImpl implements UserDao {
	@Autowired
    private JdbcTemplate jdbcTemplate;

    @SuppressWarnings("deprecation")
	public User loginDetails(String email) {
        String query = "SELECT id, email, password, role FROM users WHERE email = ?";
        return jdbcTemplate.queryForObject(query, new Object[]{email}, new BeanPropertyRowMapper<>(User.class));
    }
    public int registerDao(User user) throws SQLException {
        String sql = "INSERT INTO users (email, password,role) VALUES (?,?,?)";
        String role = "";
		if (user.getEmail().endsWith("@inam.com")) {
			role = "admin";
		} else {
			role = "user";
		}
        return jdbcTemplate.update(sql, user.getEmail(), user.getPassword(),role);
    }
    public List<User> findAllUsers() {
        String query = "SELECT id, email, password, role FROM users";
        return jdbcTemplate.query(query,new BeanPropertyRowMapper<>(User.class));  
    }
}
