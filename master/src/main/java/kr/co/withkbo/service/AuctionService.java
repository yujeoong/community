package kr.co.withkbo.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.AuctionDAO;
import kr.co.withkbo.dao.DetailPageDAO;
import kr.co.withkbo.dao.PointDAO;
import kr.co.withkbo.dto.AuctionDTO;
import kr.co.withkbo.dto.BidLogDTO;

@Service
public class AuctionService {

	@Autowired AuctionDAO aucdao;
	@Autowired DetailPageDAO dpagedao;
	@Autowired PointDAO podao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public AuctionDTO detail(String postId, String method) {
		logger.info("경매 상세보기 서비스"+postId+":"+method);
		if(method.equals("detail")) {
			dpagedao.upHit(postId);	//조회수 올리기
			logger.info("조회수 올리기");
		}
		return aucdao.detail(postId);
	}

	public String bidding(String postId, String loginId, int bidPoint, int userPoint) {
		logger.info("경매 서비스");
		String msg = "";
		if(bidPoint<aucdao.detail(postId).getStartingPoint()) {
			msg="입찰 시작가보다 높은 포인트를 입력하세요";
		}else if(bidPoint<=aucdao.bidLog(postId).get(0).getBidPoint()) {
			msg="현재 입찰 최고 포인트보다 높은 포인트를 입력하세요";		
		}else if(bidPoint>userPoint) {
			msg="보유 포인트가 부족합니다. 보유표인트: "+userPoint;
		}else {
			if(aucdao.bidding(postId, loginId, bidPoint)>0) {
				msg="입찰 성공";
			}
		}
		return msg;
	}

	public ArrayList<BidLogDTO> bidLog(String postId) {
		return aucdao.bidLog(postId);
	}

	public String aucConfirm(String postId) {
		String msg ="";
		String result = "";
		int resultId = 0;
//		int intPostId = Integer.parseInt(postId);
		if(aucdao.aucEndChk(postId)<1) {	//0 안끝남 1 끝남
			msg="경매가 아직 종료되지 않았습니다.";
		}else if(aucdao.aucConfirmChk(postId)<1) {	//0이면 값이 있음. 1이면 없음
			msg="이미 입력되었습니다.";
		}else if(aucdao.aucConfirm(postId)>0) {
			AuctionDTO aucdetail = aucdao.detail(postId);
			podao.usePoint(aucdetail.getWinnerId(), aucdetail.getWinningPoint(), "경매 낙찰 차감",result, resultId);
			msg="경매 확정이 완료되었습니다.";
		}
		return msg;
	}

}
