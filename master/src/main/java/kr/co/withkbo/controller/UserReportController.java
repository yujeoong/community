package kr.co.withkbo.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.withkbo.dto.UserReportDTO;
import kr.co.withkbo.service.UserReportService;

@Controller
public class UserReportController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired UserReportService urservice;

	
	@RequestMapping(value="/reportForm")
	public String reportForm(Model model, HttpServletRequest req, HttpSession session) {
		String reportType = (String) req.getParameter("reportType");
		String id = (String) req.getParameter("id"); //postId 또는 commentId
		
		logger.info("report form 요청"+id+reportType);
		

		
		//글/댓글, 작성자, 내용
		UserReportDTO list = urservice.reportForm(id, reportType);
		logger.info("나오는데용!"+list);
		if(list != null) {
			model.addAttribute("list",list);
			model.addAttribute("reportType", reportType);
			model.addAttribute("id",id);
			logger.info("서비스의 list "+list.getComContent());
		}
		return "reportForm";
	}
	
	@RequestMapping(value="/report") 
	//HttpServletRequest req, @RequestParam String reason
	public String report(HttpSession session, @RequestParam HashMap<String,String> params) {
		String userId =(String) session.getAttribute("sessionId"); //신고자 id 
		logger.info("params{}"+params);
		return urservice.report(userId, params);
	}
	
	
	
	
	
	
	
	
	
}
