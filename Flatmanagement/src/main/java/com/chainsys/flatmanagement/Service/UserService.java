package com.chainsys.flatmanagement.Service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chainsys.flatmanagement.dao.UserDao;
import com.chainsys.flatmanagement.model.User;

@Service
public class UserService {
	
	@Autowired
	UserDao userDao;
	
	public User loginCheck(User user) throws ClassNotFoundException, SQLException {
		User loginDetails = userDao.loginDetails(user.getEmail());
		if(loginDetails!=null && (loginDetails.getEmail().equals(user.getEmail())) && (loginDetails.getPassword().equals(user.getPassword()))) {
				return loginDetails;
		}
		return null;	
	}
}
