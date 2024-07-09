package com.chainsys.flatmanagement.model;

public class Message {
    private int id;
    private int userId;
    private String message;
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
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "Message [id=" + id + ", userId=" + userId + ", message=" + message +  "]";
	} 
    
    
}

