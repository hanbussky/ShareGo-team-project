package com.java501.S20230401.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.WaitingDao;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Waiting;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WaitingServiceImpl implements WaitingService {
	private final WaitingDao wd;
	
	// 양동균
	// 대기열 추가
	@Override
	public int shareWaitingAdd(Article article) { return wd.shareWaitingAdd(article);	}
	// 대기열 조회
	@Override
	public List<Waiting> dgShareWaitingList(Integer trd_id) { return wd.dgShareWaitingList(trd_id);	}
	// 대기열 여부
	@Override
	public int dgUserWaiting(Article shareUser) { return wd.dgUserWaiting(shareUser); }
	@Override
	public int shareWaitingDel(Article article) { return wd.shareWaitingDel(article);	}

}
