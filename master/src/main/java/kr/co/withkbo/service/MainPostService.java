package kr.co.withkbo.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.MainPostDAO;
import kr.co.withkbo.dto.MainPostDTO;

	@Service
	public class MainPostService {
	
	@Autowired MainPostDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public ArrayList<MainPostDTO> list_fa() {
		logger.info("list_fa");
		return dao.list_fa();
	}

	public ArrayList<MainPostDTO> list_in() {
		logger.info("list_in");
		return dao.list_in();
	}

	public ArrayList<MainPostDTO> list_po() {
		logger.info("list_po");
		return dao.list_po();
	}

	public MainPostDTO MainPostDet(String postId) {
		logger.info("메인포스트 디테일");
		MainPostDTO mainpostdto = dao.MainPostDet(postId);
		
		return mainpostdto;
	}
	
	


}
