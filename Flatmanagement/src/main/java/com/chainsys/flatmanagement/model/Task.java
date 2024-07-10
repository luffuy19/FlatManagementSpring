package com.chainsys.flatmanagement.model;

public class Task {
    private int id;
    private int employeeId;
    private int complainId;
    private String complainType;
    private String comments;
    private String complainDate;
    private String complainStatus;
    private int userId;
    
    // Constructor
    public Task(int id, int employeeId, int complainId, String complainType, String comments, String complainDate, String complainStatus, int userId) {
        this.id = id;
        this.employeeId = employeeId;
        this.complainId = complainId;
        this.complainType = complainType;
        this.comments = comments;
        this.complainDate = complainDate;
        this.complainStatus = complainStatus;
        this.userId = userId;
    }

	public int getId() {
		return id;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public int getComplainId() {
		return complainId;
	}

	public String getComplainType() {
		return complainType;
	}

	public String getComments() {
		return comments;
	}

	public String getComplainDate() {
		return complainDate;
	}

	public String getComplainStatus() {
		return complainStatus;
	}

	public int getUserId() {
		return userId;
	}

    
}
