package com.chainsys.flatmanagement.dao;

import java.util.List;

import org.springframework.stereotype.Controller;

import com.chainsys.flatmanagement.model.Message;

@Controller
public interface MessageDao  {
	public List<Message> findMessagesAfterId(int lastMessageId);
	public int save(Message message);
}
