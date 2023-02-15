package kr.co.withkbo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.PointDAO;

@Service
public class PointService {

	@Autowired PointDAO podao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public int userPoint(String userId) {
		int userPoint;
		try {
			userPoint = podao.userPoint(userId);
		} catch (Exception e) {
			userPoint = 0;
		}
		return userPoint;
	}

	public String setPoint(String userId, String type, int point) {
		String resultCode ="";
		int pointId = 0;
		if(type.equals("add")) {
			podao.addPoint(userId,point,"관리자권한적립");
		}else if(type.equals("use")) {
			podao.usePoint(userId,point,"관리자권한차감",resultCode,pointId);
		}
		return resultCode;
	}


}
