package com.java501.S20230401.service;

import java.util.List;

import com.java501.S20230401.model.Trade;
import com.java501.S20230401.model.TradeInfo;
import com.java501.S20230401.util.TradeType;

import com.java501.S20230401.model.Article;

public interface TradeService {
	// 유현규
	public List<TradeInfo> hgGetTradesByType(Trade searcher, TradeType type);
	
	
	// 양동균
	int updateShare(Article article); // 거래글 수정
	void shareTradeStatus(Article article); // 거래 상태 변경

}
