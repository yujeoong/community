package kr.co.withkbo.dao;

import java.util.ArrayList;

import kr.co.withkbo.dto.MainPostDTO;

public interface MainPostDAO {

	ArrayList<MainPostDTO> list_fa();

	ArrayList<MainPostDTO> list_in();

	ArrayList<MainPostDTO> list_po();

	MainPostDTO MainPostDet(String postId);

}
