package com.aircamp.domain;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class QnaVO {
	//�ʼ�
	private Long q_id;// seq_qna_id ���
	private String m_id;
	private String q_email;
	private String q_title;
	private String q_content;
	private Date q_regdate;//DEFAULT SYSDATE
	
}
