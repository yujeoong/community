package kr.co.withkbo.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.UserReportDAO;
import kr.co.withkbo.dto.UserReportDTO;

@Service
public class UserReportService {

	@Autowired UserReportDAO urdao;
	
	Logger logger=LoggerFactory.getLogger(getClass());



	public UserReportDTO reportForm(String id, String reportType) {
		UserReportDTO list = new UserReportDTO();
		if(reportType.equals("1")) {
			list = urdao.reportPostForm(id);
			logger.info("service list: "+list);
		}else if(reportType.equals("2")){
			logger.info("comment 2222 id  "+id);
			list = urdao.reportCommentForm(id);
		}
		
		return list;
	}



	public String report(String userId, HashMap<String, String> params) {
		UserReportDTO urdto = new UserReportDTO();
		urdto.setId(params.get("id"));
		urdto.setReason(params.get("reason"));
		urdto.setReportType(params.get("reportType"));
		urdto.setUserId(userId);
		
	
		
		urdao.report(urdto);
		
		//return "redirect:/{path}?postId="+postId;
		return "redirect:/";
	}









}
