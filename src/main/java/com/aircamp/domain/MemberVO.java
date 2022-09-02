package com.aircamp.domain;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class MemberVO {
	// 필수
	private String m_id;
	private String m_name;
	private String m_pw;
	private String m_phone;
	// 선택
	private String m_email;
	private String m_katalk;
	private String m_path;
	private String m_uuid;
	private String m_filename;
	// 신뢰도
	private int m_score; // default 0 ��������
	private int m_eval; // default 0 ���ڼ�

	// private int m_admin; //M_ADMIN(������) = 1, M_NORMAL(�Ϲ�ȸ��) = 0
	private int m_status; // M_MEMBER = 1, 탈퇴한 회원 0

	// private String m_role;
	private List<AuthVO> m_authList;
}
