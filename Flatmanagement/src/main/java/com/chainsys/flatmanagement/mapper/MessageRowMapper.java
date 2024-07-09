package com.chainsys.flatmanagement.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.flatmanagement.model.Message;

public  class MessageRowMapper implements RowMapper<Message> {
    @Override
    public Message mapRow(ResultSet rs, int rowNum) throws SQLException {
        Message message = new Message();
        message.setId(rs.getInt("id"));
        message.setUserId(rs.getInt("user_id"));
        message.setMessage(rs.getString("message"));
        return message;
    }
}
