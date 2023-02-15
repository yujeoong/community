package kr.co.withkbo.dao;

import java.util.ArrayList;

import kr.co.withkbo.dto.UserReportDTO;

public interface UserReportDAO {

	

	//void report(UserReportDTO urdto);


	UserReportDTO reportPostForm(String id);
	
	UserReportDTO reportCommentForm(String id);




	void report(UserReportDTO urdto);
	

	
}
