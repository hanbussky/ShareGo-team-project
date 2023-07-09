package com.java501.S20230401.service;

import java.util.List;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Join;

public interface JoinService {



	// 양동균
	int shareJoinAdd(Article article);
	int shareJoinDel(Article article);
	List<Join> shareJoinList(Integer trd_id);
	int shareUserJoin(Article shareUser);

}
