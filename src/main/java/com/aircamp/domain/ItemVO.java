package com.aircamp.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class ItemVO {
	//�ʼ�
	private Long i_id;// seq_item_id ���
	private String m_id;//�����۵���� ���(ȣ��Ʈ)
	private String i_sdate;
	private String i_edate;
	private int i_score;//default 0
	private int i_eval;//default 0
	private Date i_regdate;//default SYSDATE ������ ������ ����� ����Ұ� 
	private String i_title;
	private int i_price;
	private String i_info;
	private String i_phone;//000-0000-0000����
	//����
	private String i_email;
	private String i_katalk;
	//�ʼ�
	private String i_addr;
	private int	i_status;//	I_DELETED(������ ������ ���)=0, ������ �������� �ʾ��� ��� = 1

	private List<GalleryVO> galleryList;
	private List<MemberVO> memberList;
	private List<ShareVO> shareList;
}
