package kr.co.withkbo.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dto.AdminDTO;
import kr.co.withkbo.dto.Admin_reportDTO;

@Service
public interface Admin_reportDAO {

	ArrayList<Admin_reportDTO> report_board_list(int page);
	
	ArrayList<Admin_reportDTO> report_comment_list(int page);

	ArrayList<Admin_reportDTO> search_board_report(String user, String search,int page);
	
	ArrayList<Admin_reportDTO> search_comment_report(String user, String search,int page);

	Admin_reportDTO report_chk(String reportId);

	int report_process(String reportId, String adminId, String report_result,
			String textbox);

	void report_status(String reportId);

	int report_list_total();

	int report_comment_total();

	int search_board_report_total(String user, String search);
	
	int search_comment_report_total(String user, String search);

	void report_user_plus(String reportId, String type);

	ArrayList<String> reportChk(String type, String reportId);

	int admin_auto_report(String adminId, String report_result, String type);

	void admin_auto_report(Admin_reportDTO dto);

	
	
	AdminDTO pause_user_search(String reportId, String type);


	void pause_user_change(String userId);


//	AdminDTO pause_user_detail(String reportId, String type);

}
