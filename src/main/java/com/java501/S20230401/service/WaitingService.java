package com.java501.S20230401.service;

import java.util.List;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Waiting;

public interface WaitingService {

	// 양동균
	int shareWaitingAdd(Article article); // 대기열 추가
	List<Waiting> dgShareWaitingList(Integer trd_id); // 대기열 조회
	int dgUserWaiting(Article shareUser); // 대기열 여부
	int shareWaitingDel(Article article); // 대기열 추가

}
