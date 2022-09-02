package com.aircamp.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CommunityVO {
	private Long c_id; //pk seq_comm_id
	private String m_id;
	private String c_title;
	private String c_content;
	private Date c_regdate; //sysdate
	private int c_read_cnt; //default 0
}
