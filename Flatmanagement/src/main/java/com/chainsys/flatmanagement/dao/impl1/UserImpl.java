package com.chainsys.flatmanagement.dao.impl1;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.Exception.UserAlreadyExistsException;
import com.chainsys.flatmanagement.Exception.UserNotRegisterException;
import com.chainsys.flatmanagement.dao.UserDao;
import com.chainsys.flatmanagement.model.User;
@Repository
public class UserImpl implements UserDao {
	@Autowired
    private JdbcTemplate jdbcTemplate;

    @SuppressWarnings("deprecation")
	public User loginDetails(String email) throws UserNotRegisterException {
        String query = "SELECT id, email, password, role FROM users WHERE email = ?";
        try {
        return jdbcTemplate.queryForObject(query, new Object[]{email}, new BeanPropertyRowMapper<>(User.class));
        }
        catch (EmptyResultDataAccessException e) {
			throw new UserNotRegisterException(email+"is not registerd");
		}
    }
    public int registerDao(User user) throws UserAlreadyExistsException  {
        String sql = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";
        String role = "";
        if (user.getEmail().endsWith("@inam.com")) {
            role = "admin";
        } else {
            role = "user";
        }
        try {
            return jdbcTemplate.update(sql, user.getEmail(), user.getPassword(), role);
        } catch (DuplicateKeyException e) {
            throw new UserAlreadyExistsException("User already exists with email: " + user.getEmail());
        }
    }

    public List<User> findAllUsers() {
        String query = "SELECT id, email, password, role FROM users";
        return jdbcTemplate.query(query,new BeanPropertyRowMapper<>(User.class));  
    }
}
