package kr.co.withkbo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.MainDAO;

@Service
public class MainService {
	
	@Autowired MainDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public String login(String id, String pw) {
		logger.info("�α��� ����");
		return dao.login(id,pw);
	}

	public int join(String id, String pw, String name, String email) {
		logger.info("ȸ������ ����");
		return dao.join(id,pw,name,email);
	}


}
