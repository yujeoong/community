package kr.co.withkbo.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class AdminDTO {
	private String userId;
	private String password;
	private String nickname;
	private String email;
	private String emailValid;
	private Timestamp regDate;
	private Date nickUpdateDate;
	private int sanctionNo;
	private int userLevel;
	private int status;
	private Timestamp updateDate;
	private int RowNum;
	
	
	public int getRowNum() {
		return RowNum;
	}
	public void setRowNum(int rowNum) {
		RowNum = rowNum;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Timestamp getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmailValid() {
		return emailValid;
	}
	public void setEmailValid(String emailValid) {
		this.emailValid = emailValid;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public Date getNickUpdateDate() {
		return nickUpdateDate;
	}
	public void setNickUpdateDate(Date nickUpdateDate) {
		this.nickUpdateDate = nickUpdateDate;
	}
	public int getSanctionNo() {
		return sanctionNo;
	}
	public void setSanctionNo(int sanctionNo) {
		this.sanctionNo = sanctionNo;
	}
	public int getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}
	
	

}
