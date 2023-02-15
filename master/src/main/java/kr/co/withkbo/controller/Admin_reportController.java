package kr.co.withkbo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.mapping.ParameterMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.withkbo.dto.AdminDTO;
import kr.co.withkbo.dto.Admin_reportDTO;
import kr.co.withkbo.dto.Admin_report_ProcessDTO;
import kr.co.withkbo.service.Admin_reportService;

@Controller
public class Admin_reportController {

	@Autowired
	Admin_reportService ad_rservice;

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/report_board")
	public String report_board(Model model, HttpSession session) {
		String page = "redirect:/";
		try {
			if ((Integer) session.getAttribute("sessionLevel") == 2) {
				page = "report_board";
			} else {
				model.addAttribute("msg", "관리자만 접근 가능합니다.");
			}
		} catch (NullPointerException e) {
			model.addAttribute("msg", "잘못된 요청 입니다.");
		}

		return page;
	}

	@RequestMapping(value = "/report_comment")
	public String report_comment(Model model, HttpSession session) {
		String page = "redirect:/";
		try {
			if ((Integer) session.getAttribute("sessionLevel") == 2) {
				page = "report_comment";
			} else {
				model.addAttribute("msg", "관리자만 접근 가능합니다.");
			}
		} catch (NullPointerException e) {
			model.addAttribute("msg", "잘못된 요청 입니다.");
		}

		return page;
	}

	@ResponseBody
	@RequestMapping(value = "/report_board_ajax")
	public HashMap<String, Object> report_board_ajax(@RequestParam int page) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int total=ad_rservice.report_list_total();
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<Admin_reportDTO> list = ad_rservice.report_board_list(page);
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/report_comment_ajax")
	public HashMap<String, Object> report_comment_ajax(@RequestParam int page) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int total=ad_rservice.report_comment_total();
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<Admin_reportDTO> list = ad_rservice.report_comment_list(page);
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/search_board_report")
	public HashMap<String, Object> search_board_report(@RequestParam String user, @RequestParam String search
			,@RequestParam int page) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int total=ad_rservice.search_board_report_total(user,search);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<Admin_reportDTO> list = ad_rservice.search_board_report(user,search,page);
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/search_comment_report")
	public HashMap<String, Object> search_comment_report(@RequestParam String user, @RequestParam String search
			,@RequestParam int page) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int total=ad_rservice.search_comment_report_total(user,search);
		int page_idx=total/10 > 0 ? total%10 == 0? (total/10) : (total/10)+1 : 1;
		page=(page-1)*10;
		ArrayList<Admin_reportDTO> list = ad_rservice.search_comment_report(user,search,page);
		map.put("total", page_idx);
		map.put("list", list);
		return map;
	}

	@RequestMapping(value = "/Admin_report_process")
	public String Admin_report_process(Model model, HttpSession session, @RequestParam String reportId
			,@RequestParam String type) {
		String page = "redirect:/";
		try {
			if ((Integer) session.getAttribute("sessionLevel") == 2) {
				page = "Admin_report_process";
				boolean chk = ad_rservice.report_chk(reportId);
				String adminId=(String) session.getAttribute("sessionId");
				ArrayList<String> reportChk= new ArrayList<String>();
				reportChk = ad_rservice.reportChk(type,reportId);
				if (chk && !reportChk.contains("B")) {
					model.addAttribute("type",type);
					model.addAttribute("adminId",adminId);
					model.addAttribute("reportId", reportId);
				} else {
					model.addAttribute("msg", "이미 신고 처리가 되어 있습니다.");
				}
			} else {
				model.addAttribute("msg", "관리자만 접근 가능합니다.");
			}
		} catch (NullPointerException e) {
			model.addAttribute("msg", "잘못된 요청 입니다.");
		}
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value="/report_process")
	public HashMap<String, Object> report_process(@RequestParam HashMap<String, String> params){
		HashMap<String, Object> map=new HashMap<String, Object>();
		String reportId=params.get("reportId");
		String adminId=params.get("adminId");
		String report_result=params.get("report_result");
		String textbox=params.get("textbox");
		String type=params.get("type");
		String flag=params.get("flag");

		try {
			if(flag.equals("1")) {
				Admin_reportDTO dto=new Admin_reportDTO();
				dto.setUserId(adminId);
				dto.setReportType(Integer.parseInt(type));
				dto.setId(Integer.parseInt(reportId));
				ad_rservice.admin_auto_report(dto);
				
				int result = dto.getReportId();
				logger.info("result 값 : "+result);
				String Sresult=Integer.toString(result);
				String SadminId=dto.getUserId();
				String Stype=Integer.toString(dto.getReportType());
				int success = ad_rservice.report_process(Sresult,SadminId,report_result,textbox);
				if(report_result.equals("B")) {
					reportId=Sresult;
					type=Stype;
					ad_rservice.report_user_plus(reportId,type);
					ad_rservice.pause_user_search(reportId,type);
				}
				if(success > 0) {
					ad_rservice.report_status(reportId);
				}
				map.put("success", success);
				return map;
			}
			int row=ad_rservice.report_process(reportId,adminId,report_result,textbox);
			if(report_result.equals("B")) {
				ad_rservice.report_user_plus(reportId,type);
				ad_rservice.pause_user_search(reportId,type);
			}
			if(row > 0) {
				ad_rservice.report_status(reportId);
			}
			map.put("row", row);
		} catch (Exception e) {
			map.put("Exception", "없는 글이거나 댓글입니다.");
			 e.printStackTrace();
		}
		return map;
		
	}
	
	
	
	

}
