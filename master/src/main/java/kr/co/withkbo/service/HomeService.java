package kr.co.withkbo.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.HomeDAO;
import kr.co.withkbo.dao.PollDAO;

@Service
public class HomeService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired HomeDAO hmdao;
	@Autowired PollDAO polldao;

	public HashMap<String, Object> pollList(int pollNum, String loginId) {
		HashMap<String, Object> poll = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> pollList = hmdao.pollList(pollNum);
		poll.put("pollList", pollList);
		String postId = pollList.get(0).get("postId").toString();
		
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


}
