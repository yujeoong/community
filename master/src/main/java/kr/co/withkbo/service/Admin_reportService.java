package kr.co.withkbo.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.Admin_reportDAO;
import kr.co.withkbo.dto.AdminDTO;
import kr.co.withkbo.dto.Admin_reportDTO;
import kr.co.withkbo.dto.Admin_report_ProcessDTO;

@Service
public class Admin_reportService {

	@Autowired
	Admin_reportDAO ad_rdao;

	Logger logger = LoggerFactory.getLogger(this.getClass());

	public ArrayList<Admin_reportDTO> report_board_list(int page) {
		ArrayList<Admin_reportDTO> list = ad_rdao.report_board_list(page);
		return list;
	}
	
	public ArrayList<Admin_reportDTO> report_comment_list(int page) {
		ArrayList<Admin_reportDTO> list = ad_rdao.report_comment_list(page);
		return list;
	}

	public ArrayList<Admin_reportDTO> search_board_report(String user, String search,int page) {
		ArrayList<Admin_reportDTO> list = ad_rdao.search_board_report(user, search,page);
		return list;
	}
	
	public ArrayList<Admin_reportDTO> search_comment_report(String user, String search,int page) {
		ArrayList<Admin_reportDTO> list = ad_rdao.search_comment_report(user, search,page);
		return list;
	}

	public boolean report_chk(String reportId) {
		Admin_reportDTO list = ad_rdao.report_chk(reportId);
		boolean chk = false;
		if(list.getStatus().equals("N")) {
			chk=true;
		}


		return chk;
	}

	public int report_process(String reportId, String adminId, String report_result,
			String textbox) {
		int row=ad_rdao.report_process(reportId,adminId,report_result,textbox);
		return row;
	}

	public void report_status(String reportId) {
		ad_rdao.report_status(reportId);
	}

	public int report_list_total() {
		return ad_rdao.report_list_total();
	}

	public int report_comment_total() {
		return ad_rdao.report_comment_total();
	}

	public int search_board_report_total(String user, String search) {
		return ad_rdao.search_board_report_total(user,search);
	}
	
	public int search_comment_report_total(String user, String search) {
		return ad_rdao.search_comment_report_total(user,search);
	}

	public void report_user_plus(String reportId, String type) {
		ad_rdao.report_user_plus(reportId,type);
	}

	public ArrayList<String> reportChk(String type, String reportId) {
		return ad_rdao.reportChk(type,reportId);
	}

	public void admin_auto_report(Admin_reportDTO dto) {
		ad_rdao.admin_auto_report(dto);
	}

	public void pause_user_search(String reportId, String type) {
		AdminDTO pause_user=ad_rdao.pause_user_search(reportId,type);
		logger.info("값은 : "+pause_user.getUserId());
		logger.info("횟수 : "+pause_user.getSanctionNo());
		if(pause_user.getSanctionNo() % 25 == 0) {
			String userId=pause_user.getUserId();
			logger.info("횟수 25 50 75 100 완료");
			ad_rdao.pause_user_change(userId);
		}
	}

//	public int admin_auto_report(String adminId, String report_result, String type) {
//		return ad_rdao.admin_auto_report(adminId,report_result,type);
//	}



}
