package com.chainsys.flatmanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.flatmanagement.model.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	
	@PostMapping
	public String login(@RequestParam("email") String email,@RequestParam("password") String password,HttpSession session) {
		User user = new User();
		user.setEmail(email);
		user.setPassword(password);
		return "home.jsp";
	}
} 
