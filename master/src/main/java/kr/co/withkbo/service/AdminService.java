package kr.co.withkbo.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.AdminDAO;
import kr.co.withkbo.dto.AdminCommentDTO;
import kr.co.withkbo.dto.AdminDTO;
import kr.co.withkbo.dto.AdminPostDTO;
import kr.co.withkbo.dto.Admin_reportDTO;

@Service
public class AdminService {
	Logger logger=LoggerFactory.getLogger(this.getClass());
	@Autowired AdminDAO ad_dao;
	
	
	public ArrayList<AdminDTO> sup_list() {
		ArrayList<AdminDTO> list=ad_dao.sup_list();
		return list;
	}
	
	public ArrayList<AdminDTO> sup_search_user(String status, String info, String search) {
		ArrayList<AdminDTO> list=ad_dao.sup_search_user(status,info,search);
		return list;
	}

	
	public ArrayList<AdminDTO> list(int page) {
		ArrayList<AdminDTO> list=ad_dao.list(page);
		return list;
	}
	
	public int size() {
		int total=ad_dao.size();
		return total;
	}

	public void change_status(String level, String userId) {
		ad_dao.change_status(level,userId);
	}

	public ArrayList<AdminDTO> search_user(String status, String info, String search, int page) {
		ArrayList<AdminDTO> list=ad_dao.search_user(status,info,search,page);
		return list;
		
	}
	
	public int user_total_search(String status, String info, String search) {
		return ad_dao.user_total_search(status,info,search);
	}

	public ArrayList<AdminDTO> detail_user(String detail) {
		ArrayList<AdminDTO> list=ad_dao.detail_user(detail);
		
		return list;
		
	}

	public int reportCount(String detail) {
		int reportCount=ad_dao.reportCount(detail);
		return reportCount;
	}

	public Integer pointTotal(String detail) {
		Integer pointTotal=ad_dao.pointTotal(detail);
		if(pointTotal == null) {
			pointTotal=0;
		}
		return pointTotal;
	}
	
	

	public ArrayList<AdminPostDTO> board_user(String detail,int page) {
		
		ArrayList<AdminPostDTO> list=ad_dao.board_user(detail,page);
		return list;
	}

	public ArrayList<AdminCommentDTO> comment_user(String detail,int page) {
		ArrayList<AdminCommentDTO> list=ad_dao.comment_user(detail,page);
		return list;
	}

	public ArrayList<AdminPostDTO> board_search(String user, String search,String detail,int page) {
		ArrayList<AdminPostDTO> list=new ArrayList<AdminPostDTO>();
			list=ad_dao.board_search(user,search,detail,page);
		return list;
	}

	public int board_total(String detail) {
		int total=ad_dao.board_total(detail);
		return total;
	}


	public ArrayList<AdminCommentDTO> comment_search(String user, String search,String detail, int page) {
		ArrayList<AdminCommentDTO> list=ad_dao.comment_search(user,search,detail,page);
		return list;
	}


	public int comment_total(String detail) {
		int total=ad_dao.comment_total(detail);
		return total;
	}


	public ArrayList<Admin_reportDTO> user_report_log(String detail, int page) {
		ArrayList<Admin_reportDTO> list=ad_dao.user_report_log(detail,page);
		return list;
	}


	public ArrayList<Admin_reportDTO> user_report_search(String user, String search, String detail, int page) {
		ArrayList<Admin_reportDTO> list=ad_dao.user_report_search(user,search,detail,page);
		return list;
	}


	public int report_total(String detail) {
		return ad_dao.report_total(detail);
	}


	public int board_total_search(String user, String search, String detail) {
		return ad_dao.board_total_search(user,search,detail);
	}


	public int comment_total_search(String user, String search, String detail) {
		return ad_dao.comment_total_search(user,search,detail);
	}


	public int report_total_search(String user, String search, String detail) {
		return ad_dao.report_total_search(user,search,detail);
	}





	



	
}
