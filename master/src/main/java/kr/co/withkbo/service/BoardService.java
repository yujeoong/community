package kr.co.withkbo.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.withkbo.dao.BoardDAO;
import kr.co.withkbo.dao.DetailPageDAO;
import kr.co.withkbo.dto.AuctionDTO;
import kr.co.withkbo.dto.BoardDTO;
import kr.co.withkbo.dto.PollDTO;

@Service
public class BoardService {
	
	@Autowired BoardDAO bd_dao;
	@Autowired DetailPageDAO dpagedao;

	Logger logger = LoggerFactory.getLogger(getClass());
		
	

	public HashMap<String,Object> list(int page, int categoryId) {
				
		int offset =10*(page-1);
		int totalCount = bd_dao.totalCount(categoryId);
		logger.info("카테고리"+categoryId);
		int totalPages = totalCount%10>0 ? (totalCount/10)+1 : (totalCount/10); 
	
		HashMap<String,Object> result = new HashMap<String, Object>();
		if (categoryId == 1 || categoryId == 2 || categoryId == 3) {
			result.put("total",totalPages);
			result.put("list", bd_dao.list(offset,categoryId));		
		}else if (categoryId == 4 || categoryId == 6 || categoryId == 7) {
			result.put("total",totalPages);
			result.put("list", bd_dao.genlist(offset,categoryId));
	  	}else {
		result.put("total",totalPages);
		result.put("list", bd_dao.auclist(offset,categoryId));
		}
		return result;
	}
	
	
	//검색
	public ArrayList<BoardDTO> search_post_poll(String searchType, String search, int categoryId) {
		ArrayList<BoardDTO> list = bd_dao.search_post_poll(searchType, search, categoryId);
	return list;
	}

	public ArrayList<BoardDTO> search_post_others(String searchType, String search, int categoryId) {
		ArrayList<BoardDTO> list = bd_dao.search_post_others(searchType, search, categoryId);
		return list;
	}
	
	
	
	
	//게시판 글 쓰기 
	public String write_p(String userId, String[] select, MultipartFile file, HashMap<String, String> params) {
		logger.info("글쓰기저장서비스 userId : "+userId);
		BoardDTO boarddto = new BoardDTO();
		boarddto.setSubject(params.get("subject"));
		boarddto.setContent(params.get("content"));
		boarddto.setUserId(userId);
		boarddto.setCategoryId(params.get("categoryId"));
		
		int success = bd_dao.write(boarddto);	
		int postId = boarddto.getPostId();
		logger.info("postid 222"+postId);

		if(success > 0 ) {
			logger.info("file이름 : {}",file.getOriginalFilename());
			if(success > 0 && !file.getOriginalFilename().equals("")) {
				fileUpload(file,postId); 
			}

			for (int i = 0; i < select.length; i++) {
				logger.info("poll테이블입력 갯수 "+select.length);
				logger.info("poll테이블입력 서비스 "+select[i]);
				PollDTO polldto = new PollDTO();
				polldto.setSelection(select[i]);
				polldto.setPostId(postId);
				polldto.setEndDate(params.get("endDate"));
				bd_dao.write_p(polldto);
			}
		}
		//return "redirect:/{path}?postId="+postId;
		return "redirect:/postDetail?postId="+postId;
	}

	
    public String write_a(String userId, MultipartFile file, HashMap<String, String> params) {
        logger.info("글쓰기저장서비스 userId "+userId);
        BoardDTO boarddto = new BoardDTO();
        boarddto.setSubject(params.get("subject"));
        boarddto.setContent(params.get("content"));
        boarddto.setUserId(userId);
        boarddto.setCategoryId(params.get("categoryId"));
        
        int success =bd_dao.write(boarddto);
        int postId = boarddto.getPostId();
        bd_dao.firstBid(postId);
        
        
        logger.info("file이름 : {}",file.getOriginalFilename());
		if(success > 0 && !file.getOriginalFilename().equals("")) {
			fileUpload(file,postId); }

        if(success > 0 ) {
            logger.info("글쓰기저장서비스 postId "+postId);
            AuctionDTO auctiondto = new AuctionDTO();
            auctiondto.setPostId(postId);
            auctiondto.setEndDate(params.get("endDate"));
            auctiondto.setStartingPoint(Integer.parseInt(params.get("startingPoint")));
            bd_dao.write_auc(auctiondto);
        }
		return "redirect:/auction_detail?postId="+postId;
    }
    
    
    public String write_g(String userId, MultipartFile file, HashMap<String, String> params) {
        BoardDTO boarddto = new BoardDTO();
        boarddto.setUserId(userId);
        boarddto.setSubject(params.get("subject"));
        boarddto.setContent(params.get("content"));
        boarddto.setCategoryId(params.get("categoryId"));
        int success = bd_dao.write(boarddto);
        int postId = boarddto.getPostId();
		logger.info("postid 222 "+postId);
        
        logger.info("file이름 : {}",file.getOriginalFilename());
		if(success > 0 && !file.getOriginalFilename().equals("")) {
			fileUpload(file,postId); }
        
		return "redirect:/postDetail?postId="+postId;
    }
    
    
    
	//fileUpload
	private void fileUpload(MultipartFile file, int postId) {
	
		String oriFileName = file.getOriginalFilename();
		String ext = oriFileName.substring(oriFileName.lastIndexOf(".")); //확장자 자르기
		String newFileName = System.currentTimeMillis()+ext; //신규 파일명 생성
		logger.info("1 : "+oriFileName);
		logger.info("2 : "+ext);
		logger.info("3 : "+newFileName);
		logger.info("4 : "+postId);
		
		try {
			byte[] bytes = file.getBytes();
			logger.info(""+bytes);
		
			Path path = Paths.get("C:/upload/"+newFileName);
			Files.write(path, bytes);
			logger.info(newFileName+" UPLOAD OK!");		
			bd_dao.fileWrite(postId, oriFileName, newFileName);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
    
	
	/*    게시판 신고    */
	public Object reportForm(String sessionId, int postId, HashMap<String, String> params) {
		BoardDTO boarddto = new BoardDTO();
		boarddto.setUserId(sessionId); //userId
		boarddto.setSubject(params.get("reportType"));
		boarddto.setPostId(50);
		boarddto.setSubject(params.get("nickname"));
		boarddto.setSubject(params.get("content"));
		boarddto.setSubject(params.get("subject"));
		return bd_dao.reportForm(boarddto, postId);
	}
	
	
	
	

	//  글 수정 (투표 관련)
	public String update_p(String userId, String[] select, MultipartFile file, HashMap<String, String> params) {
		logger.info("글쓰기저장서비스 userId : "+userId);
		int success = bd_dao.update(params);	
		String postId = params.get("postId");
		logger.info("서비스 postId 확인 "+postId);

		for (int i = 0; i < select.length; i++) {
			logger.info("poll테이블입력 갯수 "+select.length);
			logger.info("poll테이블입력 서비스 "+select[i]);
			PollDTO polldto = new PollDTO();
			polldto.setSelection(select[i]);
			polldto.setPostId(Integer.parseInt(postId));
			polldto.setEndDate(params.get("endDate"));
			polldto.setOffset(i);
			bd_dao.update_p(polldto);
		}
		
		logger.info("file이름 : {}",file.getOriginalFilename());
		if(success > 0 && !file.getOriginalFilename().equals("")) {
			fileUpload(file,Integer.parseInt(postId)); }
		
		logger.info("postId글 수정 확인중"+postId);
		return "redirect:/postDetail?postId="+postId;
	}



	//  글 수정 (일반 게시판)
	public String update_g(String userId, MultipartFile file, HashMap<String, String> params) {
	        int success = bd_dao.update(params);
	        String postId = params.get("postId");
			logger.info("postid 222 "+postId);
	        
			logger.info("file이름 : {}",file.getOriginalFilename());
			if(success > 0 && !file.getOriginalFilename().equals("")) {
				fileUpload(file,Integer.parseInt(postId)); }
	        
			return "redirect:/postDetail?postId="+postId;
	    }

	
	//  글 수정 (경매)
	public String update_a(String userId, MultipartFile file, HashMap<String, String> params) {
		
		logger.info("글수정 서비스 userId   "+userId);
       
		int success = bd_dao.update(params);
	    String postId = params.get("postId");
	    logger.info("postid 222 "+postId);
	

        if(success > 0 ) {
            logger.info("글쓰기저장서비스 postId "+postId);
           
            bd_dao.update_auc(params);
        }
        
        if(success > 0 && !file.getOriginalFilename().equals("")) {
        	fileUpload(file,Integer.parseInt(postId)); }
        
        
		return "redirect:/auction_detail?postId="+postId;
    }


	public BoardDTO updateForm(String postId) {
		return bd_dao.updateForm(postId);
	}


	public ArrayList<PollDTO> update_p(String postId) {
		return dpagedao.dpoll(postId);
	}




    


//게시글 삭제
	public void delete(String postId) {
		ArrayList<BoardDTO> fileList=bd_dao.fileList(postId);
		int row=bd_dao.delete(postId);
		if(row>0 && fileList.size()>0) {
			File file = null;
			for(BoardDTO dto : fileList) {
				file = new File("C:/upload/"+dto.getNewFileName());
				if(file.exists()) {
					logger.info(dto.getNewFileName()+" delete : "+file.delete());
				}
			}
		}
	}


		
	
	
	}

	
	










	
	

	
	
	
	