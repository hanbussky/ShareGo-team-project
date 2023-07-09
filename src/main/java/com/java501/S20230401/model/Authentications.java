package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class Authentications {
	private Integer auth_id;
	private Integer mem_id;
	private String auth_value;
	private Date auth_regdate;
	private Date auth_expiredate;
}
