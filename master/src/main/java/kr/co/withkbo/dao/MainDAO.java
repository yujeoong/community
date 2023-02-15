package kr.co.withkbo.dao;

public interface MainDAO {

	int join(String id, String pw, String name, String email);

	String login(String id, String pw);

}
