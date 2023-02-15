package kr.co.withkbo.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.withkbo.dto.AdminDTO;
import kr.co.withkbo.service.AdminService;

@Controller
public class SuperAdminController {
	@Autowired AdminService ad_service;
	Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/superadmin")
	public String superadmin(Model model,HttpSession session) {
		String page="homeMain";
		ArrayList<AdminDTO> list=ad_service.sup_list();
		try {
			if(session.getAttribute("sessionId").equals("peach") && (Integer)session.getAttribute("sessionLevel") == 1) {
				page="superadmin";
				model.addAttribute("list",list);
			}else{
				model.addAttribute("msg","최고 관리자만 접근 가능합니다.");
			}
		} catch (Exception e) {
			model.addAttribute("msg","잘못된 요청 입니다.");
		}
		return page;
	}
	
	@RequestMapping(value="/change_status")
	public String change_status(Model model,HttpServletRequest req)  {
		try {
			String[] user_level=req.getParameterValues("grade");
			String[] user_Id=req.getParameterValues("userId");
			for(int i=0;i<user_Id.length;i++) {
				if(user_level[i].equals("user_member")) {
					user_level[i]="3";
					ad_service.change_status(user_level[i],user_Id[i]);
				}else if(user_level[i].equals("user_admin")){
					user_level[i]="2";
					logger.info(user_Id[i]+"의 status 변경: "+user_level[i]);
					ad_service.change_status(user_level[i],user_Id[i]);
				}
			}
		} catch (Exception e) {
			model.addAttribute("msg","잘못된 요청 입니다.");
			return "homeMain";
		}
		return "redirect:/superadmin";
	}
	
	@RequestMapping(value="/search_user")
	public String search_user(Model model,HttpServletRequest req) {
		try {
			String status=req.getParameter("status_user");
			String info=req.getParameter("info_user");
			String search=req.getParameter("search");
			
			ArrayList<AdminDTO> list=ad_service.sup_search_user(status,info,search);
			model.addAttribute("list",list);
		} catch (Exception e) {
			model.addAttribute("msg","잘못된 요청 입니다.");
			return "homeMain";
		}
		return "superadmin";
		
	}
	
	

}
