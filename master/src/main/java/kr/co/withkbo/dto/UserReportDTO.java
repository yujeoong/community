package kr.co.withkbo.dto;

import java.sql.Date;

public class UserReportDTO {
	
	private int reportId; //신고번호
	private String userId; //신고자id
	private String reportType; //신고타입(글/댓글)
	private String id; //글 or 댓글 번호 (postId, commentId)
	private String reason; //신고사유
	private Date regDate; 
	private String status;
	private String content;
	private String subject;
	private String comContent;

	private String commentId;
	private String nickname; //닉네임
	
	
	public int getReportId() {
		return reportId;
	}
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getReportType() {
		return reportType;
	}
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}
	public String getId() {
		return id;
	}
	public void setId(String postId) {
		this.id = postId;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getCommentId() {
		return commentId;
	}
	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getComContent() {
		return comContent;
	}
	public void setComContent(String comContent) {
		this.comContent = comContent;
	}
	
	

	
	
	
	
	
	
	
	}
	
	
	
	
	

	
	
	
	