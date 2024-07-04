package com.chainsys.flatmanagement.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chainsys.flatmanagement.dao.TenantDao;
import com.chainsys.flatmanagement.model.EbBill;

@Service
public class TenantService {
	
	@Autowired
	TenantDao tenantDao; 
	
	public EbBill addEbBill(int id, int unit) throws Exception {
        int price;
        String status;
        if (unit > 100) {
            price = unit * 40;
            status = "no";
        } else if (unit > 400) {
            price = unit * 50;
            status = "no";
        } else {
            price = 0;
            status = "yes";
        }
        return tenantDao.addEbBill(id, price, status);
    }
}
