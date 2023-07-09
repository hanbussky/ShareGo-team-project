package com.java501.S20230401.service;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.AuthenticationsDao;
import com.java501.S20230401.model.Authentications;
import com.java501.S20230401.model.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthenticationsServiceImpl implements AuthenticationsService {
	private final AuthenticationsDao ad;
	
	// 유현규
	@Override
	public void setAuthentication(Member member, String code) {
		ad.setAuthentication(member, code);
	}
	
	@Override
	public Authentications getAuthentication(String code) {
		return ad.getAuthentication(code);
	}
	
	@Override
	public void deleteAuthentication(Integer auth_id) {
		ad.deleteAuthentication(auth_id);
	}
}
