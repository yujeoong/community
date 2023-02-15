package kr.co.withkbo.dto;

import java.sql.Date;

public class MyPageDTO {

	private String userId;
	private String password;
	private String nickname;
	private String email;
	private int point;
	private Date nickUpdateDate;

	public Date getNickUpdateDate() {
		return nickUpdateDate;
	}
	public void setNickUpdateDate(Date nickUpdateDate) {
		this.nickUpdateDate = nickUpdateDate;
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
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	
	
	
}
