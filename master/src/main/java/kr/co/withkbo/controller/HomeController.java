
package kr.co.withkbo.controller;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import
 org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import
 org.springframework.web.bind.annotation.RequestMapping;
import
 org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.withkbo.dto.MainPostDTO;
import kr.co.withkbo.service.HomeService;
import kr.co.withkbo.service.MainPostService;

@Controller public class HomeController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired HomeService hmservice;
	@Autowired MainPostService mpservice;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		logger.info("리스트 호출");
		
		ArrayList<MainPostDTO> list_fa = mpservice.list_fa();
		model.addAttribute("list_fa", list_fa);
		
		logger.info("list_fa");
		
		ArrayList<MainPostDTO> list_in = mpservice.list_in();
		model.addAttribute("list_in", list_in);
		
		ArrayList<MainPostDTO> list_po = mpservice.list_po();
		model.addAttribute("list_po",list_po);
				
		return "homeMain";
	}
	
//	@RequestMapping(value="/MainPostDet")
//	public String MainPostDet(Model model, @RequestParam String postId, HttpServletRequest req) {
//		String page = "";
//		MainPostDTO mainpostdto = mpservice.MainPostDet(postId);
//		HttpSession session = req.getSession();
//		session.setAttribute("mainpostdto", mainpostdto.getPostId());
//		
//		if(mainpostdto != null) {
//			page = "postDetail";
//			model.addAttribute("post",mainpostdto.getPostId());
//		}
//		
//		return page;
//	}
	
	
	
	
	
	@RequestMapping(value = "/pollCall", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> pollCall(@RequestParam int pollNum,@RequestParam String loginId) {
		return hmservice.pollList(pollNum, loginId);
	}	
	
}