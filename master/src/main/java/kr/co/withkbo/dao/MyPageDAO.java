package kr.co.withkbo.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.withkbo.dto.MyAuctionDTO;
import kr.co.withkbo.dto.MyPageDTO;
import kr.co.withkbo.dto.MyPointDTO;
import kr.co.withkbo.dto.MyPostDTO;

public interface MyPageDAO {

	MyPageDTO list(String lgId);

	String myPageUF(String pw, String lgId);

	MyPageDTO upForm(String lgId);

	int pwUpdate(String lgId, String newpw1);

	String nicChk(String nic);

	int nameUpt(String nic, String lgId);

	String prenick(String lgId);

	//int change(String lgId);

	//int board_total();

	//ArrayList<MyPostDTO> board_user(String detail, int total);
	
	//내 게시글 리스트
	ArrayList<MyPostDTO> myPostList(int offset, String lgId);
	
	// 내 게시글 페이지 갯수
	int myPost_totalCount(String lgId);
	
	// 내 댓글 페이지 갯수
	int myComment_totalCount(String lgId);

	int delete(String RowNum);

	//내 댓글 리스트
	ArrayList<MyPostDTO> myCommentList(int offset, String lgId);

	int quitFin(String lgId);
	
	//내 포인트 내역 리스트 
	ArrayList<MyPointDTO> myPoint(int offset, String lgId);
	
	//내 포인트 페이지
	int myPoint_totalCount(String lgId);

	MyPageDTO myPrePoint(String lgId);
	
	//내 경매 낙찰 내역 페이지
	int myAuctionList_totalCount(String lgId);
	
	//내 경매 낙찰 내역 리스트
	ArrayList<MyAuctionDTO>myAuctionList(int offset, String lgId);






}
