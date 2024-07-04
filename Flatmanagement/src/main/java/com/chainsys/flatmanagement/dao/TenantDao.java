package com.chainsys.flatmanagement.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.chainsys.flatmanagement.model.EbBill;
import com.chainsys.flatmanagement.model.Tenant;
import com.chainsys.flatmanagement.model.User;

@Repository
public interface TenantDao {
	public List<User> findAllUsers();
	public int findUserId(String email) ;
	public int addTenant(Tenant tenant) ;
	public List<Tenant> getAllTenants();
	public void deleteTenant(int tenantId);
	public EbBill addEbBill(int id, int newEbBill, String newEbBillStatus) throws Exception ;
	public List<Tenant> searchTenants(String query);
}
