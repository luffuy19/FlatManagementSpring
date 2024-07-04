package com.chainsys.flatmanagement.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.flatmanagement.dao.VisitorDao;
import com.chainsys.flatmanagement.model.Visitor;
import com.chainsys.flatmanagement.validation.Validation;

@Controller
public class VisitorController {

	@Autowired
	VisitorDao visitorDao;

	@GetMapping("/viewVisitor")
	public String viewVisitor(@RequestParam(value = "options",defaultValue ="null") String day, Model model) {

		List<Visitor> visitors = visitorDao.viewVisitor(day);
		model.addAttribute("visitor", visitors);
		return "visitor.jsp";
	}

	@PostMapping("/checkIn")
	public String checkInVisitor(@RequestParam("checkIn") String choice,
			@RequestParam("visitorName") String visitorName, @RequestParam("inTime") String inTime,
			@RequestParam("inDate") String inDate, @RequestParam("visitorFloor") int visitorFloor,
			@RequestParam("visitorRoomNo") String visitorRoomNo, Model model) {
		if (!Validation.isValidName(visitorName) ) {
			System.out.println("fasle");
			model.addAttribute("error", "Invalid input data");
			return "visitor.jsp"; // or the appropriate view
		}

		if ("A".equals(choice)) {
			Visitor visitor = new Visitor(0, visitorName, inTime, null, inDate, null, visitorFloor, visitorRoomNo,
					null);
			visitorDao.addVisitor(visitor);
		}
		return viewVisitor("day", model); // Adjust according to the parameter needed
	}

	@PostMapping("/checkOut")
	public String checkOutVisitor(@RequestParam("visitorId") int id, @RequestParam("outTime") String outTime,
			@RequestParam("outDate") String outDate, Model model) {
		System.out.println(outDate);
		Visitor visitor = new Visitor(id, null, null, outTime, null, outDate, 0, null, null);
		visitorDao.outVisitor(visitor);
		return viewVisitor("null", model); // Adjust according to the parameter needed
	}

}
