package com.chainsys.flatmanagement.model;

import java.time.LocalDateTime;

public class PaymentReceipt {
	private int id;
	private int userId;
	private int amount;
	private LocalDateTime paymentDate;
	private String receiptNumber;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public LocalDateTime getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(LocalDateTime paymentDate) {
		this.paymentDate = paymentDate;
	}
	public String getReceiptNumber() {
		return receiptNumber;
	}
	public void setReceiptNumber(String receiptNumber) {
		this.receiptNumber = receiptNumber;
	}
	@Override
	public String toString() {
		return "PaymentReceipt [id=" + id + ", userId=" + userId + ", amount=" + amount + ", paymentDate=" + paymentDate
				+ ", receiptNumber=" + receiptNumber + "]";
	}
}
