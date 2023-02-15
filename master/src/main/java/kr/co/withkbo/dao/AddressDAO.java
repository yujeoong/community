package kr.co.withkbo.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.withkbo.dto.AddressDTO;

public interface AddressDAO {	

	int addr(String postId, String name, String phone, String postcode, String roadAddr, String detailAddr, String memo, String memo2);

	int update(HashMap<String, String> params);

	AddressDTO detail(String postId);

	ArrayList<AddressDTO> susBid_list();

	AddressDTO winner();

	AddressDTO post();

	AddressDTO shipping(String postId);

	AddressDTO winnerIdChk(String postId);

}
