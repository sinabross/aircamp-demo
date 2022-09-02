package com.aircamp.domain;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ShareMemberVO {
	private int s_id;//seq_share_id ���
	private int i_id;
	private String s_sdate;
	private String s_edate;
	private int s_price;
	private String s_addr;
	private Date s_regdate;
	private String s_opi;
	private Date s_opidate;//DEFAULT SYSDATE
	private int s_score_m;// DEFAULT 0
	private int s_score_i;// DEFAULT 0 0(�ݳ���)������,	1(�ݳ���)�����µ� (�ı�)�ۼ� ����, 2(�ݳ���)������ (�ı�)�ۼ���
	private int s_opi_chk;//DEFAULT 0
	
	//�ʼ��Է�
	private String m_id;
	private String m_name;
	private String m_pw;
	private String m_phone;
	//�����Է�
	private String m_email;
	private String m_katalk;
	private String m_uuid;
	private String m_path;
	private String m_filename;
	//����
	private int m_score; //default 0 ��������
	private int m_eval; //default 0 ���ڼ�
	
	
	private int	m_status; //M_NORMAL(ȸ��) = 0, M_SIGNOUT(Ż���� ȸ��)=1
	
}
