package com.chainsys.flatmanagement.model;

public class Employee {
	int id; 
	String name; 
	String phoneNumber; 
	String department;
	
	public Employee(int id, String name, String phoneNumber, String department) {
		super();
		this.id = id;
		this.name = name;
		this.phoneNumber = phoneNumber;
		this.department = department;
	}
	public int getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public String getDepartment() {
		return department;
	}
	@Override
	public String toString() {
		return "Employee [id=" + id + ", name=" + name + ", phoneNumber=" + phoneNumber + ", department=" + department
				+ "]";
	}
	
}
