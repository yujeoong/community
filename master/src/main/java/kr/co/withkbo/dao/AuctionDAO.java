package kr.co.withkbo.dao;

import java.util.ArrayList;

import kr.co.withkbo.dto.AuctionDTO;
import kr.co.withkbo.dto.BidLogDTO;

public interface AuctionDAO {

	AuctionDTO detail(String postId);

	int bidding(String postId, String loginId, int bidPoint);

	ArrayList<BidLogDTO> bidLog(String postId);

	int aucEndChk(String postId);

	int aucConfirmChk(String postId);

	int aucConfirm(String postId);
	
}
