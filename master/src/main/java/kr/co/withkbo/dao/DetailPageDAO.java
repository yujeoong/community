package kr.co.withkbo.dao;

import java.util.ArrayList;

import kr.co.withkbo.dto.BoardDTO;
import kr.co.withkbo.dto.PollDTO;

public interface DetailPageDAO {

	BoardDTO dpage(String postId);

	ArrayList<PollDTO> dpoll(String postId);

	int matchResultChk(String postId);

	int matchResult(String pollId);

	void matchResultPoint(String pollId);

	void upHit(String postId);

}
