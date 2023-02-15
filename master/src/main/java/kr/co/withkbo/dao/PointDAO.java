package kr.co.withkbo.dao;

public interface PointDAO {

	void addPoint(String userId, int point, String comment);

	void usePoint(String userId, int point, String comment, String resultCode, int pointId);

	int userPoint(String userId);

}
