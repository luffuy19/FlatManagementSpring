package com.chainsys.flatmanagement.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.flatmanagement.dao.impl1.EventImpl;
import com.chainsys.flatmanagement.model.Event;

@Controller
public class EventController {

    @Autowired
    private EventImpl eventImpl;

    @GetMapping("/events")
    public String getAllEvents(Model model) {
        List<Event> events = eventImpl.findAllEvents();
        model.addAttribute("events", events);
        return "event.jsp";
    }

    @PostMapping("/events/delete")
    public String deleteEvent(@RequestParam("eventId") int eventId) {
    	eventImpl.deleteEventById(eventId);
        return "redirect:/events";
    }
    @PostMapping("/events/add")
    public String addEvent(@RequestParam("eventTitle") String title,
                           @RequestParam("eventDescription") String description,
                           @RequestParam("eventDate") String date,
                           @RequestParam("eventLocation") String location) {
    	eventImpl.addEvent(title, description, date, location);
        return "redirect:/events";
    }
}
