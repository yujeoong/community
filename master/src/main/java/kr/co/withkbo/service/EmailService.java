package kr.co.withkbo.service;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber; 
	
	Logger logger = LoggerFactory.getLogger(this.getClass());


	
	private void makeRandomNumber() {
		Random r = new Random();
		int checkNum = r.nextInt(888888)+111111;
		logger.info("인증번호 : "+checkNum);
		authNumber = checkNum;
		
	}
	
	
	public String mailCheck(String email) {
		makeRandomNumber();
		
		String setFrom = "bawooljo1010@naver.com";
		String toMail = email;
		String title = "With KBO 가입 번호 이메일 입니다.";
		String content = 
				"With KBO 가입을 환영합니다!"+
				"<br><br>"+
				"아래의 인증 번호를 정확하게 입력해 주세요."+
				"<br><br>"+
				authNumber+
				"<br><br>"+
				"본 인증번호를 입력하셔야 회원가입이 가능합니다.";
		
		mailSend(setFrom,toMail,title,content);
				
		
		return Integer.toString(authNumber);
	}


	private void mailSend(String setFrom, String toMail, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
}
