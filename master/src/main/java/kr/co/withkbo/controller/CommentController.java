package kr.co.withkbo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.withkbo.dto.CommentDTO;
import kr.co.withkbo.service.CommentService;

@Controller
public class CommentController {
	
	   Logger logger = LoggerFactory.getLogger(this.getClass());

	   @Autowired CommentService service;
	   
		/* 댓글 작성*/
		@RequestMapping(value="/comtSubmit")
		@ResponseBody
		public HashMap<String, Object> comtSubmit(HttpSession session, @RequestParam HashMap<String, String> params) {
			String comment = params.get("comment");
			String postId = params.get("postId");
			String loginId = (String) session.getAttribute("sessionId");
			
			int row = service.comtSubmit(comment, loginId, postId);
		   
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("success", row);
		   
		   return map;
		}
		
		/* 댓글 불러오기 */
		@RequestMapping(value="/commentListCall")
		@ResponseBody
		public HashMap<String, Object>commentListCall(@RequestParam HashMap<String, String> params){
			String postId = params.get("postId");
			String page = params.get("page");
//			String commentId = params.get("commentId");
//			logger.info("commentId : " + commentId);
			
			int offset = (Integer.parseInt(page)-1)*10;
			int reTotalCount = service.reTotalCount(postId);
			logger.info("reTotalCount :" + reTotalCount);
			logger.info("reTotalCount2 :" + reTotalCount/10);
			int totalPages = reTotalCount%10 > 0 ? (reTotalCount/10)+1 : reTotalCount/10; //총 페이지 수
			logger.info("totalPages :" + totalPages);
			ArrayList<CommentDTO> list=service.commentListCall(postId, offset);
			logger.info("list {}", list);
			HashMap<String, Object> map= new HashMap<String, Object>();
			map.put("list",list);
			map.put("total", totalPages);
			
			return map;
		}
		
		/* 댓글 수정 */
		@RequestMapping(value="/comtUpdate")
		@ResponseBody
		public HashMap<String, Object> comtUpdate(HttpSession session, @RequestParam HashMap<String, String> params) {
			String commentId = params.get("commentId");
			String comment = params.get("comment");
			logger.info("comment : " + comment);
			logger.info("댓글 수정 controller");
			int row = service.comtUpdate(commentId,comment);
		   
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("success", row);
			
		   return map;
		}
		
		/* 댓글 삭제 */
		@RequestMapping(value="/comDelete")
		@ResponseBody
		public HashMap<String, Object> comDelete(HttpSession session, @RequestParam HashMap<String, String> params) {
			String commentId = params.get("commentId");
			int row = service.comDelete(commentId);
		   
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("success", row);
		   
		   return map;
		}
		 
}
