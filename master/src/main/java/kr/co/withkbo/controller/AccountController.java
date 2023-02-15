package kr.co.withkbo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.withkbo.service.AccountService;

@Controller 
public class AccountController {
	
	@Autowired AccountService service;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	

	
	@RequestMapping(value = "/idfindForm", method= RequestMethod.GET)
	public String idfindForm(Model model) {	
		logger.info("ResetPwForm");
		
		return "find";
	}
	
	@RequestMapping(value = "/idfind", method= RequestMethod.POST)
	public String idfind(Model model, HttpServletRequest req) {	
		
		String email = req.getParameter("email");
		
		logger.info("email : "+email);
		
		String page = "find";
		String emails = service.idfind(email);
		
		logger.info("email : "+email);
		
		if(emails != null && !emails.equals("")) {
			page= "idfind";
			HttpSession session = req.getSession();
			session.setAttribute("emails", emails);
			logger.info(emails);
			model.addAttribute("email",email);
		}else {
			model.addAttribute("msg","등록된 이메일이 아닙니다.");
		}
		
		return page;
	}
	
	@RequestMapping(value = "/idRemember", method= RequestMethod.GET)
	public String idRemember(Model model, HttpServletRequest req) {	
		logger.info("idRemember");
		
		String email = req.getParameter("email");
		String userId = req.getParameter("userId");
		
		logger.info("email : "+email+"/"+"userId : "+userId);
		
		model.addAttribute("email",email);
		model.addAttribute("userId",userId);
		
		return "find";
	}
	
	
	
	
	
	@RequestMapping(value = "/ResetPwForm", method= RequestMethod.GET)
	public String ResetPwForm(Model model) {	
		logger.info("ResetPwForm");
		
		return "find";
	}
	
	@RequestMapping(value = "/ResetPw", method = RequestMethod.POST)
	public String ResetPw(Model model, HttpServletRequest req){	
		
		logger.info("ResetPw");
		
		String email = req.getParameter("email");
		String userId = req.getParameter("userId");
		
		logger.info("email : "+email+"/ userId : "+userId);
		String page = "find";
		
		String loginPw = service.ResetPw(email,userId);
		if(loginPw != null && !loginPw.equals("")) {
			page = "pwreset";
			req.setAttribute("userId", userId);
			model.addAttribute("msg","비밀번호를 재설정 해주세요");
			logger.info(loginPw);
		}else {
			model.addAttribute("msg","아이디와 이메일을 확인해 주세요");
		}
		
		return page;
	}
	
	@RequestMapping(value = "/updatePw", method = RequestMethod.POST)
	public String updatePw(Model model, HttpServletRequest req) {
		
		String newPw = req.getParameter("newPw").replaceAll("\\s", "");
		String userId = req.getParameter("userId").replaceAll("\\s", "");
		
		logger.info(newPw+"/"+userId);
		String page = "pwreset";
		
		int pwUpcnt = service.pwUpdate(newPw,userId);
		logger.info("pwUpcnt : "+pwUpcnt);
		
		if(pwUpcnt>0) {
			page = "redirect:/";
		}else {
			model.addAttribute("msg","사용 할 수 없는 비밀번호입니다");
		}
		
		return page;
	}
	

}
