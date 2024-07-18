package com.chainsys.flatmanagement.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.chainsys.flatmanagement.model.EbBill;
import com.chainsys.flatmanagement.model.Tenant;

@Repository
public interface TenantDao {
	public int findUserId(String email) ;
	public int addTenant(Tenant tenant) ;
	public List<Tenant> getAllTenants();
	public void deleteTenant(int tenantId);
	public EbBill addEbBill(int id, int newEbBill, String newEbBillStatus) throws Exception ;
	public List<Tenant> searchTenants(String query);
	public void updatePhoto(byte[] imageParts, int id) throws ClassNotFoundException;
}
