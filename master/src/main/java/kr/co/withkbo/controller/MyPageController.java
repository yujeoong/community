package kr.co.withkbo.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.withkbo.dto.MyPageDTO;
import kr.co.withkbo.dto.MyPostDTO;
import kr.co.withkbo.service.MyPageService;


@Controller
public class MyPageController {
   
   Logger logger = LoggerFactory.getLogger(this.getClass());
   
   @Autowired MyPageService service;
   
   //마이페이지 내 정보 가져오기
   @RequestMapping(value = "/myPage")
   public String myPage(Model model, HttpSession session){
	   logger.info("회원정보 불러오기");
	   logger.info(session.getId());
	   String lgId = (String) session.getAttribute("sessionId");
	   String page = "homeMain";
		if(lgId != null) {
			page = "myPage";
			MyPageDTO dto = service.list(lgId);
			model.addAttribute("list",dto);
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		
	   
	  return page;
   }
   
   //비밀번호 확인
	@RequestMapping(value = "/pwCheck")
	public String pwCheck(Model model, HttpSession session) {
		
		String page = "homeMain";
		if(session.getAttribute("sessionId") != null) {
			page = "pwCheck";
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";

		}
		
		return page;
	}
	
	//마이페이지 수정폼
	@RequestMapping(value="/myPageUF")
	public String myPageUF(Model model, HttpSession session,
			HttpServletRequest req) {
		String lgId = (String) session.getAttribute("sessionId");
		String pw = req.getParameter("userpass");
		
		String page = "pwCheck";
		
		if(lgId != null) {
			String success = service.myPageUF(lgId,pw);
			if(success != null && !success.equals("")) {
				page = "myPageUF";
				MyPageDTO dto = service.upForm(lgId);
				Date nickdate = dto.getNickUpdateDate();
				Date today = new Date();
				long difference = today.getTime() - nickdate.getTime();
				long diffDate = difference / (1000*24*60*60);
				if(diffDate<30) {
					model.addAttribute("nickPossible", 0);
				}else {
					model.addAttribute("nickPossible", 1);
				}
				
//			      SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
//			      Date time = new Date();
//			      String current = format.format(time);
//			      String nickdate = dto.getNickUpdateDate().toString();
//			      Date today = null;
//			      Date end = null;
//			      try {
//			         today = format.parse(current);
//			         end = format.parse(nickdate);
//			      } catch (ParseException e) {
//			         e.printStackTrace();
//			      }
//				
//			      int nickChk = today.compareTo(end);
//			      model.
				
				model.addAttribute("list",dto);
			}else {
				model.addAttribute("msg", "비밀번호를 확인하세요.");
			}
			
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		
		return page;
	}
	   // 비밀번호 수정
	   @RequestMapping(value="/pwUpdate")
	   public String pwUpdate(Model model, HttpSession session,
	         HttpServletRequest req){
	      
	      String lgId = (String) session.getAttribute("sessionId");
	      String newpw1 = req.getParameter("newpw1");
	      String newpw2 = req.getParameter("newpw2");
	      //String pattern = "^[a-z0-9]{6,10}$";

	      boolean result = newpw1.matches("^[a-zA-Z0-9]{6,10}$");
	      boolean result2 = newpw2.matches("^[a-zA-Z0-9]{6,10}$");
	      logger.info("result : " + result);
	      logger.info("result2 : " + result2);
	      logger.info("newpw1 / newpw2 : " + newpw1 +"/"+ newpw2);
	      //String page = "redirect:/myPage";
	      //String page = "redirect:/pwUpdate";
	      //String page = "redirect:/myPage";
	      String page = "myPageUF";
	      MyPageDTO dto = service.upForm(lgId);
			Date nickdate = dto.getNickUpdateDate();
			Date today = new Date();
			long difference = today.getTime() - nickdate.getTime();
			long diffDate = difference / (1000*24*60*60);
			if(diffDate<30) {
				model.addAttribute("nickPossible", 0);
			}else {
				model.addAttribute("nickPossible", 1);
			}
			model.addAttribute("list",dto);
	      
	      
	      
	      
	      if(lgId != null) {
	            if(!newpw1.equals("") && !newpw2.equals("")) {
	               if(result != false && result2 !=false && newpw1.equals(newpw2) ) { // 유효성 검사 성공, 비밀번호 같게 입력했을 때
	                  int row = service.pwUpdate(lgId, newpw1);
	                  if(row>0) {
	                     page ="myPageUF";
	                     model.addAttribute("msg", "비밀번호가 변경되었습니다.");
	                     dto = service.upForm(lgId);
	                     model.addAttribute("list",dto);
	                  }
	               }else if(result !=false | result !=false && !newpw1.equals(newpw2)){ //유효성 검사 성공, 비밀번호를 다르게 입력했을 때
	                  page ="myPageUF";
	                  model.addAttribute("msg", "비밀번호를 다시 입력해 주세요.");
	                  dto = service.upForm(lgId);
	                  model.addAttribute("list",dto);
	               }else { //유효성 검사 실패
	                  model.addAttribute("msg", "영문 또는 숫자 6자리 이상 입력해 주세요.");
	                  page = "myPageUF";
	                  dto = service.upForm(lgId);
	                  model.addAttribute("list",dto);
	               }
	            }else {
	               model.addAttribute("msg", "새로운 비밀번호를 입력하세요.");
	               dto = service.upForm(lgId);
	               model.addAttribute("list",dto);
	            }
	      }else {
	         model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
	         page = "login";
	      }
	      return page;
	   }

	//닉네임 중복확인
	@RequestMapping(value="/nicChk")
	@ResponseBody
	public HashMap<String, Object> nicChk(@RequestParam String nic) throws Exception{

		boolean nicChk = true;
		logger.info("닉네임 중복 체크 :" + nic);
		//boolean result = nic.matches("^[a-zA-Z0-9]{6,10}$");
		//logger.info("닉네임 유효성 검사 결과 :" + result);
		HashMap<String, Object> map = new HashMap<String, Object>();
		nicChk = service.nicChk(nic); // 중복된 닉네임 있을 시 true 반환
		
		map.put("nicChk", nicChk);
		//map.put("result", result);
		//유효성 검사 성공 + 닉네임 중복X -> 사용 가능한 닉네임 입니다.
		//유효성 검사 성공 + 닉네임 중복 O -> 중복된 닉네임 입니다.
		//유효성 검사 실패 + 닉네임 중복 O -> 중복된 닉네임 입니다.
		//유효성 검사 실패 + 닉네임 중복 X -> 닉네임 형식을 확인하세요.

		return map;
	}
	
	//닉네임 수정
	@RequestMapping(value="/nameUpt")
	@ResponseBody
	public HashMap<String, Object> nameUpt(HttpSession session, @RequestParam String nic) throws Exception{
		int nameUpt;
		logger.info("닉네임 수정 :" + nic);

		String lgId = (String) session.getAttribute("sessionId");
		HashMap<String, Object> map = new HashMap<String, Object>();
		nameUpt = service.nameUpt(nic,lgId);
		map.put("nameUpt", nameUpt);

		return map;
	}
	
	//현재 닉네임 가져오기
	@RequestMapping(value="/prenick")
	@ResponseBody
	public HashMap<String, Object> prenick(HttpSession session) throws Exception{
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		String lgId = (String) session.getAttribute("sessionId");
		String prenick = service.prenick(lgId);
		map.put("prenick", prenick);

		return map;
	}
	
//	//닉네임변경 가능 횟수
//	@RequestMapping(value="/change")
//	@ResponseBody
//	public HashMap<String, Object> change(HttpSession session) throws Exception{
//		
//		String lgId = (String) session.getAttribute("sessionId");
//		HashMap<String, Object> map = new HashMap<String, Object>();
//
//		int change = service.change(lgId);
//		map.put("change", change);
//
//		return map;
//	}


//	@RequestMapping(value = "/myPost")
//	@ResponseBody
//	public HashMap<String, Object> myPost(HttpSession session){
//		logger.info("컨트롤러_내가 쓴 글 가져오기");
//		HashMap<String, Object> map = new HashMap<String, Object>();
//	
//		//String lgId = (String) session.getAttribute("sessionId");
//		//logger.info("lgId:"  + lgId);
//		if(session.getAttribute("sessionId") != null) {
//			ArrayList<MyPostDTO> list = service.myPost();
//			map.put("myPost", list);
//			map.put("login", true);
//		}else {
//			map.put("login", false);
//		}		   
//		return map;
//	   }
	
	//내가 쓴 글 페이지 불러오기
	@RequestMapping(value="/myPost")
	public String myPost(HttpSession session, Model model) {
		String page = "homeMain";
		
		if(session.getAttribute("sessionId") != null) {
			page = "myPost";
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		return page;
	}
	
	/* 원본
	@RequestMapping(value="/listCall")
	@ResponseBody
	public HashMap<String, Object> listCall(@RequestParam int page) {
		logger.info("list 요청!!: "+page);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		//DTO 대신 MAP을 쓰면 어떤데이터를 가져오는지 파악이 어렵다.
		//소스 파악 등에 힘드니 가급 쓰지 말것
		//언제쓰나? 여러개의 테이블이 조인하는 등 구조가 복잡한 데이터를 가져올 때

		return service.myList(page);
	}
	*/
	
	//내가 쓴 게시글 불러오기
	@RequestMapping(value="/myPost_listCall")
	@ResponseBody
	public HashMap<String, Object> myPost_listCall(HttpSession session, @RequestParam int page) {
		logger.info("list 요청!!: "+page);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String lgId = (String) session.getAttribute("sessionId");
		
		//DTO 대신 MAP을 쓰면 어떤데이터를 가져오는지 파악이 어렵다.
		//소스 파악 등에 힘드니 가급 쓰지 말것
		//언제쓰나? 여러개의 테이블이 조인하는 등 구조가 복잡한 데이터를 가져올 때

		return service.myPostList(page,lgId);
	}
	// 내가 쓴 글, 댓글 삭제
	@RequestMapping(value="/del")
	@ResponseBody
	public HashMap<String, Object> del(@RequestParam(value="delList[]") ArrayList<String> delList){
		logger.info("list : {}",delList);		
		int cnt = service.del(delList);
		
		String msg = "삭제가 완료되었습니다.";
		
		HashMap<String, Object> map = new HashMap<String, Object>();		
		map.put("msg", msg);
		
		return map;
	}	
	
	//내가 쓴 댓글 페이지 불러오기
	@RequestMapping(value = "/myComment")
	public String myComment(HttpSession session, Model model){
		String page = "homeMain";
		
		if(session.getAttribute("sessionId") != null) {
			page = "myComment";
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		return page;
	   }
	
	//내가 쓴 댓글 불러오기
	@RequestMapping(value="/myComment_listCall")
	@ResponseBody
	public HashMap<String, Object> myComment_listCall(HttpSession session, @RequestParam int page) {
		logger.info("list 요청!!: "+page);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String lgId = (String) session.getAttribute("sessionId");
		
		//DTO 대신 MAP을 쓰면 어떤데이터를 가져오는지 파악이 어렵다.
		//소스 파악 등에 힘드니 가급 쓰지 말것
		//언제쓰나? 여러개의 테이블이 조인하는 등 구조가 복잡한 데이터를 가져올 때

		return service.myCommentList(page,lgId);
	}
	
	//탈퇴 페이지 이동
	@RequestMapping(value = "/quitChk")
	public String quitChk(Model model, HttpSession session) {
		
		String page = "homeMain";
		if(session.getAttribute("sessionId") != null) {
			page = "pwCheck_quit";
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		return page;
	}
	 
	//탈퇴하기 전 비밀번호 확인
	@RequestMapping(value="/quit")
	public String quit(Model model, HttpSession session,
			HttpServletRequest req) {
		String lgId = (String) session.getAttribute("sessionId");
		String pw = req.getParameter("userpass");
		
		String page = "pwCheck_quit";
		
		if(lgId != null) {
			String success = service.myPageUF(lgId,pw);
			if(success != null && !success.equals("")) {
				page = "myPage_quit";
				MyPageDTO dto = service.upForm(lgId);
				
				model.addAttribute("list",dto);
			}else {
				model.addAttribute("msg", "비밀번호를 확인하세요.");
			}
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		return page;
	}	
	
	/*
	@ResponseBody
	@RequestMapping(value="/quitFin")
	public String quitFin(HttpSession session) {		
		String lgId = (String) session.getAttribute("sessionId");
		String page = "pwCheck_quit";
		if(lgId != null) {
			page = "redirect:/quit";
			service.quitFin(lgId);
		}else {
			model.addAttribute("msg","로그인이 필요한 서비스 입니다.");
		}		
		return page;
	}
	*/
	
	//탈퇴하기
	@RequestMapping(value="/quitFin")
	@ResponseBody
	public HashMap<String, Object> quitFin(HttpSession session){

		HashMap<String, Object> map = new HashMap<String, Object>();		
		String lgId = (String) session.getAttribute("sessionId");
		String page = "pwCheck_quit";
		String msg = "로그인이 필요한 서비스 입니다.";
		if(lgId !=null) {
			service.quitFin(lgId);
			msg="회원탈퇴가 완료되었습니다.";
			map.put("msg1", msg);
			session.invalidate();
		}else {
			msg = "로그인이 필요한 서비스 입니다.";
			map.put("msg2", msg);
		}		
		
		return map;
	}	
	
	// 내 포인트 기록 페이지
	@RequestMapping(value = "/myPoint")
	public String myPoint(Model model, HttpSession session){
		logger.info("포인트불러올거야");
		String lgId = (String) session.getAttribute("sessionId");
		String page = "homeMain";
		if(lgId != null) {
			page = "myPoint";
			MyPageDTO dto = service.myPrePoint(lgId);
			model.addAttribute("list",dto);
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		return page;
	  }
	
	//내 적립 포인트 페이지 이동
	@RequestMapping(value = "/myPoint_listCall")
	@ResponseBody
	public HashMap<String, Object> myPoint(HttpSession session, @RequestParam int page){
		logger.info("포인트 적립 차감 내역 요청 : "+page);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String lgId = (String) session.getAttribute("sessionId");
	
		return service.myPoint(page,lgId);
	   }

	// 내가 낙찰한 경매 페이지 이동
	@RequestMapping(value = "/myAuction")
	public String myAuction(HttpSession session, Model model){
		String page = "homeMain";
		if(session.getAttribute("sessionId") != null) {
			page = "myAuction";
		}else {
			model.addAttribute("msg", "로그인이 필요한 서비스 입니다.");
			page = "login";
		}
		return page;
		
	}
	
	@RequestMapping(value = "/myAuction_listCall")
	@ResponseBody
	public HashMap<String, Object> myAuctionList(HttpSession session, @RequestParam int page){
		logger.info("내가 낙찰한 경매 내역 요청 : "+page);
		String lgId = (String) session.getAttribute("sessionId");
	
		return service.myAuctionList(page,lgId);
	   }
	
}