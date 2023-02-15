package kr.co.withkbo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.PollDAO;

@Service
public class PollService {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired PollDAO polldao;

	public String doPoll(String pollId, String loginId) {
		logger.info("투표 서비스");
		String msg = "";
		if(polldao.pollChk(pollId,loginId)>0) {			
			msg="이미 투표했습니다.";
		}else if(polldao.doPoll(pollId,loginId)>0) {
			if(polldao.pollCountSum(pollId)>10) {	//투표자 10명 되면 hotpost
				polldao.setHotPost(pollId);
			}
			msg="투표 성공";
		}
		return msg;
	}
	
}
