package kr.co.withkbo.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import kr.co.withkbo.dto.BoardDTO;
import kr.co.withkbo.dto.PollDTO;
import kr.co.withkbo.service.DetailPageService;

@Controller
public class DetailPageController {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired DetailPageService dpageservice;
	
	@RequestMapping(value = "/postDetail")
	public String pollDetail(Model model, @RequestParam String postId) {
		logger.info("detail 요청, postId: "+postId);
		BoardDTO bdto = dpageservice.dpage(postId, "detail");
		if(bdto != null) {
			model.addAttribute("post", bdto);
		}
		return "postDetail";
	}	

	
	@RequestMapping(value = "/pollDetailCall", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> pollDetailCall(@RequestParam String postId, HttpSession session) {
		String loginId = "";
		if(session.getAttribute("sessionId") != null) {			
			loginId = (String) session.getAttribute("sessionId");
		}else {
			loginId = "noLogin";
		}
		return dpageservice.pollDetail(postId, loginId);
	}
	
	@RequestMapping(value="/matchResultForm")
	public String matchResultForm(Model model,@RequestParam String postId){
		ArrayList<PollDTO> pollList = dpageservice.pollList(postId);
		model.addAttribute("pollList", pollList);
		model.addAttribute("postId", postId);
		return "matchResult";
	}
	
	@RequestMapping(value="/matchResult")
	public String matchResult(Model model, HttpServletRequest req) throws ParseException {
		String url="closePopUp";
		String msg="";
		String pollId = req.getParameter("winPollId");
		String postId = req.getParameter("postId");
		ArrayList<PollDTO> pollList = dpageservice.pollList(postId);
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
	    Date time = new Date();
		String current = format.format(time);
		String endDate = pollList.get(0).getEndDate();
		Date today = null;
		Date end = null;
		try {
			today = format.parse(current);
			end = format.parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
			
		int result = today.compareTo(end);
		logger.info("결과: "+result);

		if(result<0){
			msg="투표가 종료되지 않았습니다.";
		}else if(dpageservice.matchResultChk(postId)>0) {
			msg="이미 입력되었습니다.";
		}else if(dpageservice.matchResult(pollId)>0) {
			msg="입력&포인트 지급 완료";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "alert";
	}
	
}
