package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class Join {
	private Integer	trd_id;		// PK
	private Integer	mem_id;		// PK
	private Date	join_date;
	
	// 참조
	private Member 	member;
}
