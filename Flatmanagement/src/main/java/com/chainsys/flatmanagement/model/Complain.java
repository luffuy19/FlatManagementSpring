package com.chainsys.flatmanagement.model;

public class Complain {
	int id; 
	String complainType; 
	String comments; 
	String complainDate; 
	String complainStatus; 
	int userId;
	String doorNo;
	String floorNo;
	public Complain(int id, String complainType, String comments, String complainDate, String complainStatus,
			int userId, String doorNo, String floorNo) {
		super();
		this.id = id;
		this.complainType = complainType;
		this.comments = comments;
		this.complainDate = complainDate;
		this.complainStatus = complainStatus;
		this.userId = userId;
		this.doorNo = doorNo;
		this.floorNo = floorNo;
	}
	public int getId() {
		return id;
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
	public String getDoorNo() {
		return doorNo;
	}
	public String getFloorNo() {
		return floorNo;
	}
	@Override
	public String toString() {
		return "Complain [id=" + id + ", complainType=" + complainType + ", comments=" + comments + ", complainDate="
				+ complainDate + ", complainStatus=" + complainStatus + ", userId=" + userId + ", doorNo=" + doorNo
				+ ", floorNo=" + floorNo + "]";
	}
	
}
