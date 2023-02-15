package kr.co.withkbo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.withkbo.dto.AuctionDTO;
import kr.co.withkbo.dto.BoardDTO;
import kr.co.withkbo.dto.PollDTO;
import kr.co.withkbo.service.AuctionService;
import kr.co.withkbo.service.BoardService;

@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardService bdservice;
	@Autowired AuctionService aucservice;
	
	
	//01. 게시판 목록 ajax로 불러오기
	@RequestMapping(value="/matchList") //승부예측
	public String matchList(Model model, HttpServletRequest req) {
		return "matchList";
	}
	@RequestMapping(value="/newsList") //뉴스반응
	public String newsList(Model model, HttpServletRequest req) {
		return "newsList";
	}
	@RequestMapping(value="/genPollList") //일반투표
	public String genPollList(Model model, HttpServletRequest req) {
		return "genPollList";
	}
	@RequestMapping(value="/freeList") //자유게시판
	public String freeList(Model model, HttpServletRequest req) {
		return "freeList";
	}
	@RequestMapping(value="/auctionList") //경매
	public String auctionList(Model model, HttpServletRequest req) {
		return "auctionList";
	}
	@RequestMapping(value="/noticeList") //공지사항
	public String noticeList(Model model, HttpServletRequest req) {
		return "noticeList";
	}
	@RequestMapping(value="/suggList") //건의사항
	public String suggList(Model model, HttpServletRequest req) {
		return "suggList";
	}
	
	
	
	//검색
	@ResponseBody
	@RequestMapping(value="/search_post_poll")
	public HashMap<String, Object> search_post_poll (@RequestParam String searchType, @RequestParam String search, @RequestParam int categoryId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<BoardDTO> list = bdservice.search_post_poll(searchType,search,categoryId);
		map.put("list", list);
		return map;
	}
	@ResponseBody
	@RequestMapping(value="/search_post_others")
	public HashMap<String, Object> search_post_others (@RequestParam String searchType, @RequestParam String search, @RequestParam int categoryId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<BoardDTO> list = bdservice.search_post_others(searchType,search,categoryId);
		map.put("list", list);
		return map;
	}

	
	
	//02-1. 게시글 작성 
	@RequestMapping(value = "/writeForm_p")
	public String writeForm_p(Model model, HttpSession session, String categoryId) {
		session.getAttribute("sessionId");
		model.addAttribute("categoryId",categoryId);
		return "writeForm_p";
	}
	@RequestMapping(value = "/writeForm_g")
	public String writeForm_g(Model model, HttpSession session, String categoryId) {
		session.getAttribute("sessionId");
		model.addAttribute("categoryId",categoryId);
		return "writeForm_g";
	}
	@RequestMapping(value = "/writeForm_a")
	public String writeForm_a(Model model, HttpSession session, String categoryId) {
		session.getAttribute("sessionId");
		model.addAttribute("categoryId",categoryId);
		return "writeForm_a";
	}
	
	
	
	// 02-2. 글을 쓰고 저장할 때 호출할 부분
	@RequestMapping(value = "/write_p")
	public String write_p(Model model, HttpSession session, MultipartFile file, HttpServletRequest req, @RequestParam HashMap<String,String> params) {
		String[] select = req.getParameterValues("ext[]");
		String userId = (String) session.getAttribute("sessionId");		
		return bdservice.write_p(userId, select, file, params);
	}
	@RequestMapping(value = "/write_g")
	public String write_g(Model model, HttpSession session, MultipartFile file, HttpServletRequest req, @RequestParam HashMap<String,String> params) {
		String userId = (String) session.getAttribute("sessionId");
		return bdservice.write_g(userId, file, params);
	}
	@RequestMapping(value = "/write_a")
	public String write_a(Model model, HttpSession session, MultipartFile file, HttpServletRequest req, @RequestParam HashMap<String,String> params) {
		String userId = (String) session.getAttribute("sessionId");		
		return bdservice.write_a(userId, file, params);
	}
	
	
	//03. 게시판 페이징
	@RequestMapping(value="/listCall")
	@ResponseBody
	public HashMap<String, Object> listCall(@RequestParam int page, @RequestParam int categoryId) {
		return bdservice.list(page, categoryId);
	}
	
	
	
	// 04-1. 글 수정
	
	@RequestMapping(value = "/updateForm")
	public String updateForm(Model model, HttpSession session, @RequestParam String postId, @RequestParam String categoryId) {
		session.getAttribute("sessionId");
		model.addAttribute("categoryId",categoryId);
		
		BoardDTO boarddto = new BoardDTO();
		boarddto = bdservice.updateForm(postId);
		model.addAttribute("boarddto",boarddto);
		
		logger.info("카테고리 아이디 확인111 "+categoryId);
		logger.info(""+categoryId.getClass());
		String page= "redirect:/";
		
		if(boarddto != null) {
			
			if(categoryId.equals("1")||categoryId.equals("2")||categoryId.equals("3")) {
				ArrayList<PollDTO> polldto = bdservice.update_p(postId);
				model.addAttribute("polldtoSize",polldto.size());
				model.addAttribute("polldto",polldto);	
				
				page = "updateForm_p"; //투표
			}else if(categoryId.equals("5")) {
				AuctionDTO aucdto = aucservice.detail(postId,"update");
				model.addAttribute("aucdto",aucdto);
				page = "updateForm_a" ; 
			}else {
				page = "updateForm_g"; 
			}
		}
		logger.info("카테고리 아이디 확인222 "+categoryId);
		return page;
	}
	
	

	// 04-2. 게시글 수정 후 업데이트
	@RequestMapping(value = "/update_p")
	public String update_p(Model model, HttpSession session, MultipartFile file, HttpServletRequest req, @RequestParam HashMap<String,String> params) {
		String[] select = req.getParameterValues("ext[]");
		logger.info("selections{}: "+select);
		String userId = (String) session.getAttribute("sessionId");		
		return bdservice.update_p(userId, select, file, params);
	}
	@RequestMapping(value = "/update_g")
	public String update_g(Model model, HttpSession session, MultipartFile file, HttpServletRequest req, @RequestParam HashMap<String,String> params) {
		String userId = (String) session.getAttribute("sessionId");
		return bdservice.update_g(userId, file, params);
	}
	@RequestMapping(value = "/update_a")
	public String update_a(Model model, HttpSession session, MultipartFile file, HttpServletRequest req, @RequestParam HashMap<String,String> params) {
		String userId = (String) session.getAttribute("sessionId");		
		return bdservice.update_a(userId, file, params);
	}
	
	
	
	// 05. 게시글 삭제 
	@RequestMapping(value="/delete")
	public String delete(Model model, HttpSession session, @RequestParam String postId) {
		bdservice.delete(postId);
		return "redirect:/";
	}

	
	
	
	
	
	
	
	
	
}
