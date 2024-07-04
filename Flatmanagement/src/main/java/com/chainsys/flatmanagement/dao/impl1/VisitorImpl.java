package com.chainsys.flatmanagement.dao.impl1;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.dao.VisitorDao;
import com.chainsys.flatmanagement.mapper.VisitorRowMapper;
import com.chainsys.flatmanagement.model.Visitor;

@Repository
public class VisitorImpl implements VisitorDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public void addVisitor(Visitor visitor) {
        String query = "INSERT INTO visitors (visitor_name, in_time, in_date, flat_floor, door_no) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(query, visitor.getVisitorName(), visitor.getInTime(), visitor.getInDate(), visitor.getFlatFloor(), visitor.getRoomNo());
    }

    public void outVisitor(Visitor visitor) {
        String query = "UPDATE visitors SET out_time = ?, out_date = ? WHERE id = ?";
        jdbcTemplate.update(query, visitor.getOutTime(), visitor.getOutDate(), visitor.getId());
    }

    public List<Visitor> viewVisitor(String days) {
        String query;
        if ("30".equals(days)) {
            query = "SELECT * FROM visitors WHERE timestamp >= NOW() - INTERVAL 30 DAY";
        } else if ("7".equals(days)) {
            query = "SELECT * FROM visitors WHERE timestamp >= NOW() - INTERVAL 7 DAY";
        } else if ("1".equals(days)) {
            query = "SELECT * FROM visitors WHERE timestamp >= NOW() - INTERVAL 1 DAY";
        } else {
            query = "SELECT * FROM visitors WHERE timestamp >= NOW() - INTERVAL 1 DAY";
        }
        return jdbcTemplate.query(query, new VisitorRowMapper());
    }
}
