package kr.co.withkbo.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.AddressDAO;
import kr.co.withkbo.dto.AddressDTO;
import kr.co.withkbo.dto.AuctionDTO;

@Service
public class AddressService {
	
	@Autowired AddressDAO dao;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	

	public int addr(String postId, String userId, String name, String phone, String postcode, String roadAddr, String detailAddr, String memo) {
		logger.info("배송 저장 서비스");
		
		
		return dao.addr(postId, userId,name,phone,postcode,roadAddr,detailAddr,memo);
	}


	public AddressDTO updateForm(String postId) {
		logger.info("주소 업데이트 폼");
			
		return dao.detail(postId);
	}


	public void update(HashMap<String, String> params) {
		int row = dao.update(params);
		logger.info("row : "+row);
		
	}


	public AddressDTO detail(String postId) {
		logger.info("디테일 서비스");
		
		AddressDTO dto = dao.detail(postId);
		
		return dto;
	}

	public ArrayList<AddressDTO> susBid_list() {
		logger.info("낙찰 리스트 서비스");
		return dao.susBid_list();
	}


	public AddressDTO winner() {
		return dao.winner();
	}


	public AddressDTO post() {
		return dao.post();
	}


	public AddressDTO shipping(String postId) {
		return dao.shipping(postId);
	}


	public AddressDTO winnerIdChk(String postId) {
		return dao.winnerIdChk(postId);
	}

}
