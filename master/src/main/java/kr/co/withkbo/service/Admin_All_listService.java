package kr.co.withkbo.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.Admin_all_listDAO;
import kr.co.withkbo.dto.AdminCommentDTO;
import kr.co.withkbo.dto.AdminPostDTO;

@Service
public class Admin_All_listService {
	@Autowired Admin_all_listDAO ad_adao;
	
	Logger logger=LoggerFactory.getLogger(this.getClass());

	public ArrayList<AdminPostDTO> all_board(int page) {
		ArrayList<AdminPostDTO> list=ad_adao.all_board(page);
		return list;
	}

	public ArrayList<AdminCommentDTO> all_comment(int page) {
		ArrayList<AdminCommentDTO> list=ad_adao.all_comment(page);
		return list;
	}

	public ArrayList<AdminPostDTO> all_board_search(String cate, String search,int page) {
		ArrayList<AdminPostDTO> list=ad_adao.all_board_search(cate,search,page);
		return list;
	}

	public ArrayList<AdminCommentDTO> all_comment_search(String cate, String search, int page) {
		ArrayList<AdminCommentDTO> list=ad_adao.all_comment_search(cate,search,page);
		return list;
	}

	public int all_board_search_total(String cate, String search) {
		return ad_adao.all_board_search_total(cate,search);
	}

	public int all_board_total() {
		return ad_adao.all_board_total();
	}

	public int all_comment_total() {
		return ad_adao.all_comment_total();
	}

	public int all_comment_search_total(String cate, String search) {
		return ad_adao.all_comment_search_total(cate,search);
	}

	public int board_report_chk(int postId, String type) {
		return ad_adao.board_report_chk(postId,type);
	}

	public void insert_board_report(int postId, String adminId) {
		
	}

	public ArrayList<String> board_reportId_search(int postId, String type) {
		return ad_adao.board_reportId_search(postId,type);
	}
}
