package kr.co.withkbo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.withkbo.service.EmailService;

@Controller
public class EmailController {

	@Autowired EmailService service;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		logger.info("이메일 요청 들어옴");
		logger.info("요청 이메일 : "+email);
		return service.mailCheck(email);
		
	}

	
}
