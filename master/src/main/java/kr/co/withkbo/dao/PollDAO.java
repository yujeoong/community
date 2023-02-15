package kr.co.withkbo.dao;

import java.util.ArrayList;

public interface PollDAO {

	int doPoll(String pollId, String loginId);

	String pollSel(String postId, String loginId);

	int pollChk(String pollId, String loginId);

	ArrayList<Integer> pollCount(String postId);

	int pollCountSum(String pollId);

	void setHotPost(String pollId);

}
