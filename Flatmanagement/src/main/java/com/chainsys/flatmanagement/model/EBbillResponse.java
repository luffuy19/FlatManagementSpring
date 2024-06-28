package com.chainsys.flatmanagement.model;

public class EBbillResponse {
	int ebBill;
    String ebBillStatus;

    public EBbillResponse(int ebBill, String ebBillStatus) {
        this.ebBill = ebBill;
        this.ebBillStatus = ebBillStatus;
    }
}
