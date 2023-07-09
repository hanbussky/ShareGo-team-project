package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class ArticleMember {
	// From Article Table
	private int 	art_id;
	private int 	brd_id;
	private String 	art_title;
	private String	art_content;
	private int 	mem_id;
	private Date 	art_regdate;
	private String 	art_tag1;
	private String 	art_tag2;
	private String 	art_tag3;
	private String 	art_tag4;
	private String 	art_tag5;
	private int 	trd_id;
	private int 	art_good;
	private int 	art_bad;
	private int 	art_read;
	private int 	art_isnotice;
	private int 	art_isdelete;
	private int 	art_report_id;
	
	// From Member Table
	private String 	mem_username;
	private String 	mem_password;
	private String 	mem_nickname;
	private String 	mem_email;
	private String 	mem_tel;
	private int 	mem_region1;
	private int 	mem_region2;
	private int 	mem_authority;
	private Date 	mem_regdate;
	private String 	mem_image;
	private int 	mem_gender;
	private String 	mem_name;
	private Date 	mem_birthday;
	private Date 	mem_latest;
	private int 	mem_isdelete;
	private int 	mem_report_id;
	
	// For Trust Value
	private int his_good;
	private int his_normal;
	private int his_bad;
	
	// For EndDate
	private Date trd_enddate;
	
	// For Comment Count
	private int rep_count;
	
	// For Board Name
	private String brd_name;
}
