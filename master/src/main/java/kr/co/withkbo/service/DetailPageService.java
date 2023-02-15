package kr.co.withkbo.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.DetailPageDAO;
import kr.co.withkbo.dao.PollDAO;
import kr.co.withkbo.dto.BoardDTO;
import kr.co.withkbo.dto.PollDTO;

@Service
public class DetailPageService {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired DetailPageDAO dpagedao;
	@Autowired PollDAO polldao;
	
	public BoardDTO dpage(String postId, String string) {
		logger.info("post 상세보기 서비스");
		dpagedao.upHit(postId);
		return dpagedao.dpage(postId);
	}

//	public ArrayList<PollDTO> dpoll(String postId) {
//		logger.info("poll 상세보기 서비스");
//		return dpagedao.dpoll(postId);
//	}

	public HashMap<String, Object> pollDetail(String postId, String loginId) {
		HashMap<String, Object> poll = new HashMap<String, Object>();
		ArrayList<PollDTO> pollList = dpagedao.dpoll(postId);
		poll.put("pollList", pollList);
		
		ArrayList<Integer> pollCount = polldao.pollCount(postId);
		poll.put("pollCount", pollCount);
		
		if(loginId !="noLogin") {
			String selectedPoll = polldao.pollSel(postId,loginId);
			if(selectedPoll != null) {
				poll.put("selected", selectedPoll);
			}	
		}
		return poll;
	}

	public ArrayList<PollDTO> pollList(String postId) {
		return dpagedao.dpoll(postId);
	}
	
	public int matchResultChk(String postId) {
		return dpagedao.matchResultChk(postId);
	}

	public int matchResult(String pollId) {
		int success = dpagedao.matchResult(pollId);
		if(success>0) {
			dpagedao.matchResultPoint(pollId);
		}
		logger.info("succes????"+success);
		
		return success;
	}


}