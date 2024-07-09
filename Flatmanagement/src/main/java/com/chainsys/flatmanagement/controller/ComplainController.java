package com.chainsys.flatmanagement.controller;

import java.sql.SQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.chainsys.flatmanagement.dao.ComplainDao;
import com.chainsys.flatmanagement.model.Complain;
import com.chainsys.flatmanagement.model.Employee;
import com.chainsys.flatmanagement.model.User;
import com.chainsys.flatmanagement.validation.Validation;

@Controller
public class ComplainController {
	
	@Autowired
    private ComplainDao complainDao;

//    @GetMapping("/employees")
//    public String getAllEmployees(Model model) {
//        try {
//            List<Employee> employees = complainDao.getAllEmployees();
//            model.addAttribute("employees", employees);
//            return "employee"; // Return to employee.jsp
//        } catch (ClassNotFoundException | SQLException e) {
//            e.printStackTrace();
//            return "error";
//        }
//    }

    @PostMapping("/addEmployee")
    public String addEmployee(@RequestParam("name") String name, 
                              @RequestParam("phonenumber") String phoneNumber, 
                              @RequestParam("department") String department, 
                              Model model) throws SQLException {
        if (!Validation.isValidName(name) || !Validation.isValidPhoneNo(phoneNumber)) {
            model.addAttribute("error", "Validation Error");
            return "error";
        }
        Employee employee = new Employee(0, name, phoneNumber, department);
            int rowsInserted = complainDao.addEmployee(employee);
            if (rowsInserted > 0) {
                return "complain.jsp"; // Redirect to view employees
            } else {
                model.addAttribute("error", "Database Error");
                return "error";
            }
    }

    @PostMapping("/deleteEmployee")
    public String deleteEmployee(@RequestParam int employeeId, Model model) throws SQLException {

            boolean isDeleted = complainDao.deleteEmployee(employeeId);
            if (isDeleted) {
                return "complain.jsp"; // Redirect to view employees
            } else {
                model.addAttribute("error", "Database Error");
                return "error";
            }
    }

    @PostMapping("/assignWork")
    public String assignWork(@RequestParam int workerId, 
                             @RequestParam int complaintId, 
                             Model model) {
        try {
            complainDao.addTask(workerId, complaintId);
            return "complain.jsp"; // Redirect to view complaints
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Database Error");
            return "error";
        }
    }

    @PostMapping("/deleteTask")
    public String deleteTask(@RequestParam int complaintId, Model model) throws SQLException {

            complainDao.deleteTasksByComplaintId(complaintId);
            complainDao.deleteComplaint(complaintId);
            return "complain.jsp"; // Redirect to view complaints
 
    }

    @PostMapping("/addComplaint")
    public String addComplaint(@RequestParam("complainType") String complainType, 
                               @RequestParam("comments") String comments, 
                               @RequestParam("complainDate") String complainDate,  
                               @SessionAttribute("user") User user, 
                               Model model) throws SQLException {
        if (!Validation.isValidDate(complainDate)) {
            model.addAttribute("error", "Validation Error");
            return "error";
        }
        Complain complain = new Complain(0, complainType, comments, complainDate, "Pending", user.getId(),null,null);
            complainDao.addComplaint(complain);
            return "complain.jsp"; // Redirect to view complaints
        
    }
}
