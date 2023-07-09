package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class Trade {
	private Integer 	trd_id;
	private Integer 	mem_id;
	private Integer 	trd_status;
	private Integer 	trd_max;
	private Date 		trd_enddate;
	private Integer 	trd_cost;
	private Integer 	reg_id;
	private String 		trd_loc;
	private Integer 	trd_gender;
	private Integer 	trd_minage;
	private Integer 	trd_maxage;
	
	// 양동균
	// 참조
	private Member 	member;
	private Comm 	comm;
	private Region 	region;
}
