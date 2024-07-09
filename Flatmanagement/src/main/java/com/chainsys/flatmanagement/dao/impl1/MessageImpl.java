package com.chainsys.flatmanagement.dao.impl1;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;

import com.chainsys.flatmanagement.dao.MessageDao;
import com.chainsys.flatmanagement.mapper.MessageRowMapper;
import com.chainsys.flatmanagement.model.Message;

@Controller
public class MessageImpl implements MessageDao {
	@Autowired
    private JdbcTemplate jdbcTemplate;

    @SuppressWarnings("deprecation")
	public List<Message> findMessagesAfterId(int lastMessageId) {
        String sql = "SELECT Messages.id, Messages.user_id, Messages.message " +
                     "FROM Messages INNER JOIN Users ON Messages.user_id = Users.id " +
                     "WHERE Messages.id > ? ORDER BY Messages.id";
        return jdbcTemplate.query(sql, new Object[]{lastMessageId}, new MessageRowMapper());
    }

    public int save(Message message) {
        String sql = "INSERT INTO Messages (user_id, message) VALUES (?, ?)";
        return jdbcTemplate.update(sql, message.getUserId(), message.getMessage());
    }
}
