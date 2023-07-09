package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class Nickname {
	private Integer mem_id;
	private Date 	nick_date;
	private String 	nick_prev;
	private String 	nick_curr;
}
