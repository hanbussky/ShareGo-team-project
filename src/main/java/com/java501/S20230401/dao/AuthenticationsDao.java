package com.java501.S20230401.dao;

import com.java501.S20230401.model.Authentications;
import com.java501.S20230401.model.Member;

public interface AuthenticationsDao {

	// 유현규
	public void setAuthentication(Member member, String code);
	public Authentications getAuthentication(String code);
	public void deleteAuthentication(Integer auth_id);
	
	
	
}
