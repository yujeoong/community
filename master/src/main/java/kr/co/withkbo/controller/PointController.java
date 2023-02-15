package kr.co.withkbo.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.withkbo.service.PointService;

@Controller
public class PointController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired PointService poservice;
	
	@RequestMapping(value="/adminPoint")
	public String adminPoint(Model model, HttpServletRequest req) {
		String userId = req.getParameter("userId");
		model.addAttribute("userId", userId);
		model.addAttribute("userPoint", poservice.userPoint(userId));
		return "adminPoint";
	}

	@RequestMapping(value="/adminSetPoint", method = RequestMethod.POST)
	public String adminSetPoint(HttpServletRequest req) {
		String userId = req.getParameter("userId");
		String type = req.getParameter("type");
		int point = Integer.parseInt(req.getParameter("point"));
		poservice.setPoint(userId, type, point);
		/*		String adpomsg ="승인";
		String url = "adminPoint";
		logger.info("관리자포인트결과: "+resultCode);
		if(resultCode.equals("F")) {
			adpomsg="포인트 부족";
		}else if(resultCode.equals("E")) {
			adpomsg="오류";
		}
		model.addAttribute("msg", adpomsg);
		model.addAttribute("url", url);*/
		return "redirect:/adminPoint?userId="+userId;
	}
}
