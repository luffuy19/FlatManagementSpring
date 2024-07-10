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
	public Tenant() {
		
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
	
	public void setId(int id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setAadhaarNumber(String aadhaarNumber) {
		this.aadhaarNumber = aadhaarNumber;
	}
	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	public void setFamilyNembers(int familyNembers) {
		this.familyNembers = familyNembers;
	}
	public void setFlatType(String flatType) {
		this.flatType = flatType;
	}
	public void setFlatFloor(String flatFloor) {
		this.flatFloor = flatFloor;
	}
	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}
	public void setAdvanceAmount(int advanceAmount) {
		this.advanceAmount = advanceAmount;
	}
	public void setAdvanceStatus(String advanceStatus) {
		this.advanceStatus = advanceStatus;
	}
	public void setRentAmount(int rentAmount) {
		this.rentAmount = rentAmount;
	}
	public void setRentAmountStatus(String rentAmountStatus) {
		this.rentAmountStatus = rentAmountStatus;
	}
	public void setEbBill(int ebBill) {
		this.ebBill = ebBill;
	}
	public void setEbBillStatus(String ebBillStatus) {
		this.ebBillStatus = ebBillStatus;
	}
	public void setDateOfJoining(String dateOfJoining) {
		this.dateOfJoining = dateOfJoining;
	}
	public void setDateOfEnding(String dateOfEnding) {
		this.dateOfEnding = dateOfEnding;
	}
	public void setDeleteUser(String deleteUser) {
		this.deleteUser = deleteUser;
	}
	public void setUserId(int userId) {
		this.userId = userId;
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
