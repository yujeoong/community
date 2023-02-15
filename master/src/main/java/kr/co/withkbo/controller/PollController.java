package kr.co.withkbo.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.withkbo.service.PollService;

@Controller
public class PollController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired PollService pollservice;

//	@RequestMapping(value="/doPoll")
//	public String doPoll(Model model, HttpServletRequest req, HttpSession session) {
//		String pollId = req.getParameter("pollId");
//		logger.info("poll 요청"+pollId);
//		String referer = req.getHeader("Referer");
//		String url = referer;
//		String bidmsg="투표완료";
//		String loginId = (String) session.getAttribute("sessionId");
//		
//		if(loginId != null && !loginId.equals("")) {
//			bidmsg = pollservice.doPoll(pollId, loginId);			
//		}else {
//			bidmsg = "로그인이 필요한 서비스입니다.";
//		}
//		model.addAttribute("msg", bidmsg);
//		model.addAttribute("url", url);
//		return "alert";
//	}

	@RequestMapping(value="/doPoll2")
	@ResponseBody
	public HashMap<String, Object> doPoll2(@RequestParam String pollId, HttpSession session) {
		String bidmsg="투표완료";
		String loginId = (String) session.getAttribute("sessionId");
		
		logger.info("dopoll 요청"+pollId+":"+loginId);
		if(loginId != null && !loginId.equals("")) {
			bidmsg = pollservice.doPoll(pollId, loginId);			
		}else {
			bidmsg = "로그인이 필요한 서비스입니다.";
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("msg", bidmsg);
		return map;
	}
	

	
}
