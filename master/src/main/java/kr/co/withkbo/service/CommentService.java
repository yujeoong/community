package kr.co.withkbo.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.withkbo.dao.CommentDAO;
import kr.co.withkbo.dto.CommentDTO;

@Service
public class CommentService {

	   Logger logger = LoggerFactory.getLogger(this.getClass());

	   @Autowired CommentDAO CommentDAO;

	public int comtSubmit(String comment, String loginId, String postId) {
		logger.info("댓글 작성 service");
		return CommentDAO.comtSubmit(comment, loginId, postId);
	}

	public int reTotalCount(String postId) {
		logger.info("댓글 불러오기 페이징 service");
		return CommentDAO.reTotalCount(postId);
	}

	public ArrayList<CommentDTO> commentListCall(String postId, int offset) {
		logger.info("댓글 불러오기 service");
		return CommentDAO.commentListCall(postId, offset);
	}

	public int comtUpdate(String commentId, String comment) {
		logger.info("댓글 수정 service");
		return CommentDAO.comtUpdate(commentId,comment);
	}

	public int comDelete(String commentId) {
		logger.info("댓글 삭제 service");
		return CommentDAO.comDelete(commentId);
	}
	   
}
