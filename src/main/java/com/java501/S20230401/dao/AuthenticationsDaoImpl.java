package com.java501.S20230401.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Authentications;
import com.java501.S20230401.model.Member;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AuthenticationsDaoImpl implements AuthenticationsDao {
	private final SqlSession session;
	
	// 유현규
	@Override
	public void setAuthentication(Member member, String code) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", member.getMem_id());
		param.put("code", code);
		session.insert("hgInsertAuthentication", param);
	}
	@Override
	public Authentications getAuthentication(String code) {
		return session.selectOne("hgGetAuthenticationByCode", code);
	}
	@Override
	public void deleteAuthentication(Integer auth_id) {
		session.delete("hgDeleteAuthentication", auth_id);
	}
	
	
}
