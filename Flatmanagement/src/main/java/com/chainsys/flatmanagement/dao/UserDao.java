package com.chainsys.flatmanagement.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.Exception.UserAlreadyExistsException;
import com.chainsys.flatmanagement.Exception.UserNotRegisterException;
import com.chainsys.flatmanagement.model.User;

@Repository
public interface UserDao {
	public User loginDetails(String email) throws UserNotRegisterException; 
    public int registerDao(User user) throws SQLException, UserAlreadyExistsException  ;
    public List<User> findAllUsers() ;
}
