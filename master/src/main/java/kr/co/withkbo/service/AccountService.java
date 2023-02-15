package kr.co.withkbo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.AccountDAO;

@Service
public class AccountService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired AccountDAO dao;


	

	public String ResetPw(String email, String userId) {
		logger.info("비밀번호 찾기");
		return dao.ResetPw(email,userId);
	}

	public int pwUpdate(String newPw, String userId) {
		return dao.pwUpdate(newPw,userId);
	}

	public String idfind(String email) {
		
		return dao.idfind(email);
	}

}
