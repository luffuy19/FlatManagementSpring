package com.chainsys.flatmanagement.model;

import java.util.Arrays;

public class Tenant {
	int id ; 
	String name;
	String phoneNo;
	String email;
	String aadhaarNumber; 
	byte[] photo;
	int familyNembers;
	String flatType;
	String flatFloor;
	String roomNo;
	int advanceAmount;
	String advanceStatus;
	int rentAmount;
	String rentAmountStatus;
	int ebBill;
	String ebBillStatus;
	String dateOfJoining;
	String dateOfEnding;
	String deleteUser;
	int userId;
	public Tenant(int id, String name, String phoneNo, String email, String aadhaarNumber, byte[] photo,
			int familyNembers, String flatType, String flatFloor, String roomNo, int advanceAmount,
			String advanceStatus, int rentAmount, String rentAmountStatus, int ebBill, String ebBillStatus,
			String dateOfJoining, String dateOfEnding, String deleteUser, int userId) {
		super();
		this.id = id;
		this.name = name;
		this.phoneNo = phoneNo;
		this.email = email;
		this.aadhaarNumber = aadhaarNumber;
		this.photo = photo;
		this.familyNembers = familyNembers;
		this.flatType = flatType;
		this.flatFloor = flatFloor;
		this.roomNo = roomNo;
		this.advanceAmount = advanceAmount;
		this.advanceStatus = advanceStatus;
		this.rentAmount = rentAmount;
		this.rentAmountStatus = rentAmountStatus;
		this.ebBill = ebBill;
		this.ebBillStatus = ebBillStatus;
		this.dateOfJoining = dateOfJoining;
		this.dateOfEnding = dateOfEnding;
		this.deleteUser = deleteUser;
		this.userId = userId;
	}
	public int getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public String getEmail() {
		return email;
	}
	public String getAadhaarNumber() {
		return aadhaarNumber;
	}
	public byte[] getPhoto() {
		return photo;
	}
	public int getFamilyNembers() {
		return familyNembers;
	}
	public String getFlatType() {
		return flatType;
	}
	public String getFlatFloor() {
		return flatFloor;
	}
	public String getRoomNo() {
		return roomNo;
	}
	public int getAdvanceAmount() {
		return advanceAmount;
	}
	public String getAdvanceStatus() {
		return advanceStatus;
	}
	public int getRentAmount() {
		return rentAmount;
	}
	public String getRentAmountStatus() {
		return rentAmountStatus;
	}
	public int getEbBill() {
		return ebBill;
	}
	public String getEbBillStatus() {
		return ebBillStatus;
	}
	public String getDateOfJoining() {
		return dateOfJoining;
	}
	public String getDateOfEnding() {
		return dateOfEnding;
	}
	public String getDeleteUser() {
		return deleteUser;
	}
	public int getUserId() {
		return userId;
	}
	public String toString() {
		return "Tenant [id=" + id + ", name=" + name + ", phoneNo=" + phoneNo + ", email=" + email + ", aadhaarNumber="
				+ aadhaarNumber + ", photo=" + Arrays.toString(photo) + ", familyNembers=" + familyNembers
				+ ", flatType=" + flatType + ", flatFloor=" + flatFloor + ", roomNo=" + roomNo + ", advanceAmount="
				+ advanceAmount + ", advanceStatus=" + advanceStatus + ", rentAmount=" + rentAmount
				+ ", rentAmountStatus=" + rentAmountStatus + ", ebBill=" + ebBill + ", ebBillStatus=" + ebBillStatus
				+ ", dateOfJoining=" + dateOfJoining + ", dateOfEnding=" + dateOfEnding + ", deleteUser=" + deleteUser
				+ ", user_id=" + userId + "]";
	}
	
	
	
	
		
}
