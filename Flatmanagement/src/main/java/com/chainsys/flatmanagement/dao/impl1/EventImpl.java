package com.chainsys.flatmanagement.dao.impl1;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.model.Event;

@Repository
public class EventImpl {
	
	@Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Event> findAllEvents() {
        String sql = "SELECT id, title, description, event_date, location FROM events";
        return jdbcTemplate.query(sql, this::mapRowToEvent);
    }

    public void deleteEventById(int id) {
        String sql = "DELETE FROM events WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    private Event mapRowToEvent(ResultSet rs, int rowNum) throws SQLException {
        return new Event(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("description"),
                rs.getString("event_date"),
                rs.getString("location")
        );
    }
    public void addEvent(String title, String description, String date, String location) {
        String sql = "INSERT INTO events (title, description, event_date, location) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, title, description, date, location);
    }
}
