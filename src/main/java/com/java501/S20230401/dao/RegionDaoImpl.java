package com.java501.S20230401.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Region;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class RegionDaoImpl implements RegionDao {
	private final SqlSession session;
	
	
	// 유현규
	@Override
	public Region getRegion(int regionCode) {
		return session.selectOne("hgGetRegion", regionCode);
	}
	
	@Override
	public List<Region> getSuperRegions() {
		return session.selectList("hgGetSuperRegions");
	}
	
	@Override
	public List<Region> getChildRegions(int parentRegionCode) {
		return session.selectList("hgGetChildRegions", parentRegionCode);
	}
	
	
	
	
	
	// 임동빈
	@Override
	public List<Region> regionName() {
		List<Region> regionList = null;
		System.out.println("RegionDaoImpl regionName Start..");
		regionList = session.selectList("SelectRegion");
		System.out.println("RegionDaoImpl regionList.size()=> " + regionList.size());
		return regionList;
	}
	
	@Override
	public List<Region> parentRegionName() {
		List<Region> parentRegionList = null;
		parentRegionList = session.selectList("SelectParentRegion");
		return parentRegionList;
	}

	
	// 양동균
	@Override
	public List<Region> dgRegionList() {
		List<Region> regionList = null;
		try {
			regionList = session.selectList("dgRegionList"); // 지역 대분류
		} catch (Exception e) {
			e.printStackTrace();
		}
		return regionList;
	}
	@Override
	public List<Region> dgSelectRegion(Region region) {
		List<Region> regionList = null;
		try {
			regionList = session.selectList("dgSelectRegion", region); // 선택 지역 소분류
		} catch (Exception e) {
			e.printStackTrace();
		}
		return regionList;
	}
	
	
}
