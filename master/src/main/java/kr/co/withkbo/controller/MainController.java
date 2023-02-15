package kr.co.withkbo.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.withkbo.dto.MemberDTO;
import kr.co.withkbo.service.MemberService;


@Controller
public class MainController {
	
	@Autowired MemberService service; 
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm(Model model, HttpServletRequest req) {	
		
		
		return "login";
	}

	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model, HttpServletRequest req) {		
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		logger.info(id+"/"+pw);		
		
		String page = "homeMain";
		MemberDTO loginId = service.login(id, pw);
		logger.info("loginId : "+loginId);
		
		try {
			if(loginId != null && !loginId.equals("")) {
				page = "redirect:/";
		
				HttpSession session = req.getSession();
				session.setAttribute("loginBlock", loginId.getStatus());
				
				if(loginId.getStatus() == 1) {
					session.setAttribute("sessionId", loginId.getUserId());
					session.setAttribute("sessionLevel", loginId.getUserLevel());
					// model.addAttribute("msg","로그인 완료");
				}else if(loginId.getStatus() == 2) {
					page = "homeMain";
					session.setAttribute("loginCal", loginId.getUpdateDate());
					logger.info("유저 날짜 : "+loginId.getUpdateDate());
					
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date currentTime = new Date();
					String date = format.format(currentTime);
					
					Date today = format.parse(date);
					
					logger.info("today : "+date);
					
					Date startDate = format.parse(loginId.getUpdateDate());
					
					int compare = today.compareTo(startDate);
					
					logger.info("차이 : "+compare);
					
					if(compare>6) {
						int userStaUp = service.userStaUp(id);
						if(userStaUp>0) {
							session.setAttribute("sessionId", loginId.getUserId());
							session.setAttribute("sessionLevel", loginId.getUserLevel());
							model.addAttribute("msg","일시정지가 풀렸습니다.");							
						}
					}else {
						
						model.addAttribute("msg","일시정지 된 계정입니다.");
					}
										
				}else{
					model.addAttribute("msg","탈퇴한 계정입니다.");
					page = "homeMain";
				}		

				
			}else if(loginId == null){
				
				logger.info("loginId null : ");
				page = "login";
				model.addAttribute("msg", "아이디 또는 패스워드를 확인해 주세요");
				
			}

			
			logger.info("sessionId : "+loginId.getUserId());
			logger.info("sessionLevel : "+loginId.getUserLevel());
			logger.info("loginBlock : "+ loginId.getStatus());
			
		} catch (Exception e) {			
			
		}
		return page;
		}	

	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		logger.info("로그아웃서비스");
		session.removeAttribute("sessionId");
		session.removeAttribute("sessionLevel");
		return "redirect:/";
	}
	
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String joinForm(Model model) {
		return "join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(Model model, HttpServletRequest req) {
		
		String page = "join";
		String msg = "회원가입에 실패했습니다.";
		
		String id = req.getParameter("userId");
		String pw = req.getParameter("userPass1");
		String name = req.getParameter("userName");
		String email = req.getParameter("email");
		
		logger.info(id+"/"+pw+"/"+name+"/"+email);
		
		try {
			int row = service.join(id,pw,name,email);
			
			if(row>0) {
				page = "home";
				msg = "회원가입에 성공 했습니다.";
			}			
			
		} catch (Exception e) {
			msg="중복된 아이디 입니다.";
		}		

		model.addAttribute("msg",msg);
		
		return page;
	}
	

	

	
	
	@RequestMapping(value="/overlay")
	@ResponseBody	
	public HashMap<String, Object> overlay(@RequestParam String userId) {
		
		boolean overlay = true;
		logger.info("아이디 중복 체크 : "+userId);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		overlay = service.overlay(userId);
		
		
		map.put("overlay", overlay);
		
		return map;
	}
	
	@RequestMapping(value="/over")
	@ResponseBody
	public HashMap<String, Object> over(@RequestParam String nickName) {
		boolean over = true;
		logger.info("닉네임 중복체크 : "+nickName);		
		HashMap<String, Object> map = new HashMap<String, Object>();		
		
		over = service.over(nickName);
		
		map.put("over", over);		
		return map;
	}
	
	@RequestMapping(value="/overEmail")
	@ResponseBody
	public HashMap<String, Object> overEmail(@RequestParam String email) {
		boolean overEmail = true;
		logger.info("이메일 중복 체크 :"+email);		
		HashMap<String, Object> map = new HashMap<String, Object>();		
		
		overEmail = service.overemail(email);
		
		map.put("overEmail", overEmail);		
		return map;
	}	
	
	@RequestMapping(value="/ajaxJoin")
	@ResponseBody	
	public HashMap<String, Object> ajaxJoin(@RequestParam HashMap<String, String> params) {

			
		logger.info("params : {}",params);
		String id = params.get("userId").replaceAll("\\s", "");
		String pw = params.get("password").replaceAll("\\s", "");
		String name = params.get("nickname").replaceAll("\\s", "");
		String email = params.get("email").replaceAll("\\s", "");
		
		int row = service.join(id, pw, name, email);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", row);
		
		return map;
	}
	

	
	
	
}
