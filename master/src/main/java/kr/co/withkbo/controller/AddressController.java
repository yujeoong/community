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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.withkbo.dto.AddressDTO;
import kr.co.withkbo.service.AddressService;

@Controller
public class AddressController {
	
	@Autowired AddressService service;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/addrForm", method = RequestMethod.GET)
	public String addrForm(Model model, HttpServletRequest req, HttpSession session) {
		String page ="";
		String postId = req.getParameter("postId");
		String lgId = (String) session.getAttribute("sessionId");
		AddressDTO addto = service.shipping(postId);
		if(lgId != null) {
			if(addto != null) {
				page="auction_update";
				model.addAttribute("shipping", addto);
			}else {
				page = "auctionwrite";
				model.addAttribute("postId",postId);
			}
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		
		return page;
	}
	
//	@RequestMapping(value = "/addrget", method = RequestMethod.GET)
//	public String addrget(Model model, HttpServletRequest req) {	
//		
//		
//		return "addr";
//	}
	
	
	@RequestMapping(value = "/addr", method = RequestMethod.POST)
	public String addr(Model model, HttpServletRequest req) {
		
		String page = "redirect:/";
		String msg = "배송정보 저장에 실패했습니다.";
		
		String postId = req.getParameter("postId");
		AddressDTO winnerId = service.winnerIdChk(postId);
		
		HttpSession session = req.getSession();
		session.setAttribute("winId", winnerId.getWinnerId());
		
		logger.info("postId : "+postId);
		logger.info("winId : "+winnerId.getWinnerId());
		
		
		String userId= (String) session.getAttribute("sessionId");
		logger.info("userId : "+userId);
		
		
		if(winnerId.getWinnerId().equals(userId)) {

			String name = req.getParameter("name");
			String phone = req.getParameter("phone");
			String postcode = req.getParameter("postcode");
			String roadAddr = req.getParameter("roadAddr");
			String detailAddr = req.getParameter("detailAddr");
			String memo = req.getParameter("memo");
			
			logger.info(postId+"/"+name+"/"+phone+"/"+postcode+"/"+roadAddr+"/"+detailAddr+"/"+memo);
			
			try {
				int row = service.addr(postId,userId,name,phone,postcode,roadAddr,detailAddr,memo);
				
				if(row>0) {
					page="myAuction";
					msg = "배송정보를 저장하였습니다.";
				}
			} catch (Exception e) {
				msg = "배송정보 저장에 실패했습니다.";
			}
			
			model.addAttribute("msg",msg);
			
		}else {
			
			page = "homeMain";
			model.addAttribute("msg","낙찰된 아이디가 아닙니다.");			
		}
		
		return page;
	}
	
//	@RequestMapping(value="/ajaxAddr")
//	@ResponseBody	
//	public HashMap<String, Object> ajaxAddr(@RequestParam HashMap<String, String> params, HttpServletRequest req) {
//		
//		String page = "redirect:/";
//		String msg = "배송정보 저장에 실패했습니다.";
//		
//		String postId = req.getParameter("postId");
//		AddressDTO winnerId = service.winnerIdChk(postId);
//		logger.info("postId : "+postId);
//		
//		HttpSession session = req.getSession();
//		String userId= (String) session.getAttribute("sessionId");
//		logger.info("userId : "+userId);
//		logger.info("winnerId :"+winnerId);
//		
//			
//		logger.info("params : {}",params);
//		String name = params.get("name");
//		String phone = params.get("phone");
//		String postcode = params.get("postcode");
//		String roadAddr = params.get("roadAddr");
//		String detailAddr = params.get("detailAddr");
//		String memo = params.get("memo");		
//		
//		
//		int row = service.addr(postId,userId,name,phone,postcode,roadAddr,detailAddr,memo);
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("success", row);
//		
//		return map;
//	}
	
	
//	@RequestMapping(value = "/addrlist", method = RequestMethod.GET)
//	public String addrlist(Model model, HttpServletRequest req) {
//		logger.info("낙찰 리스트 컨트롤러");
//		
//		ArrayList<AddressDTO>  auclist = service.susBid_list();
//		
//		
//		HttpSession session = req.getSession();		
//		String userId= (String) session.getAttribute("sessionId");
//		
//		AddressDTO winnnerId = service.winner();		
//		session.setAttribute("winnerId", winnnerId.getWinnerId());
//		String winnerId = (String) session.getAttribute("winnerId");
//		
//		String page = "auc_sav_list";		
//		
//		if(userId == null) {
//			model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
//			page = "homeMain";
//		}
//		else if(userId != winnerId) {
//			model.addAttribute("msg", "당첨된 회원이 아닙니다.");
//			page = "homeMain";
//		}else if(userId == winnerId) {
//			model.addAttribute("msg","배송 정보 저장 페이지로 이동합니다.");
//		}
//		
//		logger.info("userId : "+userId);		
//		
//		model.addAttribute("auclist",auclist);		
//		return page;
//	}
	
	
	
//	@RequestMapping(value="/addrDetail")
//	public String detail(Model model, @RequestParam String postId) {
//				
//		logger.info("postId : {}",postId);
//		String page = "redirect:/";
//		AddressDTO dto = service.detail(postId);
//		
//		if(dto != null) {
//			page = "auction_saved";
//			model.addAttribute("shipping", dto);			
//		}
//		return page;
//	}
	
	@RequestMapping(value="/addrUpdateForm")
	public String updateForm(Model model, @RequestParam String postId) {
		logger.info("업데이트 폼");
		String page = "homeMain";
		AddressDTO dto = service.updateForm(postId);
		
		if(dto != null) {
			page = "auction_update";
			model.addAttribute("shipping",dto);
						
		}
		
		
		return page;
	}
	
//	@RequestMapping(value = "/addrUpget", method = RequestMethod.GET)
//	public String addrUpget(Model model, HttpServletRequest req) {	
//		
//		
//		return "addrUpdate";
//	}
	
	@RequestMapping(value="/addrUpdate", method = RequestMethod.POST)
	public String addrUpdate(@RequestParam HashMap<String, String> params, HttpServletRequest req, Model model) {
		
		logger.info("params : "+params);
		String postId = req.getParameter("postId");
		AddressDTO winnerId = service.winnerIdChk(postId);
		
		
		HttpSession session = req.getSession();
		String userId= (String) session.getAttribute("sessionId");
		session.setAttribute("winId", winnerId.getWinnerId());
		
		logger.info("postId : "+postId);
		logger.info("userId : "+userId);
		logger.info("winId : "+winnerId.getWinnerId());
		
		String page ="";
		
		if(winnerId.getWinnerId().equals(userId) ) {
			service.update(params);
			page = "myAuction";
//			page= "redirect:/addrDetail?postId="+params.get("postId");
			
		}else{
			page = "homeMain";
			model.addAttribute("msg","낙찰된 아이디가 아닙니다.");
		}
		
		return page;
	}

	

}
