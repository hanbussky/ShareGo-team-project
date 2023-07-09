package com.java501.S20230401.service;

import java.util.List;

import com.java501.S20230401.model.Region;

public interface RegionService {
	// 유현규
	public Region getRegion(int regionCode);
	public List<Region> getSuperRegions();
	public List<Region> getChildRegions(int parentRegionCode);
	
	// 양동균
	public List<Region> dgRegionList();
	public List<Region> dgSelectRegion(Region region);
}
