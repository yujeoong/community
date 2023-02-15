package kr.co.withkbo.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import kr.co.withkbo.dto.AdminCommentDTO;
import kr.co.withkbo.dto.AdminPostDTO;

@Service
public interface Admin_all_listDAO {

	ArrayList<AdminPostDTO> all_board(int page);

	ArrayList<AdminCommentDTO> all_comment(int page);

	ArrayList<AdminPostDTO> all_board_search(String cate, String search,int page);

	ArrayList<AdminCommentDTO> all_comment_search(String cate, String search, int page);

	int all_board_search_total(String cate, String search);

	int all_board_total();

	int all_comment_total();

	int all_comment_search_total(String cate, String search);

	int board_report_chk(int postId, String type);

	ArrayList<String> board_reportId_search(int postId, String type);

}
