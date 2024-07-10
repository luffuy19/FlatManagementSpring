package com.chainsys.flatmanagement.dao;

import java.util.List;

import com.chainsys.flatmanagement.model.PaymentReceipt;
import com.chainsys.flatmanagement.model.Tenant;

public interface PaymentDao {
    boolean checkUserPayment(int userId);
    Tenant getSpecificTenant(int userId);
    void savePayment(int userId, int amount, String receiptNumber);
    PaymentReceipt getReceipt(int userId);
	List<PaymentReceipt> getAllReceipt(int userId);
}
