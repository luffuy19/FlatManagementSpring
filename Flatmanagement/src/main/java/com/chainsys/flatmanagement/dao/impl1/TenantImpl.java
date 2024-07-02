package com.chainsys.flatmanagement.dao.impl1;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.dao.TenantDao;
import com.chainsys.flatmanagement.model.Tenant;
import com.chainsys.flatmanagement.model.User;

@Repository
public class TenantImpl implements TenantDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Override
	public List<User> findAllUsers() {
		return null;
	}

	@SuppressWarnings("deprecation")
	@Override
	public int findUserId(String email) {
		 String findUserIdSql = "SELECT id FROM users WHERE email = ?";
	     return jdbcTemplate.queryForObject(findUserIdSql, new Object[]{email}, Integer.class);
	}

	@Override
	public int addTenant(Tenant tenant) {
		String insertTenantSql = "INSERT INTO users_details " +
                "(name, phone_no, email, aadhaar_number, photo, family_members, flat_type, flat_floor, room_no, advance_amount, advance_status, rent_amount, date_of_joining, users_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        int userId = findUserId(tenant.getEmail());
        if (userId > 0) {
            return jdbcTemplate.update(insertTenantSql,
                tenant.getName(),
                tenant.getPhoneNo(),
                tenant.getEmail(),
                tenant.getAadhaarNumber(),
                tenant.getPhoto(),
                tenant.getFamilyNembers(),
                tenant.getFlatType(),
                tenant.getFlatFloor(),
                tenant.getRoomNo(),
                tenant.getAdvanceAmount(),
                tenant.getAdvanceStatus(),
                tenant.getRentAmount(),
                tenant.getDateOfJoining(),
                userId);
        }
        return 0;
	}

}
