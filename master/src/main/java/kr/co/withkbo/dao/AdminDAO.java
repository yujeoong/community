package kr.co.withkbo.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import kr.co.withkbo.dto.AdminCommentDTO;
import kr.co.withkbo.dto.AdminDTO;
import kr.co.withkbo.dto.AdminPostDTO;
import kr.co.withkbo.dto.Admin_reportDTO;

@Service
public interface AdminDAO {

	ArrayList<AdminDTO> list(int page);

	
	AdminDTO status(String userId);


	void change_status(String status, String userId);


	ArrayList<AdminDTO> search_user(String status, String info, String search, int page);


	ArrayList<AdminDTO> detail_user(String detail);


	int reportCount(String detail);


	Integer pointTotal(String detail);


	ArrayList<AdminPostDTO> board_user(String detail,int total);


	ArrayList<AdminCommentDTO> comment_user(String detail,int page);


	ArrayList<AdminPostDTO> board_search(String user, String search,String detail,int page);


	int board_total(String detail);


	int size();


	ArrayList<AdminDTO> sup_list();
	
	ArrayList<AdminDTO> sup_search_user(String status, String info, String search);


	ArrayList<AdminCommentDTO> comment_search(String user, String search,String detail, int page);


	int comment_total(String detail);


	ArrayList<Admin_reportDTO> user_report_log(String detail, int page);


	ArrayList<Admin_reportDTO> user_report_search(String user, String search, String detail, int page);


	int report_total(String detail);


	int board_total_search(String user, String search, String detail);


	int comment_total_search(String user, String search, String detail);


	int report_total_search(String user, String search, String detail);


	int user_total_search(String status, String info, String search);








}
