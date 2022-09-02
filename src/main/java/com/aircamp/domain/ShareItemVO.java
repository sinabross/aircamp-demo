package com.aircamp.domain;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ShareItemVO {
	//필수
	private int s_id;// seq_share_id사용
	private int i_id;
	private String m_id;
	private String s_sdate;
	private String s_edate;
	private int s_price;
	private String s_addr;
	private Date s_regdate;// DEFAULT SYSDATE

	private String i_title;
	
	
}
