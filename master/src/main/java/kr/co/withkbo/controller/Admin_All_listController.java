package kr.co.withkbo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
import kr.co.withkbo.dto.AdminPostDTO;
import kr.co.withkbo.service.Admin_All_listService;

@Controller
public class Admin_All_listController {
	@Autowired Admin_All_listService ad_aservice;
	
	Logger logger=LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/Admin_All_Board")
	public String Admin_All_Board(Model model,HttpSession session) {
		String page = "homeMain";
		try {
			if ((Integer) session.getAttribute("sessionLevel") == 2) {
				page = "Admin_All_Board";
			} else {
				model.addAttribute("msg", "관리자만 접근 가능합니다.");
			}
		} catch (Exception e) {
			model.addAttribute("msg", "잘못된 요청 입니다.");
		}
		return page;
	}
	
	@RequestMapping(value="/Admin_All_comment")
	public String Admin_All_comment(Model model,HttpSession session) {
		String page = "homeMain";
		try {
			if ((Integer) session.getAttribute("sessionLevel") == 2) {
				page = "Admin_All_comment";
			} else {
				model.addAttribute("msg", "관리자만 접근 가능합니다.");
			}
		} catch (Exception e) {
			model.addAttribute("msg", "잘못된 요청 입니다.");
		}
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value="/Admin_all_board_ajax")
	public HashMap<String, Object> Admin_all_board_ajax(HttpSession session,@RequestParam int page){
		HashMap<String, Object> map=new HashMap<String, Object>();
			if ((Integer) session.getAttribute("sessionLevel") == 2) {
				int total=ad_aservice.all_board_total();
				page=(page-1)*10;
				int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
				ArrayList<AdminPostDTO> list=ad_aservice.all_board(page);
				map.put("total", page_idx);
				map.put("list", list);
			}
		return map;	
	}
	
	@ResponseBody
	@RequestMapping(value="/Admin_all_comment_ajax")
	public HashMap<String, Object> Admin_all_comment_ajax(HttpSession session,@RequestParam int page){
		HashMap<String, Object> map=new HashMap<String, Object>();
		if ((Integer) session.getAttribute("sessionLevel") == 2) {
		int total=ad_aservice.all_comment_total();
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<AdminCommentDTO> list=ad_aservice.all_comment(page);
		map.put("total", page_idx);
		map.put("list", list);
		}
		return map;	
	}
	
	@ResponseBody
	@RequestMapping(value="/all_board_search")
	public HashMap<String, Object> all_board_search(HttpSession session,@RequestParam String cate,@RequestParam String search
			,@RequestParam int page){
		HashMap<String, Object> map=new HashMap<String, Object>();
		if ((Integer) session.getAttribute("sessionLevel") == 2) {
		int total=ad_aservice.all_board_search_total(cate,search);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<AdminPostDTO> list=ad_aservice.all_board_search(cate,search,page);
		map.put("total", page_idx);
		map.put("list", list);
		}
		return map;	
	}
	
	@ResponseBody
	@RequestMapping(value="/all_comment_search")
	public HashMap<String, Object> all_comment_search(HttpSession session,@RequestParam String cate,@RequestParam String search
			,@RequestParam int page){
		HashMap<String, Object> map=new HashMap<String, Object>();
		if ((Integer) session.getAttribute("sessionLevel") == 2) {
		int total=ad_aservice.all_comment_search_total(cate,search);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<AdminCommentDTO> list=ad_aservice.all_comment_search(cate,search,page);
		map.put("total", page_idx);
		map.put("list", list);
		}
		return map;	
	}
	
	@RequestMapping(value="/Admin_board_report")
	public String Admin_board_report(Model model,HttpSession session,@RequestParam int postId
			,@RequestParam String type) {
		String page = "redirect:/";
		try {
			if ((Integer) session.getAttribute("sessionLevel") == 2) {
				String adminId=(String) session.getAttribute("sessionId");
				int chk=ad_aservice.board_report_chk(postId,type);
				if(chk == 0) {
					model.addAttribute("alert","신고 처리가 되지 않은 게시글 입니다. 처리 하시겠습니까?");
					model.addAttribute("reportId",postId);
					model.addAttribute("adminId",adminId);
					model.addAttribute("type",type);
					model.addAttribute("flag", "1");
				}else {
					ArrayList<String> reportId= new ArrayList<String>();
					reportId=ad_aservice.board_reportId_search(postId,type);
					model.addAttribute("reportId",reportId);
					model.addAttribute("alert2","이미 신고가 들어온 글입니다. 신고 관리 페이지에서 확인하세요.");
					
				}
				page="Admin_report_process";
			} else {
				model.addAttribute("msg", "관리자만 접근 가능합니다.");
			}
		} catch (Exception e) {
			model.addAttribute("msg", "잘못된 요청 입니다.");
		}
		return page;
	}
	
	
	
	
}
