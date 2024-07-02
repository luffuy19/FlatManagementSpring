package com.chainsys.flatmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.chainsys.flatmanagement.dao.TenantDao;
import com.chainsys.flatmanagement.model.Tenant;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@Controller
@RequestMapping("/tenant")
@MultipartConfig
public class TenantController {

    @Autowired
    private TenantDao tenantDao;

    @PostMapping("/addTenant")
    public String addTenant(
            @RequestParam("userName") String name,
            @RequestParam("phoneNo") String phoneNo,
            @RequestParam("email") String email,
            @RequestParam("photo") MultipartFile file,
            @RequestParam("familyMembers") int familyMember,
            @RequestParam("aadhaarNumber") String aadhaarNumber,
            @RequestParam("advanceAmount") int advanceAmount,
            @RequestParam("advanceStatus") String advancePaid,
            @RequestParam("rentAmount") int rentAmount,
            @RequestParam("flatType") String flatType,
            @RequestParam("floorNumber") String flatFloor,
            @RequestParam("roomNo") String roomNO,
            @RequestParam("dateOfJoining") String dateOfJoining,
            HttpSession session,
            Model model) {

        if (session.getAttribute("user") == null) {
            return "redirect:/login"; // Redirect to login if not authenticated
        }

        byte[] imageBytes = null;
        if (!file.isEmpty()) {
            try {
                imageBytes = file.getBytes();
            } catch (IOException e) {
                e.printStackTrace();
                return "error"; // Handle error
            }
        }

        int userId = 0;
        try {
            userId = tenantDao.findUserId(email);
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // Handle error
        }

        Tenant tenant = new Tenant(0, name, phoneNo, email, aadhaarNumber, imageBytes, familyMember, flatType, flatFloor, roomNO, advanceAmount, advancePaid, rentAmount, null, 0, null, dateOfJoining, null, null, userId);

        try {
            int row = tenantDao.addTenant(tenant);
            if (row > 0) {
                return "redirect:/addTenant.jsp"; // Redirect on success
            } else {
                return "redirect:/addTenant.jsp?error=User was not Registerd"; // Redirect on failure
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // Handle error
        }
    }
    public String searchTenant() {
		
    	return null;
    }
}

