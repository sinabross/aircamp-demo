package com.aircamp.mapper;

import com.aircamp.domain.MemberVO;

public interface CommonMapper {

	//test용
	public String commonMapperTest();
	
	//login
	public MemberVO login(String m_id);

	//public MemberVO findId(String m_id, String )
}
