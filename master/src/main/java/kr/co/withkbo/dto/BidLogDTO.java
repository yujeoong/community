package kr.co.withkbo.dto;

import java.sql.Timestamp;

public class BidLogDTO {
	private String userId;
	private int bidPoint;
	private Timestamp bidDate;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getBidPoint() {
		return bidPoint;
	}
	public void setBidPoint(int bidPoint) {
		this.bidPoint = bidPoint;
	}
	public Timestamp getBidDate() {
		return bidDate;
	}
	public void setBidDate(Timestamp bidDate) {
		this.bidDate = bidDate;
	}

}
