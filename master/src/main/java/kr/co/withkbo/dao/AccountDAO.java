package kr.co.withkbo.dao;

public interface AccountDAO {


	String ResetPw(String email, String userId);

	int pwUpdate(String newPw, String userId);

	String idfind(String email);

}
