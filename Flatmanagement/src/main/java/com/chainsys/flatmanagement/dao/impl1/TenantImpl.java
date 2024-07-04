package com.chainsys.flatmanagement.dao.impl1;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.dao.TenantDao;
import com.chainsys.flatmanagement.mapper.TenantRowMapper;
import com.chainsys.flatmanagement.model.EbBill;
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
	public List<Tenant> getAllTenants() {
        String sql = "SELECT id, name, phone_no, email, aadhaar_number, photo, family_members, flat_type, flat_floor, room_no, advance_amount, advance_status, rent_amount, rent_amount_status, eb_bill, eb_bill_status, date_of_joining, date_of_ending, delete_user, users_id, created_at " +
                     "FROM users_details " +
                     "WHERE delete_user = 0";
        return jdbcTemplate.query(sql, new TenantRowMapper());
    }
	public void deleteTenant(int tenantId) {
        String sql = "UPDATE users_details SET delete_user = ? WHERE id = ?";
        try {
            jdbcTemplate.update(sql, 1, tenantId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	public EbBill addEbBill(int id, int newEbBill, String newEbBillStatus) throws Exception {
        String query = "UPDATE users_details SET eb_bill = ?, eb_bill_status = ? WHERE id = ?";
        try {
            jdbcTemplate.update(query, newEbBill, newEbBillStatus, id);
            return new EbBill(newEbBill, newEbBillStatus);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Error updating EB bill", e);
        }
    }
	@SuppressWarnings("deprecation")
	public List<Tenant> searchTenants(String query) {
        String sql = "SELECT * FROM users_details WHERE delete_user = 0 AND (" +
                     "name LIKE ? OR phone_no LIKE ? OR email LIKE ? OR flat_type LIKE ? OR flat_floor LIKE ?)";
        String queryParam = "%" + query + "%";
        Object[] params = { queryParam, queryParam, queryParam, queryParam, queryParam };
        return jdbcTemplate.query(sql, params, new TenantRowMapper());
    }

}
