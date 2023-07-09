package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class TradeInfo {
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
	
	private Integer		art_id;
	private Integer		brd_id;
	private String		art_title;
	private Date		art_regdate;
	private String		art_content;
	private String		art_tag1;
	private String		art_tag2;
	private String		art_tag3;
	private String		art_tag4;
	private String		art_tag5;
	private String		trd_statusname;
	private String		trd_gendername;
	private String		reg_name;
	
	private Date		wait_date;
	private Date		join_date;
	
	private Integer		join_count;
}
