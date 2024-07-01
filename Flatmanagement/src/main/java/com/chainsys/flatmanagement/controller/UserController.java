package com.chainsys.flatmanagement.controller;

import java.io.IOException;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chainsys.flatmanagement.Service.UserService;
import com.chainsys.flatmanagement.dao.UserDao;
import com.chainsys.flatmanagement.model.User;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	UserDao userDao;
	
	@GetMapping("/home")
	public String homePage() {
		return "redirect:/index.jsp";
	}

	@PostMapping("/login")
    public String login( @RequestParam("email") String email,@RequestParam("password") String password,HttpSession session,HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException {

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        User loginCheck = userService.loginCheck(user);
        if (loginCheck != null) {
            session.setAttribute("user", loginCheck);
            System.out.println(user);
            System.out.println("session set");
            if("admin".equals(loginCheck.getRole())) {
                return "redirect:/home.jsp";
            }else {
            	System.out.println("user side");
                return "redirect:/home.jsp";
            }
        } 
        else {
            return "redirect:/index.jsp?error=1";
        }
    }
	@PostMapping("/register")
    public String registerUser(@RequestParam("registerEmail") String email,
                               @RequestParam("registerConfirmPassword") String password,
                               RedirectAttributes redirectAttributes) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(password);

        try {
            if (userDao.registerDao(user)==1) {
                return "redirect:/index.jsp";
            } else {
                redirectAttributes.addFlashAttribute("error", "Registration failed");
                return "redirect:/register.jsp";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "An error occurred during registration");
            return "redirect:/register.jsp";
        }
    }
} 
