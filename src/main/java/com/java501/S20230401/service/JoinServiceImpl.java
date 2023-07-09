package com.java501.S20230401.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.JoinDao;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Join;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JoinServiceImpl implements JoinService{
	private final JoinDao jd;
	
	// 양동균
	@Override
	public int shareJoinAdd(Article article) {
		return jd.shareJoinAdd(article);
	}
	@Override
	public int shareJoinDel(Article article) {
		return jd.shareJoinDel(article);
	}
	@Override
	public List<Join> shareJoinList(Integer trd_id) {
		return jd.shareJoinList(trd_id);
	}
	@Override
	public int shareUserJoin(Article shareUser) {
		return jd.shareUserJoin(shareUser);
	}

}
