package kr.co.withkbo.dto;

import java.sql.Timestamp;

public class AuctionDTO {
	private int postId;
	private String userId;
	private String subject;
	private Timestamp regDate;
	private String content;
	private int views;
	private String blind;
	
	private String endDate;
	private int startingPoint;
	private String winnerId;
	private int winningPoint;
	
	private int fileId;
	private String newFileName;
	
	
	
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public String getBlind() {
		return blind;
	}
	public void setBlind(String blind) {
		this.blind = blind;
	}


	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public int getStartingPoint() {
		return startingPoint;
	}
	public void setStartingPoint(int startingPoint) {
		this.startingPoint = startingPoint;
	}
	
	
	
	public String getWinnerId() {
		return winnerId;
	}
	public void setWinnerId(String winnerId) {
		this.winnerId = winnerId;
	}
	public int getWinningPoint() {
		return winningPoint;
	}
	public void setWinningPoint(int winningPoint) {
		this.winningPoint = winningPoint;
	}

	public int getFileId() {
		return fileId;
	}
	public void setFileId(int fileId) {
		this.fileId = fileId;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}
	
}
