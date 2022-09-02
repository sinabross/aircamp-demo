package com.aircamp.service;

import com.aircamp.domain.MemberVO;

public interface MemberService {

	// memberjoin
	public void memberjoin(MemberVO member);

	// idcheck
	public Integer idcheck(String id);

	// idread
	public MemberVO idread(String id);

	// memberupdate
	public boolean memberupdate(MemberVO member);

	// memberdelete
	public boolean memberdelete(String id);

	public String findId(MemberVO vo);

	public String findPw(MemberVO vo);

}
