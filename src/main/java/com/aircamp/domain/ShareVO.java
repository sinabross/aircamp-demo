package com.aircamp.domain;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ShareVO {
	//필수
	private Long s_id;// seq_share_id사용
	private Long i_id;
	private String m_id;
	private String s_sdate;
	private String s_edate;
	private int s_price;
	private String s_addr;
	private Date s_regdate;// DEFAULT SYSDATE

	//후기관련 칼럼들
	private String s_opi;
	private Date s_opidate;// DEFAULT SYSDATE
	private int s_score_m;// DEFAULT 0
	private int s_score_i;// DEFAULT 0 0(�ݳ���)������, 1(�ݳ���)�����µ� (�ı�)�ۼ� ����, 2(�ݳ���)������
							// (�ı�)�ۼ���
	private int s_opi_chk;// DEFAULT 0
}
