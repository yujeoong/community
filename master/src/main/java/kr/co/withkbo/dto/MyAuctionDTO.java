package kr.co.withkbo.dto;

import java.sql.Date;

public class MyAuctionDTO {

	private int postId;
	private Date endDate;
	private int StartingPoint;
	private int winningPoint;
	private String winnerId;
	private String userId;
	private String subject;
	private Date regDate;
	
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getStartingPoint() {
		return StartingPoint;
	}
	public void setStartingPoint(int startingPoint) {
		StartingPoint = startingPoint;
	}
	public int getWinningPoint() {
		return winningPoint;
	}
	public void setWinningPoint(int winningPoint) {
		this.winningPoint = winningPoint;
	}
	public String getWinnerId() {
		return winnerId;
	}
	public void setWinnerId(String winnerId) {
		this.winnerId = winnerId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
	
}
