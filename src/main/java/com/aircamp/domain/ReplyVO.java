package com.aircamp.domain;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ReplyVO {
	private Long r_id;//seq_reply_id ���
	private Long c_id;
	private String m_id;
	private String r_content;
	private Date r_regdate;//DEFAULT SYSDATE
	}
