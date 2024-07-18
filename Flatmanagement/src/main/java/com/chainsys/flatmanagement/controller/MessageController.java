package com.chainsys.flatmanagement.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.flatmanagement.dao.MessageDao;
import com.chainsys.flatmanagement.model.Message;
import com.chainsys.flatmanagement.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MessageController {


    @Autowired
    private MessageDao messageDao;
    
 
    

    @GetMapping("/refreshMessage")
    public void getMessages(@RequestParam("lastMessageId") int lastMessageId, HttpServletResponse response) throws IOException {
        List<Message> messages = messageDao.findMessagesAfterId(lastMessageId);
        Map<String, Object> responseMap = new HashMap<>();

        int newLastMessageId = lastMessageId;
        for (Message msg : messages) {
            newLastMessageId = msg.getId();
        }
        responseMap.put("messages", messages);
        responseMap.put("lastMessageId", newLastMessageId);

        response.setContentType("application/json");
        response.getWriter().write(new ObjectMapper().writeValueAsString(responseMap));
    }

    @PostMapping("/message")
    public void postMessage(@RequestParam("message") String message, HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                Message msg = new Message();
                msg.setUserId(user.getId());
                msg.setMessage(message);
                messageDao.save(msg);
            }
        }
        getMessages(0, response);
    }
}
