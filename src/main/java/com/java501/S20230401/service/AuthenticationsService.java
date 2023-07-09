package com.java501.S20230401.service;

import com.java501.S20230401.model.Authentications;
import com.java501.S20230401.model.Member;

public interface AuthenticationsService {

	public void setAuthentication(Member member, String code);

	public Authentications getAuthentication(String code);

	public void deleteAuthentication(Integer auth_id);
	
}
