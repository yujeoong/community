package kr.co.withkbo.dao;

import java.util.ArrayList;

import kr.co.withkbo.dto.CommentDTO;

public interface CommentDAO {

	int comtSubmit(String comment, String loginId, String postId);

	int reTotalCount(String postId);

	ArrayList<CommentDTO> commentListCall(String postId, int offset);

	int comtUpdate(String commentId, String comment);

	int comDelete(String commentId);

	

	
}
