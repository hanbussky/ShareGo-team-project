package com.java501.S20230401.model;

import lombok.Data;

@Data
public class Board {
	private Integer brd_id;
	private Integer read_auth;
	private Integer write_auth;
	private Integer reply_auth;
	
	// 양동균
	// 참조
	private Comm comm;
}
