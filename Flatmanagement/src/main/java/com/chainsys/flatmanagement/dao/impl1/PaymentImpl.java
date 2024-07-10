package com.chainsys.flatmanagement.dao.impl1;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.chainsys.flatmanagement.dao.PaymentDao;
import com.chainsys.flatmanagement.model.PaymentReceipt;
import com.chainsys.flatmanagement.model.Tenant;

@Repository
public class PaymentImpl implements PaymentDao {
    private final JdbcTemplate jdbcTemplate;

    public PaymentImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean checkUserPayment(int userId) {
        String sql = "SELECT COUNT(*) FROM user_payments WHERE user_id = ? AND payment_date BETWEEN DATE_FORMAT(NOW(), '%Y-%m-01') AND LAST_DAY(NOW())";
        @SuppressWarnings("deprecation")
		Integer count = jdbcTemplate.queryForObject(sql, new Object[]{userId}, Integer.class);
        return count != null && count > 0;
    }

    @SuppressWarnings("deprecation")
	@Override
    public Tenant getSpecificTenant(int userId) {
        String sql = "SELECT * FROM users_details WHERE users_id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{userId}, new TenantRowMapper());
    }

    @Override
    public void savePayment(int userId, int amount, String receiptNumber) {
        String sql = "INSERT INTO user_payments (user_id, amount, payment_date, receipt_number) VALUES (?, ?, NOW(), ?)";
        jdbcTemplate.update(sql, userId, amount, receiptNumber);
    }

    @SuppressWarnings("deprecation")
	@Override
    public PaymentReceipt getReceipt(int userId) {
        String sql = "SELECT * FROM user_payments WHERE user_id = ? ORDER BY payment_date DESC LIMIT 1";
        return jdbcTemplate.queryForObject(sql, new Object[]{userId}, new PaymentReceiptRowMapper());
    }
    @SuppressWarnings("deprecation")
   	@Override
       public List<PaymentReceipt> getAllReceipt(int userId) {
           String sql = "SELECT * FROM user_payments WHERE user_id = ? ORDER BY payment_date ";
           return jdbcTemplate.query(sql, new Object[]{userId}, new PaymentReceiptRowMapper());
       }
    private static class TenantRowMapper implements RowMapper<Tenant> {
        @Override
        public Tenant mapRow(ResultSet rs, int rowNum) throws SQLException {
            Tenant tenant = new Tenant();
            tenant.setId(rs.getInt("id"));
            tenant.setUserId(rs.getInt("users_id"));
            tenant.setEbBill(rs.getInt("eb_bill"));
            tenant.setRentAmount(rs.getInt("rent_amount"));
            return tenant;
        }
    }

    private static class PaymentReceiptRowMapper implements RowMapper<PaymentReceipt> {
        @Override
        public PaymentReceipt mapRow(ResultSet rs, int rowNum) throws SQLException {
            PaymentReceipt receipt = new PaymentReceipt();
            receipt.setId(rs.getInt("id"));
            receipt.setUserId(rs.getInt("user_id"));
            receipt.setAmount(rs.getInt("amount"));
            receipt.setPaymentDate(rs.getTimestamp("payment_date").toLocalDateTime());
            receipt.setReceiptNumber(rs.getString("receipt_number"));
            return receipt;
        }
    }
}    
