package kr.co.withkbo.dto;

import java.sql.Timestamp;

public class Admin_report_ProcessDTO {
	private int reportId;
	private String userId;
	private String pResult;
	private String pReason;
	private Timestamp regDate;
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
	public String getpResult() {
		return pResult;
	}
	public void setpResult(String pResult) {
		this.pResult = pResult;
	}
	public String getpReason() {
		return pReason;
	}
	public void setpReason(String pReason) {
		this.pReason = pReason;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	
	
	

}
