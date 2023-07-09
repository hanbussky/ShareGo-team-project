package com.java501.S20230401.service;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.FavoriteDao;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Favorite;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FavoriteServiceImpl implements FavoriteService {
	private final FavoriteDao fd;
	
	@Override
	public int cyFavorite(Favorite favorite) {
		System.out.println("관심서버 임플 insert");
		int result = fd.cyFavorite(favorite);
		return result;
	}
	
	
	// 양동균
	// 찜목록 추가
	@Override
	public int shareFavoriteAdd(Article article) {	return fd.shareFavoriteAdd(article); }
	// 찜목록 삭제
	@Override
	public int shareFavoriteDel(Article article) {	return fd.shareFavoriteDel(article); }
	@Override
	// 찜목록 조회
	public int dgUserFavorite(Article shareUser) { return fd.dgUserFavorite(shareUser); }
}
