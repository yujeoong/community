package kr.co.withkbo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.withkbo.dto.AdminCommentDTO;
import kr.co.withkbo.dto.AdminDTO;
import kr.co.withkbo.dto.AdminPostDTO;
import kr.co.withkbo.dto.Admin_reportDTO;
import kr.co.withkbo.service.AdminService;

@Controller
public class AdminController {
	@Autowired AdminService ad_service;
	
	Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/AdminmyPage")
	public String AdminMyPage(Model model,HttpSession session) {
		String page="redirect:/";
		try {
			if((Integer)session.getAttribute("sessionLevel") == 2) {
				page="adminPage";
			}else{
				model.addAttribute("msg","관리자만 접근 가능합니다.");
			}
		} catch (NullPointerException e) {
			model.addAttribute("msg","잘못된 요청 입니다.");
		}
		return page;
	}
	
	@ResponseBody 
	@RequestMapping(value="/adminlistCall")
	public HashMap<String, Object> adminlistCall(@RequestParam int page) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		int total=ad_service.size();
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<AdminDTO> list=ad_service.list(page);
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}
	
	@ResponseBody 
	@RequestMapping(value="/search_user_admin")
	public HashMap<String, Object> search_user(@RequestParam(value="chkArr[]") ArrayList<String> req
			,@RequestParam int page){
		String status=req.get(0);
		String info=req.get(1);
		String search=req.get(2);
		int total=ad_service.user_total_search(status,info,search);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		logger.info("토탈 값 : "+total);
		ArrayList<AdminDTO> list=ad_service.search_user(status,info,search,page);
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("total", page_idx);
		map.put("test", total);
		map.put("list", list);
		return map;
	}
	
	@RequestMapping(value="/detail_user")
	public String detail_user(Model model,@RequestParam String detail) {
		ArrayList<AdminDTO> list =ad_service.detail_user(detail);
		int reportCount=ad_service.reportCount(detail);
		Integer pointTotal=ad_service.pointTotal(detail);
		model.addAttribute("list",list);
		model.addAttribute("report",reportCount);
		model.addAttribute("point",pointTotal);
		return "detail_user";
	}
	
	@RequestMapping(value="/userStatus_log")
	public String userStatus_log(Model model,@RequestParam String userId) {
		ArrayList<AdminDTO> list=ad_service.detail_user(userId);
		model.addAttribute("list",list);
		return "userStatus_log";
	}
	
	@RequestMapping(value="/board_user")
	public String board_user(Model model,HttpSession session) {
		String page="redirect:/";
		try {
			if((Integer)session.getAttribute("sessionLevel") == 2) {
				page="board_user";
			}else{
				model.addAttribute("msg","관리자만 접근 가능합니다.");
			}
		} catch (NullPointerException e) {
			model.addAttribute("msg","잘못된 요청 입니다.");
		}
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value="/board_user_ajax")
	public HashMap<String, Object> board_user_ajax(@RequestParam String detail,@RequestParam int page) {
		int total=ad_service.board_total(detail);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		HashMap<String, Object> map=new HashMap<String, Object>();
		ArrayList<AdminPostDTO> list=ad_service.board_user(detail,page);
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/board_user_search")
	public HashMap<String, Object> board_user_search(@RequestParam String user,@RequestParam String search
			,@RequestParam String detail,@RequestParam int page){
		HashMap<String, Object> map=new HashMap<String, Object>();
		int total=ad_service.board_total_search(user,search,detail);
		page=(page-1)*10;
		ArrayList<AdminPostDTO> list=ad_service.board_search(user,search,detail,page);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}
	
	
	@RequestMapping(value="/comment_user")
	public String comment_user(Model model,HttpSession session) {
		String page="redirect:/";
		try {
			if((Integer)session.getAttribute("sessionLevel") == 2) {
				page="comment_user";
			}else{
				model.addAttribute("msg","관리자만 접근 가능합니다.");
			}
		} catch (NullPointerException e) {
			model.addAttribute("msg","잘못된 요청 입니다.");
		}
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value="/comment_user_ajax")
	public HashMap<String, Object> comment_user_ajax(@RequestParam String detail,@RequestParam int page) {
		int total=ad_service.comment_total(detail);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		HashMap<String, Object> map=new HashMap<String, Object>();
		ArrayList<AdminCommentDTO> list =ad_service.comment_user(detail,page);
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/comment_user_search")
	public HashMap<String, Object> comment_user_search(@RequestParam String user,@RequestParam String search
			,@RequestParam String detail,@RequestParam int page){
		HashMap<String, Object> map=new HashMap<String, Object>();
		int total=ad_service.comment_total_search(user,search,detail);
		page=(page-1)*10;
		ArrayList<AdminCommentDTO> list=ad_service.comment_search(user,search,detail,page);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}	
	
	@RequestMapping(value="/user_report_log")
	public String user_report_log(Model model,HttpSession session) {
		String page="redirect:/";
		try {
			if((Integer)session.getAttribute("sessionLevel") == 2) {
				page="user_report_log";
			}else{
				model.addAttribute("msg","관리자만 접근 가능합니다.");
			}
		} catch (NullPointerException e) {
			model.addAttribute("msg","잘못된 요청 입니다.");
		}
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value="/user_report_ajax")
	public HashMap<String,Object> user_report_ajax(@RequestParam int page,@RequestParam String detail){
		HashMap<String, Object> map=new HashMap<String, Object>();
		int total=ad_service.report_total(detail);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<Admin_reportDTO> list=ad_service.user_report_log(detail,page);
		map.put("list", list);
		map.put("total", page_idx);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="/user_report_search")
	public HashMap<String, Object> user_report_search(@RequestParam String user,@RequestParam String search
			,@RequestParam String detail,@RequestParam int page){
		HashMap<String, Object> map=new HashMap<String, Object>();
		int total=ad_service.report_total_search(user,search,detail);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<Admin_reportDTO> list=ad_service.user_report_search(user,search,detail,page);
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}
	
	
}
