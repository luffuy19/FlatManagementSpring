package com.chainsys.flatmanagement.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chainsys.flatmanagement.Exception.UserAlreadyExistsException;
import com.chainsys.flatmanagement.Exception.UserNotRegisterException;
import com.chainsys.flatmanagement.dao.impl1.UserImpl;
import com.chainsys.flatmanagement.model.User;

@Service
public class UserService {

	@Autowired
	UserImpl userDao;

	public User loginCheck(User user) throws ClassNotFoundException, UserNotRegisterException {
		User loginDetails = userDao.loginDetails(user.getEmail());
		if (loginDetails != null && (loginDetails.getEmail().equals(user.getEmail()))
				&& (loginDetails.getPassword().equals(user.getPassword()))) {
			return loginDetails;
		}
		return null;
	}

	public int insertUser(User user) throws UserAlreadyExistsException {
		return userDao.registerDao(user);
	}
}
