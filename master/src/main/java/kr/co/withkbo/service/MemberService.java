package kr.co.withkbo.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.MemberDAO;
import kr.co.withkbo.dto.MemberDTO;

@Service
public class MemberService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired MemberDAO dao;

	public MemberDTO login(String id, String pw) {
		logger.info("로그인 서비스");
		return dao.login(id,pw);
	}

	public int join(String id, String pw, String name, String email) {
		logger.info("회원가입 서비스");
		int row=0;
		if(dao.join(id,pw,name,email)>0) {			
			row = dao.joinstatus(id);
		}
		logger.info("회원가입 row: "+row);
		return row;
	}
	
	

	public boolean overlay(String userId) {
		String overlayId = dao.overlay(userId);
		logger.info("overlay ID : "+overlayId);
		return overlayId == null?false : true;
	}

	public boolean over(String nickName) {
		String overNickName = dao.over(nickName);
		logger.info("over nickName : "+overNickName);		
		return overNickName == null ? false : true;
	}

	public boolean overemail(String email) {
		String overlayEmail = dao.overemail(email);
		logger.info("over 이메일 : "+overlayEmail);		
		return overlayEmail == null ? false : true;
	}

	public int userStaUp(String id) {
		return dao.userStaUp(id);
	}

//	public String loginBlock(HashMap<String, String> params) {
//		logger.info("로그인 막기");
//		String status = params.get("status");
//		
//		return dao.loginBlock(status);
//	}










	







}
