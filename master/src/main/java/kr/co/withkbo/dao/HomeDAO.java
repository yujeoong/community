package kr.co.withkbo.dao;

import java.util.ArrayList;
import java.util.HashMap;

public interface HomeDAO {

	ArrayList<HashMap<String, Object>> pollList(int pollNum);

}
