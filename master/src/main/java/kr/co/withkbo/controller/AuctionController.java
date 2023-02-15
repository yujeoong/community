package kr.co.withkbo.controller;

import java.util.ArrayList;
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

import kr.co.withkbo.dto.AuctionDTO;
import kr.co.withkbo.dto.BidLogDTO;
import kr.co.withkbo.service.AuctionService;
import kr.co.withkbo.service.PointService;

@Controller
public class AuctionController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired AuctionService aucservice;
	@Autowired PointService poservice;
	
	@RequestMapping(value = "/auction_detail")
	public String auction_detail(Model model, @RequestParam String postId) {
		logger.info("detail 요청, postId: "+postId);
		AuctionDTO dto = aucservice.detail(postId, "detail");
		ArrayList<BidLogDTO> bidlog = aucservice.bidLog(postId);
		if(dto !=null) {
			logger.info("데이터 가져왔음");
			model.addAttribute("info", dto);
			model.addAttribute("bidlog", bidlog);
		}else {
			model.addAttribute("msg", "데이터를 가져오는데 실패했습니다");
		}
		return "auction_detail";
	}
	
	@RequestMapping(value="bidding", method = RequestMethod.POST)
	public String bidding(Model model, HttpServletRequest req, HttpSession session) {
		logger.info("bidding 요청");
		String bidmsg="";
		String referer = req.getHeader("Referer");
		String url = referer;
		String loginId = (String) session.getAttribute("sessionId");
		
		if(loginId != null && !loginId.equals("")){ 
			int loginLevel = (Integer) session.getAttribute("sessionLevel");		
			if(loginLevel == 3) {
				String postId = req.getParameter("postId");
				int bidPoint = Integer.parseInt(req.getParameter("bidPoint"));
				int userPoint = poservice.userPoint(loginId);
				logger.info("id: "+postId);
				logger.info("point: "+bidPoint);
				bidmsg = aucservice.bidding(postId, loginId, bidPoint, userPoint);			
			}else if(loginLevel == 2){
				bidmsg = "관리자는 입찰이 불가능합니다.";
			}
		}else{
			bidmsg = "로그인이 필요한 서비스입니다.";
		}
		model.addAttribute("msg", bidmsg);
		model.addAttribute("url", url);
		return "alert";
	}
	
	@RequestMapping(value = "/bidLog")
	public String bidLog(Model model, @RequestParam String postId) {
		logger.info("입찰로그 호출");
		model.addAttribute("postId", postId);
		return "bidLog";
	}
	
	@RequestMapping(value="/bidLogCall")
	@ResponseBody
	public HashMap<String, Object> listCall(HttpSession session, @RequestParam String postId) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(session.getAttribute("sessionId") !=null) {
			ArrayList<BidLogDTO> list = aucservice.bidLog(postId);
			map.put("list", list);
			map.put("login", true);
		}else {
			map.put("login", false);
		}
		return map;
	}
	
	@RequestMapping(value="/auctionConfirm")
		public String auctionConfirm(Model model, @RequestParam String postId){
		String msg = aucservice.aucConfirm(postId);
		model.addAttribute("msg", msg);
		model.addAttribute("url", "closePopUp");
		return "alert";
	}

}
