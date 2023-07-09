package com.java501.S20230401.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.RegionDao;
import com.java501.S20230401.model.Region;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RegionServiceImpl implements RegionService {
	private final RegionDao rd;
	
	// 유현규
	@Override
	public Region getRegion(int regionCode) {
		return rd.getRegion(regionCode);
	}
	
	@Override
	public List<Region> getSuperRegions() {
		return rd.getSuperRegions();
	}
	
	@Override
	public List<Region> getChildRegions(int parentRegionCode) {
		return rd.getChildRegions(parentRegionCode);
	}
	
	
	
	// 양동균
	@Override
	public List<Region> dgRegionList() {
		return rd.dgRegionList();
	}
	@Override
	public List<Region> dgSelectRegion(Region region) {
		return rd.dgSelectRegion(region);
	}
}
