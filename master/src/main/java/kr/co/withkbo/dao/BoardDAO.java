package kr.co.withkbo.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.withkbo.dto.AuctionDTO;
import kr.co.withkbo.dto.BoardDTO;
import kr.co.withkbo.dto.PollDTO;

public interface BoardDAO {
	
	int totalCount(int categoryId);
	
	ArrayList<HashMap<String,Object>> list(int offset, int categoryId);
	ArrayList<HashMap<String,Object>> genlist(int offset, int categoryId);
	ArrayList<HashMap<String,Object>> auclist(int offset, int categoryId);

	//int write(HashMap<String, String> params);
	
	void write_g(BoardDTO write_g_dto);
	
	void write_a(BoardDTO write_a_dto);

	void write_auc(AuctionDTO auctiondto);
	
	void write_p(PollDTO polldto);

	void firstBid(int postId);
	
	// 글 수정 
	int update(HashMap<String, String> params);

	void update_p(PollDTO polldto);

	void update_auc(HashMap<String, String> params);

	BoardDTO updateForm(String postId);
	
	
	
	
	
	
	
	ArrayList<BoardDTO> fileList(String postId);
	
	
	BoardDTO match_detail(String postId);


	void views(String postId);


	

	int delete(String postId);





	

	ArrayList<BoardDTO> detail(String postId);




	Object reportForm(BoardDTO boarddto, int postId);
	
	//검색
	ArrayList<BoardDTO> search_post_poll(String searchType, String search, int categoryId);
	ArrayList<BoardDTO> search_post_others(String searchType, String search, int categoryId);

	void fileWrite(int postId, String oriFileName, String newFileName);

	int write(BoardDTO boarddto);































}
