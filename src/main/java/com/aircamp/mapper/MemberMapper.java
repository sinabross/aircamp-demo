package com.aircamp.mapper;

import com.aircamp.domain.MemberVO;

public interface MemberMapper {

	// memberjoin
	public void memberjoin(MemberVO vo);

	// idcheck
	public Integer idcheck(String id);

	//idread
	public MemberVO idread(String id);
	
	//memberupdate
	public int memberupdate(MemberVO vo);
	
	//memberdelete
	public int memberdelete(String id);
	

	// memberjoinAuth 새로운 맴버가 회원가입할 때 auth테이블에 맴버의 권한을 ROLE_MEMBER 입력함
	public void memberjoinAuth(MemberVO vo);
	
	// id 찾기
	public String findId(MemberVO vo);

	public String findPw(MemberVO vo);
	
}
