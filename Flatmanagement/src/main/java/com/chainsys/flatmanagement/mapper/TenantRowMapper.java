package com.chainsys.flatmanagement.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.flatmanagement.model.Tenant;

public class TenantRowMapper implements RowMapper<Tenant> {

    @Override
    public Tenant mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Tenant(rs.getInt("id"), rs.getString("name"), rs.getString("phone_no"),
				rs.getString("email"), rs.getString("aadhaar_number"), rs.getBytes("photo"),
				rs.getInt("family_members"), rs.getString("flat_type"), rs.getString("flat_floor"),
				rs.getString("room_no"), rs.getInt("advance_amount"), rs.getString("advance_status"),
				rs.getInt("rent_amount"), rs.getString("rent_amount_status"), rs.getInt("eb_bill"),
				rs.getString("eb_bill_status"), rs.getString("date_of_joining"), rs.getString("date_of_ending"),
				rs.getString("delete_user"), rs.getInt("users_id"));
    }
}

