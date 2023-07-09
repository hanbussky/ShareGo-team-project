package com.java501.S20230401.service;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Favorite;

public interface FavoriteService {

	// 김찬영
	int 		cyFavorite(Favorite favorite);

	// 양동균
	int shareFavoriteAdd(Article article);		// 찜목록 추가
	int shareFavoriteDel(Article article);	// 찜 삭제
	int dgUserFavorite(Article shareUser);	// 찜목록 조회

}
