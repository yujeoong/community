package kr.co.withkbo.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.MyPageDAO;
import kr.co.withkbo.dto.AdminPostDTO;
import kr.co.withkbo.dto.MyPageDTO;
import kr.co.withkbo.dto.MyPostDTO;

@Service
public class MyPageService {

	   Logger logger = LoggerFactory.getLogger(this.getClass());

	   @Autowired MyPageDAO MyPageDAO;

	
	public MyPageDTO list(String lgId) {
		logger.info("dao 호출");
		MyPageDTO dto = MyPageDAO.list(lgId);

		return dto;
	}
	

	public String myPageUF(String lgId, String pw) {
		logger.info("pw확인 service");
		return MyPageDAO.myPageUF(lgId,pw);
	}


	public MyPageDTO upForm(String lgId) {
		logger.info("변경폼 이동 service");
		MyPageDTO dto = MyPageDAO.upForm(lgId);
		return dto;
	}


	public int pwUpdate(String lgId, String newpw1) {
		logger.info("비밀번호 업데이트 service");
		return MyPageDAO.pwUpdate(lgId, newpw1);
		
	}


	public boolean nicChk(String nic) {
		String nicCheck = MyPageDAO.nicChk(nic);
		logger.info("nicCheck : " + nicCheck );
		return nicCheck == null ? false : true;
	}

	
	public int nameUpt(String nic, String lgId) {
		logger.info("닉네임 수정 service");
		return MyPageDAO.nameUpt(nic,lgId);
	}


	public String prenick(String lgId) {
		logger.info("현재 닉네임 가져오기 service");
		return MyPageDAO.prenick(lgId);
	}


//	public int change(String lgId) {
//		logger.info("닉네임 변경 가능 횟수 servcie");
//		return MyPageDAO.change(lgId);
//	}
	
	/*
	public HashMap<String, Object> myList(int page) {
		
		int offset = (page-1)*10;//page에 따른 offset 구하기

		//총 페이지 수 = 게시물의 총 갯수 / 페이지 당 보여줄 수량
		int totalCount = MyPageDAO.totalCount();
		logger.info("total count : " +totalCount);
		
		//이 경우 나머지가 생기면 +1
		int totalPages = totalCount%10 >0 ? (totalCount/10)+1 : (totalCount/10); //총 페이지 수		
		logger.info("총 페이지 수 : " + totalPages);
		logger.info("총 페이지 수2 : " + Math.ceil(totalCount/10));
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("total", totalPages);
		result.put("list", MyPageDAO.myList(offset));
		
		return result;
	}
	*/
	
	//실험
	public HashMap<String, Object> myPostList(int page, String lgId) {
		
		int offset = (page-1)*10;//page에 따른 offset 구하기

		//총 페이지 수 = 게시물의 총 갯수 / 페이지 당 보여줄 수량
		int totalCount = MyPageDAO.myPost_totalCount(lgId);
		logger.info("내 게시글 total count : " +totalCount);
		
		//이 경우 나머지가 생기면 +1
		int totalPages = totalCount%10 >0 ? (totalCount/10)+1 : (totalCount/10); //총 페이지 수		
		logger.info("내 게시글 페이지 수 : " + totalPages);
		logger.info("내 게시글 페이지 수2 : " + Math.ceil(totalCount/10));
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("total", totalPages);
		result.put("list", MyPageDAO.myPostList(offset, lgId));
		
		return result;
	}
	
	

	public int del(ArrayList<String> delList) {
		int total = 0;		
		for (String RowNum : delList) {
			total += MyPageDAO.delete(RowNum);
		}
		logger.info("총 지운 갯수 : "+total);
		return total;
	}


	public HashMap<String, Object> myCommentList(int page, String lgId) {
		int offset = (page-1)*10;//page에 따른 offset 구하기

		//총 페이지 수 = 게시물의 총 갯수 / 페이지 당 보여줄 수량
		int totalCount = MyPageDAO.myComment_totalCount(lgId);
		logger.info("내 댓글 total count : " +totalCount);
		
		//이 경우 나머지가 생기면 +1
		int totalPages = totalCount%10 >0 ? (totalCount/10)+1 : (totalCount/10); //총 페이지 수		
		logger.info("총 댓글 페이지 수 : " + totalPages);
		logger.info("총 댓글 페이지 수2 : " + Math.ceil(totalCount/10));
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("total", totalPages);
		result.put("list", MyPageDAO.myCommentList(offset, lgId));
		
		return result;
	}


	public void quitFin(String lgId) {
		logger.info("탈퇴 요청 : "+ lgId);
		int row = MyPageDAO.quitFin(lgId);
		logger.info("탈퇴 완료 된 아이디 갯수 : " + row);
	}


	public HashMap<String, Object> myPoint(int page, String lgId) {
		
		int offset = (page-1)*10;//page에 따른 offset 구하기

		//총 페이지 수 = 게시물의 총 갯수 / 페이지 당 보여줄 수량
		int totalCount = MyPageDAO.myPoint_totalCount(lgId);
		logger.info("내 포인트 total count : " + totalCount);
		
		//이 경우 나머지가 생기면 +1
		int totalPages = totalCount%10 >0 ? (totalCount/10)+1 : (totalCount/10); //총 페이지 수		
		logger.info("내 포인트 페이지 수 : " + totalPages);
		logger.info("내 포인트 페이지 수2 : " + Math.ceil(totalCount/10));
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("total", totalPages);
		result.put("list", MyPageDAO.myPoint(offset, lgId));
		
		return result;
	}


	public MyPageDTO myPrePoint(String lgId) {
		logger.info("포인트 가져와 dao야");
		MyPageDTO dto = MyPageDAO.myPrePoint(lgId);
		return dto;
	}

	
	
	public HashMap<String, Object> myAuctionList(int page, String lgId) {
		
		
		int offset = (page-1)*10;//page에 따른 offset 구하기

		//총 페이지 수 = 게시물의 총 갯수 / 페이지 당 보여줄 수량
		int totalCount = MyPageDAO.myAuctionList_totalCount(lgId);
		logger.info("내 경매 낙찰 내역 total count : " + page);
		logger.info("내 경매 낙찰 내역 total count : " + totalCount);
		
		//이 경우 나머지가 생기면 +1
		int totalPages = totalCount%10 >0 ? (totalCount/10)+1 : (totalCount/10); //총 페이지 수		
		logger.info("내 경매 낙찰 내역 페이지 수 : " + totalPages);
		logger.info("내 경매 낙찰 내역 페이지 수2 : " + Math.ceil(totalCount/10));
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("total", totalPages);
		result.put("list", MyPageDAO.myAuctionList(offset, lgId));
		
		return result;
	}
	


	/*
	public int board_total() {
		int total= MyPageDAO.board_total();
		return total;
	}


	public ArrayList<MyPostDTO> board_user(String detail, int page) {
		
		ArrayList<MyPostDTO> list = MyPageDAO.board_user(detail,page);
		return list;
	}
	 */
	






	   
	
}
