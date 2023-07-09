package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class MemberInfo {
	// Member data
	private Integer mem_id;
	private String 	mem_username;
	private String 	mem_password;
	private String 	mem_nickname;
	private String 	mem_email;
	private String 	mem_tel;
	private Integer mem_region1;
	private Integer mem_region2;
	private Integer mem_authority;
	private Date 	mem_regdate;
	private String 	mem_image;
	private Integer mem_gender;
	private String 	mem_name;
	private Date 	mem_birthday;
	private Date 	mem_latest;
	private Integer isdelete;
	private Integer report_id;

	// Article data
	private Integer art_count;
	
	// Reply data
	private Integer rep_count;
	
	// Trade data
	private Integer his_good;
	private Integer his_normal;
	private Integer his_bad;
	
}
