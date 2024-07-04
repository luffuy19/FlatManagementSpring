package com.chainsys.flatmanagement.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.flatmanagement.model.Visitor;

public class VisitorRowMapper implements RowMapper<Visitor> {
        @Override
        public Visitor mapRow(ResultSet resultSet, int i) throws SQLException {
            return new Visitor(
                    resultSet.getInt("id"),
                    resultSet.getString("visitor_name"),
                    resultSet.getString("in_time"),
                    resultSet.getString("out_time"),
                    resultSet.getString("in_date"),
                    resultSet.getString("out_date"),
                    resultSet.getInt("flat_floor"),
                    resultSet.getString("door_no"),
                    resultSet.getString("timestamp")
            );
        }
}
