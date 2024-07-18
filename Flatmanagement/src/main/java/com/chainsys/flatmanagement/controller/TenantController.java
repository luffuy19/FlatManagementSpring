package com.chainsys.flatmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.chainsys.flatmanagement.Service.TenantService;
import com.chainsys.flatmanagement.dao.TenantDao;
import com.chainsys.flatmanagement.model.Tenant;
import com.chainsys.flatmanagement.model.User;
import com.chainsys.flatmanagement.validation.Validation;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@Controller
@MultipartConfig
public class TenantController {
	@Autowired
	private TenantDao tenantDao;
	@Autowired
	private TenantService tenantService;

	@PostMapping("/addTenant")
	public String addTenant(@RequestParam("userName") String name, @RequestParam("phoneNo") String phoneNo,
			@RequestParam("email") String email, @RequestParam("photo") MultipartFile file,
			@RequestParam("familyMembers") int familyMember, @RequestParam("aadhaarNumber") String aadhaarNumber,
			@RequestParam("advanceAmount") int advanceAmount, @RequestParam("advanceStatus") String advancePaid,
			@RequestParam("rentAmount") int rentAmount, @RequestParam("flatType") String flatType,
			@RequestParam("floorNumber") String flatFloor, @RequestParam("roomNo") String roomNO,
			@RequestParam("dateOfJoining") String dateOfJoining, HttpSession session, Model model) {

		if (session.getAttribute("user") == null) {
			return "redirect:/login"; // Redirect to login if not authenticated
		}

		// Validate parameters using ValidationUtil
		if (!Validation.isValidName(name)) {
			model.addAttribute("error", "Invalid name");
			return "addTenant.jsp";
		}

		if (!Validation.isValidPhoneNo(phoneNo)) {
			model.addAttribute("error", "Invalid phone number");
			return "addTenant.jsp";
		}

		if (!Validation.isValidEmail(email)) {
			model.addAttribute("error", "Invalid email address");
			return "addTenant.jsp";
		}

		if (!Validation.isValidAadhaarNumber(aadhaarNumber)) {
			model.addAttribute("error", "Invalid Aadhaar number");
			return "addTenant.jsp";
		}

		if (!Validation.isValidAdvanceStatus(advancePaid)) {
			model.addAttribute("error", "Invalid advance status");
			return "addTenant.jsp";
		}

		if (!Validation.isValidFlatType(flatType)) {
			model.addAttribute("error", "Invalid flat type");
			return "addTenant.jsp";
		}

		if (!Validation.isValidFloorNumber(flatFloor)) {
			model.addAttribute("error", "Invalid floor number");
			return "addTenant.jsp";
		}

		if (!Validation.isValidRoomNumber(roomNO)) {
			model.addAttribute("error", "Invalid room number");
			return "addTenant.jsp";
		}

		if (!Validation.isValidDate(dateOfJoining)) {
			model.addAttribute("error", "Invalid date format");
			return "addTenant.jsp";
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

		Tenant tenant = new Tenant(0, name, phoneNo, email, aadhaarNumber, imageBytes, familyMember, flatType,
				flatFloor, roomNO, advanceAmount, advancePaid, rentAmount, null, 0, null, dateOfJoining, null, null,
				userId);

		try {
			int row = tenantDao.addTenant(tenant);
			if (row > 0) {
				return "redirect:/addTenant.jsp"; // Redirect on success
			} else {
				return "redirect:/addTenant.jsp?error=User was not Registered"; // Redirect on failure
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // Handle error
		}
	}

	@GetMapping("/search")
	public String searchTenant(@RequestParam(value = "query", required = false) String query,
			@RequestParam(value = "page", defaultValue = "1") int page, @RequestParam("type") String type,
			Model model) {
		int limit = 1; // Adjust the number of items per page as needed

		List<Tenant> allTenants = tenantDao.getAllTenants(); // Fetch all tenants and filter
		int totalTenants = allTenants.size();

		// Calculate pagination details
		int totalPages = (int) Math.ceil((double) totalTenants / limit);
		int offset = (page - 1) * limit;

		// Get sublist based on offset and limit
		List<Tenant> tenantList = allTenants.subList(offset, Math.min(offset + limit, totalTenants));
		model.addAttribute("tenantList", tenantList);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", page);
		model.addAttribute("query", query);

		if (type.equals("1")) {
			return "search.jsp";
		} else if (type.equals("2")) {
			return "ebbill.jsp";
		} else {
			return "search.jsp";
		}
	}

	@PostMapping("/search")
	public String searchTenants(@RequestParam(value = "query", required = false) String query,
			@RequestParam(value = "page", defaultValue = "1") int page, @RequestParam("type") String type,
			Model model) {
		int limit = 1; // Adjust the number of items per page as needed
		System.out.println(query);
		List<Tenant> allTenants = tenantDao.searchTenants(query); // Fetch all tenants and filter
		int totalTenants = allTenants.size();

		// Calculate pagination details
		int totalPages = (int) Math.ceil((double) totalTenants / limit);
		int offset = (page - 1) * limit;

		// Get sublist based on offset and limit
		List<Tenant> tenantList = allTenants.subList(offset, Math.min(offset + limit, totalTenants));
		model.addAttribute("tenantList", tenantList);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", page);
		model.addAttribute("query", query);
		if (type.equals("1")) {
			return "search.jsp";
		} else if (type.equals("2")) {
			return "ebbill.jsp";
		} else {
			return "search.jsp";
		}
	}

	@PostMapping("/deleteTenant")
	public String deleteTenant(@RequestParam("deleteId") int id, @RequestParam("page") int page) {
		tenantDao.deleteTenant(id);
		return "/search?page=" + page + "&type=1";
	}

	@PostMapping("/addEbBill")
	public String addEbBill(@RequestParam("tenantId") int id, @RequestParam("unit") int unit,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		try {
			tenantService.addEbBill(id, unit);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Error adding EB bill");
			return "error";
		}
		return "/search?page=" + page + "&type=2";
	}

	@GetMapping("/searchTenants")
	public String searchTenants(@RequestParam(value = "query", required = false) String query,@RequestParam("type") String type ,Model model) {
		List<Tenant> tenants = tenantDao.searchTenants(query);
		int limit = 1; // Adjust the number of items per page as needed
		int page =1;
		int totalTenants = tenants.size();

		// Calculate pagination details
		int totalPages = (int) Math.ceil((double) totalTenants / limit);
		int offset = (page - 1) * limit;

		// Get sublist based on offset and limit
		List<Tenant> tenantList = tenants.subList(offset, Math.min(offset + limit, totalTenants));
		model.addAttribute("tenantList", tenantList);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", page);
		model.addAttribute("query", query);
		if (type.equals("1")) {
			return "search.jsp";
		} else if (type.equals("2")) {
			return "ebbill.jsp";
		} else {
			return "search.jsp";
		}
		 // This should be the name of your view page
	}
	@PostMapping("/updatePhoto")
    public String updatePhoto(HttpSession session, @RequestParam("newPhoto") MultipartFile file) {
        User user = (User) session.getAttribute("user");

        if (file != null) {
            try {
                byte[] imageBytes = file.getBytes();
                tenantDao.updatePhoto(imageBytes, user.getId());
                return "search.jsp";
            } catch (IOException | ClassNotFoundException e) {
                e.printStackTrace();
                return "error";
            }
        }
        return "error";
    }
}

