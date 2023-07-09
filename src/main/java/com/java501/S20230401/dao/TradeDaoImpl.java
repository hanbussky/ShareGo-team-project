package com.java501.S20230401.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Trade;
import com.java501.S20230401.model.TradeInfo;
import com.java501.S20230401.util.TradeType;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class TradeDaoImpl implements TradeDao {
	private final SqlSession session;
	
	// 유현규
	@Override
	public List<TradeInfo> hgGetTradesByType(Trade searcher, TradeType type) {
		return session.selectList("hgGetRecent" + type.toString() + "Trade", searcher);
	}
	
	// 양동균
	@Override
	public int updateShare(Article article) {
		int result = 0;
		try {
			result = session.update("dgUpdateTrade", article.getTrade());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public void shareTradeStatus(Article article) {
		int result = 0;
		try {
			Trade trade = session.selectOne("dgGetTrade", article);
			// 최대인원 확인
			result = session.selectOne("dgShareTradeMax", trade);
			if(result > 0) {
				trade.setTrd_status(402);
				result = session.update("dgShareTradeStatus",trade);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
