package kr.co.withkbo.dao;

import kr.co.withkbo.dto.MemberDTO;

public interface MemberDAO {

	MemberDTO login(String id, String pw);

	int join(String id, String pw, String name, String email);

	String overlay(String userId);

	String over(String nickName);

	String overemail(String email);

	int joinstatus(String id);

	int userStaUp(String id);










}
