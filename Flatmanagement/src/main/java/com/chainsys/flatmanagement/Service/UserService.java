package com.chainsys.flatmanagement.Service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chainsys.flatmanagement.dao.impl1.UserImpl;
import com.chainsys.flatmanagement.model.User;

@Service
public class UserService {
	
	@Autowired
	UserImpl userDao;
	
	public User loginCheck(User user) throws ClassNotFoundException, SQLException {
		User loginDetails = userDao.loginDetails(user.getEmail());
		if(loginDetails!=null && (loginDetails.getEmail().equals(user.getEmail())) && (loginDetails.getPassword().equals(user.getPassword()))) {
				return loginDetails;
		}
		return null;	
	}
	public int insertUser(User user) throws SQLException {
	    List<User> users = userDao.findAllUsers();
	    
	    // Check if the email already exists
	    for (User existingUser : users) {
	        if (existingUser.getEmail().equals(user.getEmail())) {
	            return 0; // Email already exists
	        }
	    }
	    return userDao.registerDao(user);
	}   
}
