package com.chainsys.flatmanagement.model;

import java.io.Serializable;

public class Visitor implements Serializable {
	private static final long serialVersionUID = 1L;
	
	int id ;
    String visitorName ;
    String inTime ;
    String outTime;
    String inDate;
    String outDate;
    int flatFloor;
    String roomNo;
    String timestamp ;
	public Visitor(int id, String visitorName, String inTime, String outTime, String inDate, String outDate,
			int flatFloor, String roomNo, String timestamp) {
		super();
		this.id = id;
		this.visitorName = visitorName;
		this.inTime = inTime;
		this.outTime = outTime;
		this.inDate = inDate;
		this.outDate = outDate;
		this.flatFloor = flatFloor;
		this.roomNo = roomNo;
		this.timestamp = timestamp;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public int getId() {
		return id;
	}
	public String getVisitorName() {
		return visitorName;
	}
	public String getInTime() {
		return inTime;
	}
	public String getOutTime() {
		return outTime;
	}
	public String getInDate() {
		return inDate;
	}
	public String getOutDate() {
		return outDate;
	}
	public int getFlatFloor() {
		return flatFloor;
	}
	public String getRoomNo() {
		return roomNo;
	}
	public String getTimestamp() {
		return timestamp;
	}
	
	public String toString() {
		return "Visitor [id=" + id + ", visitorName=" + visitorName + ", inTime=" + inTime + ", outTime=" + outTime
				+ ", inDate=" + inDate + ", outDate=" + outDate + ", flatFloor=" + flatFloor + ", room_no=" + roomNo
				+ ", timestamp=" + timestamp + "]";
	}
    
    
}	